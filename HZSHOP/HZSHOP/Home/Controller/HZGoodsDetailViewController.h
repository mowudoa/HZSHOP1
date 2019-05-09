//
//  HZGoodsDetailViewController.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/12.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "XTBaseBackViewController.h"
#import "HZGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZGoodsDetailViewController : XTBaseBackViewController

@property(nonatomic,copy) NSString *goodsId;

@property(nonatomic,strong) HZGoodsModel *goodsModel;

@end

NS_ASSUME_NONNULL_END
