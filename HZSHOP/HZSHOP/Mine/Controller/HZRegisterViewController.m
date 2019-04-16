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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
