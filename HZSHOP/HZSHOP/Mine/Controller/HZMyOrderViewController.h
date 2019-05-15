//
//  HZMyOrderViewController.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/17.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "XTBaseBackViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    WXMyOrderAll,
    WXMyOrderUnPay,
    WXMyOrderUnSend,
    WXMyOrderUnReceive,
    WXMyOrderUnEvaluate,
    WXMyOrderComplete
}WXMyOrder;

@interface HZMyOrderViewController : XTBaseBackViewController

@property(nonatomic)WXMyOrder orderType;

@end

NS_ASSUME_NONNULL_END
