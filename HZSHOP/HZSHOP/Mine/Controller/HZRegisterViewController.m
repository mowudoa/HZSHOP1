//
//  HZRegisterViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/12.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZRegisterViewController.h"

@interface HZRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordSecondTextField;

@property(nonatomic,assign) NSInteger num;

@end

@implementation HZRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initUI];
    
}
-(void)initUI
{
    if (_registerOrChangePass == userRegisterType) {
        
        self.navigationItem.title = @"注册";

        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        
    }else if (_registerOrChangePass == forgetLoginPassWordType){
       
        self.navigationItem.title = @"忘记密码";

        [_registerButton setTitle:@"立即修改" forState:UIControlStateNormal];

    }
    
    [WYFTools viewLayer:3 withView:_getCodeButton];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor blackColor] withView:_getCodeButton];
    
    [WYFTools viewLayer:5 withView:_registerButton];
    
}
#pragma mark 用户注册
- (IBAction)userRegister:(UIButton *)sender {

    if ([_userPhoneTextField.text isEqualToString:@""] || [_userPhoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        
        [JKToast showWithText:@"手机号不可为空"];
        
    }else if ([CrazyFunction CrazyValidatePhoneNum:_userPhoneTextField.text]){
        
        [JKToast showWithText:@"请输入正确的手机号"];

    }else if ([_passWordTextField.text isEqualToString:@""] || [_passWordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        
        [JKToast showWithText:@"请输入密码"];
        
    }else if ([_passWordSecondTextField.text isEqualToString:@""] || [_passWordSecondTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        
        [JKToast showWithText:@"请输入确认密码"];
        
    }else if (![_passWordTextField.text isEqualToString:_passWordSecondTextField.text]){
        
        [JKToast showWithText:@"两次密码输入不一致"];
        
    }else{
        
        NSDictionary *dict = @{@"mobile":_userPhoneTextField.text,
                               @"pwd":_passWordTextField.text
                               };
        
        [CrazyNetWork CrazyRequest_Post:USER_REGISTER parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
            
            LOG(@"注册", dic);
            
            if (SUCCESS) {
                
                [JKToast showWithText:dic[@"message"]];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
               
                [JKToast showWithText:dic[@"message"]];

            }
            
        } fail:^(NSError *error, NSString *url, NSString *Json) {
            
            
        }];
        
    }
    
}

#pragma mark 验证码获取
- (IBAction)getCode:(UIButton *)sender {


    self.num = 60;
    
    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%ld",(long)(self.num)] forState:UIControlStateNormal];
    
    self.getCodeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.getCodeButton.enabled = NO;
    
    [self jishiTimer];
    
}

//倒计时
-(void)jishiTimer
{
    _num--;
    
    if (_num < 1) {
        
        _getCodeButton.enabled = YES;
        
        [_getCodeButton setTitle:[NSString stringWithFormat:@"立即获取"] forState:UIControlStateNormal];
        
        [_getCodeButton setBackgroundColor:[UIColor redColor]];
        
        return;
        
    }else
    {
        _getCodeButton.enabled = NO;
        
        [_getCodeButton setTitle:[NSString stringWithFormat:@"%lds",(long)_num] forState:UIControlStateNormal];
        
        [self performSelector:@selector(jishiTimer) withObject:nil afterDelay:1.0f];
        
        return;
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
