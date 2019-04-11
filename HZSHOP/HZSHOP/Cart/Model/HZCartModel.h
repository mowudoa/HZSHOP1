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

@property(copy,nonatomic)NSString* goodsnum;

@property(copy,nonatomic)NSString* goodssalesprice;

@property(copy,nonatomic)NSString* goodstitle;

@property(copy,nonatomic)NSString* goodsId;

@property(copy,nonatomic)NSString* goodsImageUrl;

@property(copy,nonatomic)NSString* goodsStockNum;

@property(assign,nonatomic)BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
