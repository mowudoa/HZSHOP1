//
//  HZNewBuildAddressViewController.h
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "XTBaseBackViewController.h"
#import "HZAddressModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum {
    addressAddType,
    addressEditType
}addressType;

@interface HZNewBuildAddressViewController : XTBaseBackViewController

@property(nonatomic)addressType addressType;

@property(nonatomic,copy) NSString *titleString;

@property(nonatomic,strong) HZAddressModel *addressModel;

@end

NS_ASSUME_NONNULL_END
