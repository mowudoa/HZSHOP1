//
//  HZAddressListViewController.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "XTBaseBackViewController.h"
#import "HZAddressModel.h"
typedef enum {
    addressChoiceType,
    addressSeeType
}addressListType;

typedef void (^addressBlock) (HZAddressModel *model);

NS_ASSUME_NONNULL_BEGIN

@interface HZAddressListViewController : XTBaseBackViewController

@property(nonatomic)addressListType addressListType;

@property (nonatomic ,copy) addressBlock addressInfoBlock;

@end

NS_ASSUME_NONNULL_END
