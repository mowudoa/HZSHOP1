//
//  HZNewBuildAddressViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZNewBuildAddressViewController.h"
#import "BRPickerView.h"

@interface HZNewBuildAddressViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *areaTextField;

@end

@implementation HZNewBuildAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
}
-(void)initUI
{
    self.navigationItem.title = @"新建地址";
    
    [WYFTools viewLayer:5 withView:_saveButton];
    
    _switchButton.transform = CGAffineTransformMakeScale(0.75, 0.75);
}
- (IBAction)areaChoice:(UIButton *)sender {

    NSArray *defaultSelArr = [self.areaTextField.text componentsSeparatedByString:@" "];
    // NSArray *dataSource = [weakSelf getAddressDataSource];  //从外部传入地区数据源
    NSArray *dataSource = nil; // dataSource 为空时，就默认使用框架内部提供的数据源（即 BRCity.plist）
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:defaultSelArr isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        
        self.areaTextField.text = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
        
    } cancelBlock:^{
        
        NSLog(@"点击了背景视图或取消按钮");
        
    }];
}

@end
