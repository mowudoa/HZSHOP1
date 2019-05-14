//
//  HZOrderDetailViewController.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/19.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "XTBaseBackViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,CellType){
    
    OrderStatusType = 100,
    AddressTYpe,
    OrderGoodsType,
    OrderCodeType,
    OrderPriceType
    
};

@interface HZOrderDetailViewController : XTBaseBackViewController

@property(nonatomic,copy) NSString *orderId;

@end

NS_ASSUME_NONNULL_END
