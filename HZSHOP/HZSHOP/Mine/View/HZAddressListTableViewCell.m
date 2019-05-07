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

-(void)setAddressmodel:(HZAddressModel *)addressmodel
{
    _addressmodel = addressmodel;
    
    _nameLabel.text = addressmodel.userName;
    
    _phoneLabel.text = addressmodel.userPhone;
    
    _addressInfoLabel.text = [NSString stringWithFormat:@"%@%@",addressmodel.address,addressmodel.addressDetail];
    
    if ([addressmodel.is_default isEqualToString:@"1"]) {
        
        _defaultButton.selected = YES;
        
    }else{
        
        _defaultButton.selected = NO;
        
    }
}

- (IBAction)isDefault:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(buttonIsDefault:)]) {
        
        [self.delegate buttonIsDefault:_addressmodel.rootId];
    }
}

- (IBAction)editButton:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(buttonEdit:withMode:)]) {
       
        [self.delegate buttonEdit:_addressmodel.rootId withMode:_addressmodel];
    }
    
}
- (IBAction)deleteButton:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(buttonDelete:)]) {
        
        [self.delegate buttonDelete:_addressmodel.rootId];
    }
    
}

@end
