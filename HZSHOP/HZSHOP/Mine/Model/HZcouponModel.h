//
//  HZcouponModel.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/13.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "rootModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZcouponModel : rootModel

@property(nonatomic,copy) NSString *couponMoney;//优惠金额

@property(nonatomic,copy) NSString *couponLimit;//使用门槛

@property(nonatomic,copy) NSString *couponInfo;//详细信息

@property(nonatomic,copy) NSString *couponNum;//数量

@property(nonatomic,copy) NSString *couponStockNum;//库存

@property(nonatomic,copy) NSString *couponLifeTime;//有效期

@property(nonatomic,copy) NSString *couponBuyMoney;//购买金额

@property(nonatomic,copy) NSString *couponBuyIntegral;//购买积分

@end

NS_ASSUME_NONNULL_END
