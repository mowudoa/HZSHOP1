//
//  HZGoodsParameterModel.h
//  HZSHOP
//
//  Created by 英峰 on 2019/5/8.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "rootModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZGoodsParameterModel : rootModel

@property(assign,nonatomic) CGFloat cellHeight;//cell高度

@property(strong,nonatomic)NSMutableArray *parameterArray;

@end

NS_ASSUME_NONNULL_END
