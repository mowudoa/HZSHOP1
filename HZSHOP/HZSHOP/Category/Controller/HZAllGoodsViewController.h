//
//  HZAllGoodsViewController.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/16.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "XTBaseBackViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    tableViewType,
    collectionViewType
}goodsListType;

@interface HZAllGoodsViewController : XTBaseBackViewController

@property(nonatomic) goodsListType listType;

@property(nonatomic,copy) NSString *classId;

@property(copy,nonatomic) NSString *keyWords;//关键字

@end

NS_ASSUME_NONNULL_END
