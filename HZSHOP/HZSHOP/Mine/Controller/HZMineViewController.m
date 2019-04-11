//
//  HZMineViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/9.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZMineViewController.h"
#import "HZAddressListViewController.h"

@interface HZMineViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;//背景scrollview
@property (weak, nonatomic) IBOutlet UIView *bgView;//scrollview的内容视图
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;

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
    
}
//收货地址
- (IBAction)addressList:(UIButton *)sender {

    HZAddressListViewController *address = [[HZAddressListViewController alloc] init];
    
    [self.navigationController pushViewController:address animated:YES];
    
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
