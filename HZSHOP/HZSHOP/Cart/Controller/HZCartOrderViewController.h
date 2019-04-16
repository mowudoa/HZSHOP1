//
//  HZCartOrderViewController.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/15.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "XTBaseBackViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,CellType){
    
    AddressType = 100,
    GoodsType,
    LeaveMessageType,
    CouponType,
    GoodsPriceType
    
};

@interface HZCartOrderViewController : XTBaseBackViewController

@end

NS_ASSUME_NONNULL_END
