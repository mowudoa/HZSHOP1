//
//  HZAddressListTableViewCell.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZAddressListTableViewCell.h"

@implementation HZAddressListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)editButton:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(buttonEdit:withMode:)]) {
        
    }
    
}
- (IBAction)deleteButton:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(buttonDelete:)]) {
        
    }
    
}

@end
