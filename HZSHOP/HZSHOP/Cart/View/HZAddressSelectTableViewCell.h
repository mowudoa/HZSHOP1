//
//  HZAddressSelectTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/15.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZAddressSelectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *addressInfoView;

@property (weak, nonatomic) IBOutlet UIView *addressAddView;

@property (weak, nonatomic) IBOutlet UILabel *addressUserName;

@property (weak, nonatomic) IBOutlet UILabel *addressUserPhone;

@property (weak, nonatomic) IBOutlet UILabel *addressDetail;

@end

NS_ASSUME_NONNULL_END
