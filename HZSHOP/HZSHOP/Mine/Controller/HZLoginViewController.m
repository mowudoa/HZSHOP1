//
//  HZLoginViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/12.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZLoginViewController.h"
#import "HZRegisterViewController.h"

@interface HZLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTexfField;

@end

@implementation HZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];

}
-(void)initUI
{
    
    [WYFTools viewLayer:5 withView:_loginButton];
    
}
-(void)initBackButton
{
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 25, 25)];
    
    backView.userInteractionEnabled = YES;
    
    backView.backgroundColor = [UIColor clearColor];
    
    [backBtn setFrame:CGRectMake(0, 0, 25, 25)];
    
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [backBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    
    [backView addSubview:backBtn];
    
    UIBarButtonItem* im = [[UIBarButtonItem alloc]initWithCustomView:backView];
    
    self.navigationItem.leftBarButtonItem = im;
}
-(void)backBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)userLogin:(UIButton *)sender {

    NSDictionary *dict = @{@"mobile":_phoneTextField.text,
                          @"pwd":_passwordTexfField.text
                          };
    
    [CrazyNetWork CrazyRequest_Post:USER_LOGIN parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
      
        LOG(@"登录", dic);
        
        if (SUCCESS) {
            
        }else{
            
        }
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
        
    }];
}
- (IBAction)userRegister:(UIButton *)sender {

    HZRegisterViewController *userRegister = [[HZRegisterViewController alloc] init];
    
    userRegister.registerOrChangePass = userRegisterType;
    
    [self.navigationController pushViewController:userRegister animated:YES];
    
}
- (IBAction)userForgetPassWord:(UIButton *)sender {

    
    HZRegisterViewController *userRegister = [[HZRegisterViewController alloc] init];
    
    userRegister.registerOrChangePass = forgetLoginPassWordType;
    
    [self.navigationController pushViewController:userRegister animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //去掉导航栏下划线,达到纯present的效果
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
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
