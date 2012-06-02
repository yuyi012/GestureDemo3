//
//  GestureScrollView.m
//  GestureDemo3
//
//  Created by 俞 億 on 12-5-2.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "GestureScrollView.h"

@interface GestureScrollView ()

@end

@implementation GestureScrollView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    NSArray *gestureArray = touch.gestureRecognizers;
    for (UIGestureRecognizer *gesture in gestureArray) {
        NSLog(@"gesture:%@",NSStringFromClass([gesture class]));
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
@end
