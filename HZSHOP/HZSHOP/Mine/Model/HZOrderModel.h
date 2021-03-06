//
//  HZOrderModel.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/17.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "rootModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZOrderModel : rootModel

@property(copy,nonatomic)NSString* orderStatus; //订单状态

@property(copy,nonatomic)NSString* orderStatusString; //订单状态字符串

@property(copy,nonatomic)NSString* orderEvaluateStatus; //订单评价状态

@property(copy,nonatomic)NSString* orderRefundStatus; //订单退款状态

@property(copy,nonatomic)NSString* orderPrice; //订单价格

@property(copy,nonatomic)NSString* orderCode; //订单号

@property(copy,nonatomic)NSString* orderGoodsNum; //订单商品数量

@property(copy,nonatomic)NSString* orderTime; //订单时间

@property(copy,nonatomic)NSString* orderNeedPayPrice; //订单实际支付价格

@property(copy,nonatomic)NSString* orderType; //订单类型

@property(nonatomic,strong) NSMutableArray *goodsArray;

@end

NS_ASSUME_NONNULL_END
