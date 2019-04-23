//
//  HZCouponInfoTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/18.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZCouponInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *integralNum;

@property (weak, nonatomic) IBOutlet UILabel *moneyNum;

@end

NS_ASSUME_NONNULL_END
