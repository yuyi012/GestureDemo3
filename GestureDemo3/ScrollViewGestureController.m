//
//  ScrollViewGestureController.m
//  GestureDemo3
//
//  Created by 俞 億 on 12-5-2.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "ScrollViewGestureController.h"

@interface ScrollViewGestureController ()

@end

@implementation ScrollViewGestureController

-(void)loadView{
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 416)];
    self.view = container;
    [container release];
    
    scrollView = [[GestureScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
    
    NSArray *imagePathArray = [NSArray arrayWithObjects:@"images.jpeg",
                               @"images-1.jpeg",@"images-2.jpeg", nil];
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width*(imagePathArray.count+1), scrollView.bounds.size.height);
    scrollView.pagingEnabled = YES;
    for (NSInteger i=0; i<imagePathArray.count; i++) {
        NSString *imageName = [imagePathArray objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:
                                  CGRectMake(scrollView.bounds.size.width*(i+1), 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        [imageView release];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self
//                                                                                action:@selector(panGesture:)];
//    [scrollView addGestureRecognizer:panGesture];
//    [panGesture release];
}

-(void)panGesture:(UIPanGestureRecognizer*)thePan{
    NSLog(@"pan");
}

@end
