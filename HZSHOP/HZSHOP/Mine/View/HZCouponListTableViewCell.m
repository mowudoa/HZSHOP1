//
//  HZCouponListTableViewCell.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/13.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCouponListTableViewCell.h"

@implementation HZCouponListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [WYFTools viewLayer:_buyButton.height/2 withView:_buyButton];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor orangeColor] withView:_buyButton];
    
}

@end
