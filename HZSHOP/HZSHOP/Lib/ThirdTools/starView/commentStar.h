//
//  commentStar.h
//  O2O
//
//  Created by wangxiaowei on 15/4/29.
//  Copyright (c) 2015年 wangxiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^returnStarNumBlock)(NSInteger starNum);

@interface commentStar : UIView

@property(assign,nonatomic)NSInteger currentStar;
@property(assign,nonatomic)NSInteger numofStar;
@property(assign,nonatomic)BOOL selectingenabled;

@property (nonatomic, copy) returnStarNumBlock returnStarNumBlock;

- (void)returnStar:(returnStarNumBlock)block;

@end
