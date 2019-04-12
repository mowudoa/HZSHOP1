//
//  HZDistributionCenterViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/11.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZDistributionCenterViewController.h"
#import "HZCommissionDetailsViewController.h"

@interface HZDistributionCenterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *memberlevel;
@property (weak, nonatomic) IBOutlet UIButton *commisionDraw;

@end

@implementation HZDistributionCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initUI];
    
}
-(void)initUI
{
    self.navigationItem.title = @"分销中心";
    
    [WYFTools viewLayer:_memberlevel.height/2 withView:_memberlevel];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor whiteColor] withView:_memberlevel];
    
    [WYFTools viewLayer:_commisionDraw.height/2 withView:_commisionDraw];

}

- (IBAction)comissionClick:(UIButton *)sender {
    
    if (sender.tag == 101) {
#pragma mark  分销佣金
        HZCommissionDetailsViewController *commissionDetail = [[HZCommissionDetailsViewController alloc] init];

        [self.navigationController pushViewController:commissionDetail animated:YES];
        
    }else if (sender.tag == 102){
#pragma mark 分销订单

    }else if (sender.tag == 103){
#pragma mark 提现明细

    }else{
#pragma mark 我的下线

    }
    
}

#pragma mark 佣金提现
- (IBAction)drawCommission:(UIButton *)sender {
}

#pragma mark 推广w二维码
- (IBAction)MyQRCode:(UIButton *)sender {
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
