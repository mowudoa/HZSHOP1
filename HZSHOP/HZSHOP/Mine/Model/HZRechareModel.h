//
//  HZRechareModel.h
//  HZSHOP
//
//  Created by 英峰 on 2019/5/14.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "rootModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZRechareModel : rootModel

@property(copy,nonatomic)NSString* rechargeStatus; //充值状态

@property(copy,nonatomic)NSString* rechargeTime; //充值时间

@property(copy,nonatomic)NSString* rechargeMoney; //充值金额

@property(copy,nonatomic)NSString* rechargeRemark; //充值备注

@property(copy,nonatomic)NSString* rechargeType; //充值类型

@end

NS_ASSUME_NONNULL_END
