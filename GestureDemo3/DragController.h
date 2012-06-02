//
//  DragController.h
//  GestureDemo3
//
//  Created by 俞 億 on 12-5-2.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureTableView.h"

@interface DragController : UIViewController<UITableViewDelegate,UITableViewDataSource,GestureTableDelegate>{
    GestureTableView *groupView;
    GestureTableView *personView;
    NSMutableArray *groupArray;
    UILabel *dragPersonLabel;
    NSIndexPath *preSelectIndexPath;
    NSIndexPath *preSelectPersonIndexPath;
}
@end
