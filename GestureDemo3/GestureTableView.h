//
//  GestureTableView.h
//  GestureDemo3
//
//  Created by 俞 億 on 12-5-2.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GestureTableDelegate <NSObject>
-(void)personDrag:(UILongPressGestureRecognizer*)theLong;
@end

@interface GestureTableView : UITableView{
    
}
@property(nonatomic,assign) id<GestureTableDelegate> gestureDelegate;
@end
