//
//  HZRegisterViewController.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/12.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "XTBaseBackViewController.h"



NS_ASSUME_NONNULL_BEGIN

typedef enum {
    userRegisterType,
    forgetLoginPassWordType,
    forgetPayPassWordType
}registerOrChangePassType;

@interface HZRegisterViewController : XTBaseBackViewController

@property(nonatomic)registerOrChangePassType registerOrChangePass;

@end

NS_ASSUME_NONNULL_END
