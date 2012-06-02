//
//  AppDelegate.m
//  GestureDemo3
//
//  Created by 刘 大兵 on 12-5-2.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TableViewGestureController.h"
#import "ScrollViewGestureController.h"
#import "DragController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    ViewController *viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    TableViewGestureController *tableGestureController = [[[TableViewGestureController alloc]init]autorelease];
    ScrollViewGestureController *scrollViewGesture = [[[ScrollViewGestureController alloc]init]autorelease];
    DragController *dragController = [[[DragController alloc]init]autorelease];
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    [tabBarController setViewControllers:[NSArray arrayWithObjects:viewController,tableGestureController,scrollViewGesture,dragController, nil]];
    self.window.rootViewController = tabBarController;
    [tabBarController release];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
