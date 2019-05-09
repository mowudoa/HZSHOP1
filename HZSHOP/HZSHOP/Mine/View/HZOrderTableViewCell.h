//
//  HZOrderTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/17.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsIcon;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;

@end

NS_ASSUME_NONNULL_END
