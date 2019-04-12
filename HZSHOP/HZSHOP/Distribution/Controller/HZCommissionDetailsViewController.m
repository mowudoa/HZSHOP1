//
//  HZCommissionDetailsViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/11.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCommissionDetailsViewController.h"

@interface HZCommissionDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *tipInfoView;//用户须知信息

@property (weak, nonatomic) IBOutlet UIImageView *tipInfoImage;//箭头
@property (weak, nonatomic) IBOutlet UIButton *cashButton;

@end

@implementation HZCommissionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}
-(void)initUI
{
    self.navigationItem.title = @"分销佣金";
    
    [WYFTools viewLayer:5 withView:_cashButton];
    
}
#pragma mark 用户须知
- (IBAction)tipIfo:(UIButton *)sender {

    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        _tipInfoView.hidden = NO;
        
        _tipInfoImage.image = [UIImage imageNamed:@"小于号s"];

    }else{
        
        _tipInfoView.hidden = YES;
     
        _tipInfoImage.image = [UIImage imageNamed:@"大于h"];

    }
    
}
#pragma mark 提现
- (IBAction)cashClick:(UIButton *)sender {

}
-(void)viewDidLayoutSubviews
{
    
    _bgScrollView.contentSize = CGSizeMake(0, _tipInfoView.mj_y+_tipInfoView.height + 10);

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
