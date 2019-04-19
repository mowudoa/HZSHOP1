//
//  HZCartTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZCartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZCartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;

@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;

@property (weak, nonatomic) IBOutlet UILabel *goodsSpecs;

@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@property (weak, nonatomic) IBOutlet UILabel *goodsOldPrice;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UITextField *numTextField;

@property(strong,nonatomic)HZCartModel* carModel;

@end

NS_ASSUME_NONNULL_END
