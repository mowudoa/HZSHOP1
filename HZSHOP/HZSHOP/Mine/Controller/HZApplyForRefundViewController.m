//
//  HZApplyForRefundViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/27.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZApplyForRefundViewController.h"
#import "BRStringPickerView.h"
@interface HZApplyForRefundViewController ()

@property (weak, nonatomic) IBOutlet UITextField *refundInfo;//退款说明

@property (weak, nonatomic) IBOutlet UILabel *refundMoney;//退款金额

@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (weak, nonatomic) IBOutlet UIButton *refundTypeButton;

@property (weak, nonatomic) IBOutlet UIButton *refundReasonButton;

@end

@implementation HZApplyForRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
}

-(void)initUI
{
    
    self.navigationItem.title = @"退款申请";
    
    [_leftButton setTitle:@"   退款申请   " forState:UIControlStateNormal];
    
    [_rightButton setTitle:@"   取消   " forState:UIControlStateNormal];
    
    [WYFTools viewLayer:_leftButton.height/2 withView:_leftButton];
    
    [WYFTools viewLayer:_rightButton.height/2 withView:_rightButton];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor colorWithHexString:@"#666666"] withView:_leftButton];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor colorWithHexString:@"#666666"] withView:_rightButton];
    
}

#pragma mark 退款(售后)申请/取消
- (IBAction)appleyForRefund:(UIButton *)sender {
}

#pragma mark 上传凭证照
- (IBAction)uploadImage:(UIButton *)sender {
}

#pragma mark 退款(售后)方式/原因
- (IBAction)refundType:(UIButton *)sender {

    MJWeakSelf;

    if (sender.tag == 100) {
   
        
        [BRStringPickerView showStringPickerWithTitle:nil dataSource:@[@"退款(仅退款不退货)"] defaultSelValue:_refundTypeButton.titleLabel.text resultBlock:^(id selectValue) {
            
            [weakSelf.refundTypeButton setTitle:selectValue forState:UIControlStateNormal];
            
        }];
        
    }else if (sender.tag == 101){
    
        [BRStringPickerView showStringPickerWithTitle:nil dataSource:@[@"不想要了", @"卖家缺货", @"拍错了",@"其他"] defaultSelValue:_refundTypeButton.titleLabel.text resultBlock:^(id selectValue) {
            
            [weakSelf.refundReasonButton setTitle:selectValue forState:UIControlStateNormal];
            
        }];
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
