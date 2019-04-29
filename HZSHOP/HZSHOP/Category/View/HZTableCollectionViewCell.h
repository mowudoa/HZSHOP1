//
//  HZTableCollectionViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/17.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTableCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;

@property (weak, nonatomic) IBOutlet UILabel *goodsOldPrice;

@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@end

NS_ASSUME_NONNULL_END
