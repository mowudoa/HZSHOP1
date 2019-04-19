//
//  HZRechargeViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/19.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZRechargeViewController.h"

@interface HZRechargeViewController ()<
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@property (weak, nonatomic) IBOutlet UIView *rechargeTypeView;

@end

@implementation HZRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
}

-(void)initUI
{
    [WYFTools viewLayer:5 withView:_rechargeButton];
    
    [_moneyTextField addTarget:self action:@selector(showtextFiledContents) forControlEvents:UIControlEventEditingChanged];
    
    _rechargeButton.userInteractionEnabled = NO;
    
}

#pragma mark 充值
- (IBAction)rechargeMoney:(UIButton *)sender {

    if ([sender.titleLabel.text isEqualToString:@"下一步"]) {
        
        _rechargeTypeView.hidden = NO;
        
        [sender setTitle:@"确认支付" forState:UIControlStateNormal];
        
    }else{
        
        NSLog(@"充值中......");
    }

}

#pragma mark 改变button状态
-(void)showtextFiledContents
{
   
    if (_moneyTextField.text.length > 0) {
        
        [_rechargeButton setBackgroundColor:[UIColor redColor]];
        
        _rechargeButton.userInteractionEnabled = YES;
        
    }
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
