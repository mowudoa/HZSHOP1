//
//  XTBaseBackViewController.h
//  StarGroupBuying
//
//  Created by 英峰 on 2018/12/17.
//  Copyright © 2018年 英峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTBaseBackViewController : UIViewController

-(void)initBackButton;

-(void)backBtn:(UIButton*)sender;

@property(nonatomic,assign) NSInteger nowPage;

@property(nonatomic,assign) NSInteger totalPage;

@end
