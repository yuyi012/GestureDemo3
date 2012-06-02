//
//  GestureTableView.m
//  GestureDemo3
//
//  Created by 俞 億 on 12-5-2.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "GestureTableView.h"

@implementation GestureTableView
@synthesize gestureDelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    NSArray *gestureArray = touch.gestureRecognizers;
    for (UIGestureRecognizer *gesture in gestureArray) {
        NSLog(@"gesture:%@",NSStringFromClass([gesture class]));
        if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
            if ([gestureDelegate respondsToSelector:@selector(personDrag:)]) {
                [gestureDelegate performSelector:@selector(personDrag:) withObject:gesture];
            }
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
}
@end
