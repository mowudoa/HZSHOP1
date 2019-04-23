//
//  HZPayTypeTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/23.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZPayTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *payTypeName;
@property (weak, nonatomic) IBOutlet UILabel *payTypeInfo;
@property (weak, nonatomic) IBOutlet UIImageView *payTypeIcon;

@end

NS_ASSUME_NONNULL_END
