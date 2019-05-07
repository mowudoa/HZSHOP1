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

@property (weak, nonatomic) IBOutlet UITextField *consigneeName;

@property (weak, nonatomic) IBOutlet UITextField *consigneePhone;

@property (weak, nonatomic) IBOutlet UIButton *consigneeAreaButton;

@property (weak, nonatomic) IBOutlet UITextField *areaDetailInfo;

@end

@implementation HZNewBuildAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
}

-(void)initUI
{
    self.navigationItem.title = self.titleString;
    
    [WYFTools viewLayer:5 withView:_saveButton];
    
    _switchButton.transform = CGAffineTransformMakeScale(0.75, 0.75);
    
    if (_addressType == addressEditType) {
        
        [self initEditUI];
    }
}

-(void)initEditUI
{
    
    _consigneeName.text = _addressModel.userName;
    
    _consigneePhone.text = _addressModel.userPhone;
    
    _areaTextField.text = _addressModel.address;
    
    _areaDetailInfo.text = _addressModel.addressDetail;
    
    if ([_addressModel.is_default isEqualToString:@"1"]){
    
        _switchButton.on = YES;
    
        }else{
    
        _switchButton.on = NO;

    }
    
    
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

//保存地址
- (IBAction)saveArea:(UIButton *)sender {

       if ([_consigneeName.text isEqualToString:@""] || [_consigneeName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        
        [JKToast showWithText:@"收货人不可为空"];
        
    }else if ([_consigneePhone.text isEqualToString:@""] || [_consigneePhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0){
        
        [JKToast showWithText:@"手机号不可为空"];
        
    }else if ([_areaTextField.text isEqualToString:@""] || [_areaTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0){
        
        [JKToast showWithText:@"地区不可为空"];
        
    }else if ([_areaDetailInfo.text isEqualToString:@""] || [_areaDetailInfo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0){
        
        [JKToast showWithText:@"详细地址不可为空"];
        
    }else{
        
        [CrazyNetWork CrazyRequest_Post:ADD_ADDRESS parameters:[self editOrAddParameter] HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
            
            LOG(@"添加/编辑地址", dic);
            
            if (SUCCESS) {
                
                [JKToast showWithText:Address_Add_Success];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                
                [JKToast showWithText:dic[@"message"]];
                
            }
            
        } fail:^(NSError *error, NSString *url, NSString *Json) {
            
            LOG(@"cuow", Json);
            
        }];
        
        
    }
    
}

-(NSDictionary *)editOrAddParameter
{
    NSString *isDefault;
    
    NSDictionary *dict;
    
    if (_switchButton.isOn) {
        
        isDefault = @"1";
        
    }else{
        
        isDefault = @"0";
        
    }
    
    if (_addressType == addressAddType) {
        
        dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                               @"areas":_areaTextField.text,
                               @"address":_areaDetailInfo.text,
                               @"mobile":_consigneePhone.text,
                               @"realname":_consigneeName.text,
                               @"isdefault":isDefault
                               };
        
    }else if (_addressType == addressEditType){
        
        dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                 @"areas":_areaTextField.text,
                 @"address":_areaDetailInfo.text,
                 @"mobile":_consigneePhone.text,
                 @"realname":_consigneeName.text,
                 @"isdefault":isDefault,
                 @"id":_addressModel.rootId
                 };
        
    }
    
    return dict;
    
}

@end
