//
//  HZRechargeHistoryTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/19.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZRechargeHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rechargeMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *rechargeTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *rechargeStatusLabel;
@end

NS_ASSUME_NONNULL_END
