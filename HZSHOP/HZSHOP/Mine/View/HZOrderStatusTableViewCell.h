//
//  HZOrderStatusTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/19.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZOrderStatusTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;

@end

NS_ASSUME_NONNULL_END
