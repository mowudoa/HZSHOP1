//
//  HZConstant.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/25.
//  Copyright © 2019年 英峰. All rights reserved.
//
#import <UIKit/UIKit.h>

//---------------系统常量---------------

#define NOMOREDATA_STRING @"没有更多了"

#define YY_APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication]delegate])//APPdelegate

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width //屏幕宽度

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height //屏幕高度

#define SCREEN_STATUSRECT [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度

#define SCREEN_NAVRECT    self.navigationController.navigationBar.frame.size.height //导航栏高度

#define SCREEN_TABBARRECT      ((AppDelegate *)[[UIApplication sharedApplication]delegate]).tabBarControll.tabBar.frame.size.height //标签栏高度

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define HEIGHT(f) f * (SCREEN_WIDTH/320.0) //屏幕比例 算出实际UI大小

//RGB颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//请求状态码
#define SUCCESS     [[NSString stringWithFormat:@"%d",[dic[@"code"] intValue]] isEqualToString:@"200"]

#define FAILURE     [[NSString stringWithFormat:@"%d",[dic[@"status"] intValue]] isEqualToString:@"400"]

#define IPHONEX_Y_N  (SCREEN_STATUSRECT == 44)//是否为iPhone X

#define BOTTOM_SAFEAREA (IPHONEX_Y_N ? 34:0)//底部安全距离

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]  //实例化


//常量
UIKIT_EXTERN NSString *const HZOrderPayNow;
UIKIT_EXTERN NSString *const HZOrderCancleOrder;
UIKIT_EXTERN NSString *const HZOrderApplyForRefund;
UIKIT_EXTERN NSString *const HZOrderGoEvaluate;
UIKIT_EXTERN NSString *const HZOrderConfirmReceive;
UIKIT_EXTERN NSString *const HZOrderLogisticsInfo;
UIKIT_EXTERN NSString *const HZOrderAfterSales;
UIKIT_EXTERN NSString *const HZOrderPayed;
UIKIT_EXTERN NSString *const Address_Add_Success;
UIKIT_EXTERN NSString *const Address_Delete_Success;
UIKIT_EXTERN NSString *const Address_Delete_Faile;
UIKIT_EXTERN NSString *const Shop_AddCart_Success;
