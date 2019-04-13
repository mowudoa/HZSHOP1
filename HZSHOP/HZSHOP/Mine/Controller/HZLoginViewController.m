//
//  HZLoginViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/12.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZLoginViewController.h"

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
    self.navigationItem.title = @"注册";
    
    [WYFTools viewLayer:5 withView:_loginButton];
    
}

- (IBAction)userLogin:(UIButton *)sender {

    NSDictionary *dict = @{@"mobile":_phoneTextField.text,
                          @"pwd":_passwordTexfField.text
                          };
    
    [CrazyNetWork CrazyRequest_Post:USER_LOGIN parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
      
        LOG(@"注册", dic);
        
        if (SUCCESS) {
            
        }else{
            
        }
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
        
    }];
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
