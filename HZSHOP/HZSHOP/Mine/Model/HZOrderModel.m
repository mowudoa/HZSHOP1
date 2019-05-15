//
//  HZOrderModel.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/17.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZOrderModel.h"

@implementation HZOrderModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _goodsArray = [NSMutableArray array];
    }
    return self;
}

@end
