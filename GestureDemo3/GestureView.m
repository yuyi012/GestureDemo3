//
//  GestureView.m
//  GestureDemo3
//
//  Created by 刘 大兵 on 12-5-2.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "GestureView.h"

@implementation GestureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(50, 50, 100, 100));
}

@end
