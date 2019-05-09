//
//  HZGoodsParameterTableViewCell.h
//  HZSHOP
//
//  Created by 英峰 on 2019/5/8.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZGoodsParameterModel.h"

@protocol parameterSlecteDelete <NSObject>

-(void)parameterSelete:(NSString *)parameterId sort: (NSInteger)parameterSort;

@end


NS_ASSUME_NONNULL_BEGIN

@interface HZGoodsParameterTableViewCell : UITableViewCell

@property(nonatomic,strong) HZGoodsParameterModel *parameterModel;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, weak) id<parameterSlecteDelete> delegate;

@end

NS_ASSUME_NONNULL_END
