//
//  AppDelegate.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/9.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "crazyShakeWindow.h"
#import "XTBaseTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) crazyShakeWindow *window;

@property (strong,nonatomic)XTBaseTabBarViewController *tabBarControll;

@end

