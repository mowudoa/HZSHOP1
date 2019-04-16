//
//  HZMineViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/9.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZMineViewController.h"
#import "HZCartViewController.h"
#import "HZLoginViewController.h"
#import "HZMyCouponsViewController.h"
#import "HZMyBrowseViewController.h"
#import "HZCouponListViewController.h"
#import "HZAddressListViewController.h"
#import "HZMyFollowGoodsViewController.h"
@interface HZMineViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;//背景scrollview

@property (weak, nonatomic) IBOutlet UIView *bgView;//scrollview的内容视图

@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;//用户头像

@end

@implementation HZMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
}
-(void)initUI
{
    [WYFTools viewLayer:_rechargeButton.height/2 withView:_rechargeButton];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor whiteColor] withView:_rechargeButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserIcon:)];
    
    [self.userIcon addGestureRecognizer:tap];
    
}
#pragma mark 优惠前领取中心
- (IBAction)couponList:(UIButton *)sender {

    HZCouponListViewController *coupon = [[HZCouponListViewController alloc] init];
    
    [self.navigationController pushViewController:coupon animated:YES];
    
}
#pragma mark 我的优惠券
- (IBAction)myCoupon:(UIButton *)sender {

    HZMyCouponsViewController *myCoupon = [[HZMyCouponsViewController alloc] init];
    
    [self.navigationController pushViewController:myCoupon animated:YES];
    
}
#pragma mark 收货地址
- (IBAction)addressList:(UIButton *)sender {

    HZAddressListViewController *address = [[HZAddressListViewController alloc] init];
    
    [self.navigationController pushViewController:address animated:YES];
    
}

#pragma mark 我的购物车
- (IBAction)myCart:(UIButton *)sender {

    HZCartViewController *cart = [[HZCartViewController alloc] init];
    
    cart.isRootNav = YES;
    
    [self.navigationController pushViewController:cart animated:YES];
    
}

#pragma mark 我的关注
- (IBAction)myFollow:(UIButton *)sender {

    HZMyFollowGoodsViewController *myfollw = [[HZMyFollowGoodsViewController alloc] init];
    
    [self.navigationController pushViewController:myfollw animated:YES];
    
}
#pragma mark 我的足迹
- (IBAction)myBrowse:(UIButton *)sender {

    HZMyBrowseViewController *browse = [[HZMyBrowseViewController alloc] init];
    
    [self.navigationController pushViewController:browse animated:YES];
    
}
#pragma mark 登录
-(void)tapUserIcon:(UITapGestureRecognizer *)tap
{
    HZLoginViewController *login = [[HZLoginViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    
    [self presentViewController:nav animated:YES completion:nil];
    
  //  [self.navigationController pushViewController:login animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
   
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

-(void)viewDidLayoutSubviews
{
    UIView* conView = (UIView*)[_bgScrollView viewWithTag:2048];
        
    _bgScrollView.contentSize = CGSizeMake(0, conView.mj_y+conView.height + 10);
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
