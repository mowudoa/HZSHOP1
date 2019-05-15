//
//  HZCartModel.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "rootModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZCartModel : rootModel

@property(copy,nonatomic)NSString* goodsNum;//商品数量

@property(copy,nonatomic)NSString* goodsOldPrice;//购买原价

@property(copy,nonatomic)NSString* goodsSpecs;//规格

@property(copy,nonatomic)NSString* goodsOptionid;//optionid

@property(copy,nonatomic)NSString* goodsId;//商品id

@property(copy,nonatomic)NSString* goodsSalesPrice;//购买价格

@property(copy,nonatomic)NSString* goodsStockNum;//库存

@property(assign,nonatomic)BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
