//
//  HZAddressModel.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "rootModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZAddressModel : rootModel

@property(copy,nonatomic)NSString* addressDetail;//详细地址

@property(copy,nonatomic)NSString* userPhone;//电话

@property(copy,nonatomic)NSString* is_default;//是否为默认

@property(copy,nonatomic)NSString* userName;//名字

@property(copy,nonatomic)NSString* address;//地址

@end

NS_ASSUME_NONNULL_END
