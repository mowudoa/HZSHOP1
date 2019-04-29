//
//  HZAddressListTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZAddressModel.h"

@protocol deleteBtnDelagate <NSObject>

-(void)buttonDelete:(NSString *)addressId;

-(void)buttonEdit:(NSString *)addressId withMode:(HZAddressModel *)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HZAddressListTableViewCell : UITableViewCell

@property(strong,nonatomic)HZAddressModel* addressmodel;

@property (nonatomic, weak) id<deleteBtnDelagate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressInfoLabel;

@property (weak, nonatomic) IBOutlet UIButton *defaultButton;

@end

NS_ASSUME_NONNULL_END
