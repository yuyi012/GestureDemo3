//
//  DragController.m
//  GestureDemo3
//
//  Created by 俞 億 on 12-5-2.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "DragController.h"

#define kGroupViewTag 100
#define kPersonViewTag 101

@interface DragController ()

@end

@implementation DragController

-(void)loadView{
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 416)];
    self.view = container;
    [container release];
    groupView = [[GestureTableView alloc]initWithFrame:CGRectMake(0, 0, 120, 416)];
    groupView.tag = kGroupViewTag;
    groupView.delegate = self;
    groupView.dataSource = self;
    [self.view addSubview:groupView];
    personView = [[GestureTableView alloc]initWithFrame:CGRectMake(120, 0, 200, 416)];
    personView.tag = kPersonViewTag;
    personView.delegate = self;
    personView.dataSource = self;
    personView.gestureDelegate = self;
    [self.view addSubview:personView];
    
    dragPersonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    dragPersonLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:dragPersonLabel];
    dragPersonLabel.hidden = YES;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(personDragPan:)];
    [self.view addGestureRecognizer:panGesture];
    [panGesture release];
}

- (void)dealloc
{
    [groupView release];
    [personView release];
    [groupArray release];
    [dragPersonLabel release];
    [preSelectIndexPath release];
    [preSelectPersonIndexPath release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *groupPath = [[NSBundle mainBundle]pathForResource:@"contactList" ofType:@"plist"];
    groupArray = (NSMutableArray*)CFPropertyListCreateDeepCopy(kCFAllocatorSystemDefault, (CFArrayRef)[[NSArray alloc]initWithContentsOfFile:groupPath], kCFPropertyListMutableContainers);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight;
    if (tableView.tag==groupView.tag) {
        rowHeight = 80;
    }else if (tableView.tag==personView.tag) {
        rowHeight = 50;
    }
    return rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rowCount;
    if (tableView.tag==groupView.tag) {
        rowCount = groupArray.count;
    }else if (tableView.tag==personView.tag) {
        NSMutableDictionary *groupDic = [groupArray objectAtIndex:[groupView indexPathForSelectedRow].row];
        NSArray *memberArray = [groupDic objectForKey:@"memberArray"];
        rowCount = memberArray.count;
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (tableView.tag==groupView.tag) {
        UITableViewCell *groupCell = [tableView dequeueReusableCellWithIdentifier:@"groupCell"];
        if (groupCell==nil) {
            groupCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:@"groupCell"]autorelease];
            groupCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        NSMutableDictionary *groupDic = [groupArray objectAtIndex:indexPath.row];
        groupCell.textLabel.text = [groupDic objectForKey:@"groupName"];
        cell = groupCell;
    }else if (tableView.tag==personView.tag) {
        UITableViewCell *personCell = [tableView dequeueReusableCellWithIdentifier:@"personCell"];
        if (personCell==nil) {
            personCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:@"personCell"]autorelease];
        }
        NSMutableDictionary *groupDic = [groupArray objectAtIndex:[groupView indexPathForSelectedRow].row];
        NSArray *memberArray = [groupDic objectForKey:@"memberArray"];
        personCell.textLabel.text = [memberArray objectAtIndex:indexPath.row];
        cell = personCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==kGroupViewTag) {
        [personView reloadData];
    }
}

-(void)personDrag:(UILongPressGestureRecognizer*)theLong{
    CGPoint touchPoint = [theLong locationInView:personView];
    NSLog(@"touchPoint:%@",NSStringFromCGPoint(touchPoint));
    for (NSIndexPath *indexPath in [personView indexPathsForVisibleRows]) {
        CGRect cellFrame = [personView rectForRowAtIndexPath:indexPath];
        if (CGRectContainsPoint(cellFrame, touchPoint)) {
            NSMutableDictionary *groupDic = [groupArray objectAtIndex:[groupView indexPathForSelectedRow].row];
            NSArray *memberArray = [groupDic objectForKey:@"memberArray"];
            dragPersonLabel.text = [memberArray objectAtIndex:indexPath.row];
            dragPersonLabel.hidden = NO;
            dragPersonLabel.center = [theLong locationInView:self.view];
            groupView.scrollEnabled = NO;
            personView.scrollEnabled = NO;
            [preSelectIndexPath release];
            preSelectIndexPath = [[groupView indexPathForSelectedRow]retain];
            [preSelectPersonIndexPath release];
            preSelectPersonIndexPath = [indexPath retain];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 dragPersonLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
                                 dragPersonLabel.alpha = 0.7;
                             }];
            break;
        }
    }
}

-(void)personDragPan:(UIPanGestureRecognizer*)thePan{
    if (thePan.state==UIGestureRecognizerStateChanged) {
        CGPoint touchPoint = [thePan locationInView:self.view];
        dragPersonLabel.center = touchPoint;
        if (CGRectContainsPoint(groupView.frame,touchPoint)) {
            dragPersonLabel.backgroundColor = [UIColor blueColor];
            for (NSIndexPath *indexPath in [groupView indexPathsForVisibleRows]) {
                CGRect cellFrame = [groupView rectForRowAtIndexPath:indexPath];
                if (CGRectContainsPoint(cellFrame, touchPoint)) {
                    [groupView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                    break;
                }
            }
        }else {
            dragPersonLabel.backgroundColor = [UIColor yellowColor];
        }
    }else if (thePan.state==UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             dragPersonLabel.transform = CGAffineTransformIdentity;
                             dragPersonLabel.alpha = 1;
                         }completion:^(BOOL finish){
                             groupView.scrollEnabled = YES;
                             personView.scrollEnabled = YES;
                             dragPersonLabel.hidden = YES;
                             NSMutableDictionary *groupDic = [groupArray objectAtIndex:preSelectIndexPath.row];
                             NSMutableArray *memberArray = [groupDic objectForKey:@"memberArray"];
                             NSLog(@"memberArray:%@,row:%d",memberArray,preSelectPersonIndexPath.row);
                             [memberArray removeObject:dragPersonLabel.text];
                             NSLog(@"memberArray:%@",memberArray);
//                             [personView deleteRowsAtIndexPaths:[NSArray arrayWithObject:preSelectPersonIndexPath]
//                                              withRowAnimation:UITableViewRowAnimationLeft];
                             [personView reloadData];
                             NSMutableDictionary *currentGroupDic = [groupArray objectAtIndex:[groupView indexPathForSelectedRow].row];
                             NSMutableArray *currentMemberArray = [currentGroupDic objectForKey:@"memberArray"];
                             [currentMemberArray addObject:dragPersonLabel.text];
                             [personView insertRowsAtIndexPaths:[NSArray arrayWithObject:
                                                                 [NSIndexPath indexPathForRow:currentMemberArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
                         }];
    }
}
@end
