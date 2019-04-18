//
//  HZCouponListTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/13.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZCouponListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *couponTitle;

@property (weak, nonatomic) IBOutlet UILabel *couponMoney;

@property (weak, nonatomic) IBOutlet UILabel *couponLimit;

@property (weak, nonatomic) IBOutlet UILabel *couponInfo;

@property (weak, nonatomic) IBOutlet UILabel *couponStockNum;

@property (weak, nonatomic) IBOutlet UILabel *couponLifeTime;

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@end

NS_ASSUME_NONNULL_END
