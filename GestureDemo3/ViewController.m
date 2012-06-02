//
//  ViewController.m
//  GestureDemo3
//
//  Created by 刘 大兵 on 12-5-2.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "ViewController.h"
#import "GestureView.h"

#define kViewTag1 100
#define kViewTag2 101

@implementation ViewController
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    GestureView *gestureView = [[GestureView alloc]initWithFrame:CGRectMake(50, 50, 220, 200)];
    gestureView.tag = kViewTag1;
    [self.view addSubview:gestureView];
    UILongPressGestureRecognizer *tapGesture = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(longGesture:)];
    tapGesture.delegate = self;
    [gestureView addGestureRecognizer:tapGesture];
    [tapGesture release];
    [gestureView release];
    
    gestureScrollView.tag = kViewTag2;
    gestureScrollView.backgroundColor = [UIColor lightGrayColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(50, 50, 100, 50)];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(buttonClick)
     forControlEvents:UIControlEventTouchUpInside];
    [gestureScrollView addSubview:button];
    //[button release];
    
    NSArray *imagePathArray = [NSArray arrayWithObjects:@"images.jpeg",
                               @"images-1.jpeg",@"images-2.jpeg", nil];
    gestureScrollView.contentSize = CGSizeMake(gestureScrollView.bounds.size.width*(imagePathArray.count+1), gestureScrollView.bounds.size.height);
    gestureScrollView.pagingEnabled = YES;
    for (NSInteger i=0; i<imagePathArray.count; i++) {
        NSString *imageName = [imagePathArray objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:
                                  CGRectMake(gestureScrollView.bounds.size.width*(i+1), 0, gestureScrollView.bounds.size.width, gestureScrollView.bounds.size.height)];
        imageView.image = [UIImage imageNamed:imageName];
        [gestureScrollView addSubview:imageView];
        [imageView release];
    }
    
    UITapGestureRecognizer *scrollViewTap = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(scrollViewTap:)];
    scrollViewTap.delegate = self;
    [gestureScrollView addGestureRecognizer:scrollViewTap];
    [scrollViewTap release];
}

-(void)longGesture:(UILongPressGestureRecognizer*)theLong{
    if (theLong.state==UIGestureRecognizerStateBegan) {
        theLong.view.backgroundColor = [theLong.view.backgroundColor colorWithAlphaComponent:0.5];
    }else if(theLong.state==UIGestureRecognizerStateEnded){
        theLong.view.backgroundColor = [theLong.view.backgroundColor colorWithAlphaComponent:1];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.view.tag==kViewTag1) {
        CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view];
        CGRect forbidenTouchRect = CGRectMake(50, 50, 100, 100);
        if (CGRectContainsPoint(forbidenTouchRect, touchPoint)) {
            return NO;
        }
    }else if(gestureRecognizer.view.tag==kViewTag2){
        CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view];
        if (touchPoint.x<320) {
            return NO;
        }
    }
    return YES;
}

-(void)buttonClick{
    UIAlertView *buttonAlert = [[UIAlertView alloc]initWithTitle:@"提醒"
                                                         message:@"按钮"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确认", nil];
    [buttonAlert show];
    [buttonAlert release];
}

-(void)scrollViewTap:(UITapGestureRecognizer*)theTap{
    NSInteger pageIndex = floor([theTap locationInView:gestureScrollView].x/gestureScrollView.bounds.size.width);
    UIAlertView *buttonAlert = [[UIAlertView alloc]initWithTitle:@"提醒"
                                                         message:[NSString stringWithFormat:@"图片%d",pageIndex]
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确认", nil];
    [buttonAlert show];
    [buttonAlert release];
}
@end
