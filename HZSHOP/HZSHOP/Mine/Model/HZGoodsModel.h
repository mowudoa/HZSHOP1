//
//  HZGoodsModel.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/11.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "rootModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZGoodsModel : rootModel

@property(nonatomic,copy) NSString *goodsPrice;//现价

@property(nonatomic,copy) NSString *goodsOldPrice;//原件

@property(nonatomic,copy) NSString *goodsId;//商品id


@property(nonatomic,copy) NSString *goodsTime;//日期


@end

NS_ASSUME_NONNULL_END
