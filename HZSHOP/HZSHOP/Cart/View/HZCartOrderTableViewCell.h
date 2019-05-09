//
//  HZCartOrderTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/15.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZCartOrderTableViewCell : UITableViewCell<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *cartGoodsTableView;

@property(nonatomic,strong) NSMutableArray *goodsArray;

@end

NS_ASSUME_NONNULL_END
