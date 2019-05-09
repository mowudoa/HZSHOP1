//
//  HZAddressListViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZAddressListViewController.h"
#import "HZAddressListTableViewCell.h"
#import "HZNewBuildAddressViewController.h"
@interface HZAddressListViewController ()<
deleteBtnDelagate,
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *addressListTableView;

@property (weak, nonatomic) IBOutlet UIButton *buildAddressButton;

@property(nonatomic,strong) NSMutableArray *addressArray;

@end

@implementation HZAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
}

-(void)initUI
{
    self.navigationItem.title = @"收货地址";
    
    [WYFTools viewLayer:5 withView:_buildAddressButton];
    
    _addressArray = [[NSMutableArray alloc] init];
    
}

-(void)registercell
{
    
    _addressListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib* nib   =[UINib nibWithNibName:@"HZAddressListTableViewCell" bundle:nil];
    
    [_addressListTableView registerNib:nib forCellReuseIdentifier:@"AddressTableViewCell"];
    
}

-(void)initData
{
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"]};

    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:ADDRESS_LIST parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
       
        LOG(@"地址列表", dic)
        
        MJStrongSelf;
        
        [strongSelf.addressArray removeAllObjects];
        
        if ([[NSString stringWithFormat:@"%d",[dic[@"status"] intValue]] isEqualToString:@"1"]) {
            
            NSArray *address = dic[@"result"][@"list"];
            
            for (NSDictionary *addressDic in address) {
                
                HZAddressModel *model = [[HZAddressModel alloc] init];
                
                model.userName = addressDic[@"realname"];
                
                model.userPhone = addressDic[@"mobile"];
                
                model.address = [NSString stringWithFormat:@"%@%@%@",addressDic[@"province"],addressDic[@"city"],addressDic[@"area"]];
                
                model.addressDetail = addressDic[@"address"];
                
                model.rootId = addressDic[@"id"];
                
                model.is_default = addressDic[@"isdefault"];
                
                [strongSelf.addressArray addObject:model];
            }
            
            [strongSelf.addressListTableView reloadData];
            
        }else{
            
            
        }
        
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}
- (IBAction)newBuildAddress:(UIButton *)sender {

    HZNewBuildAddressViewController *buildAddress = [[HZNewBuildAddressViewController alloc] init];
    
    buildAddress.titleString = @"新建地址";
    
    buildAddress.addressType = addressAddType;
    
    [self.navigationController pushViewController:buildAddress animated:YES];
    
}

#pragma mark - UITableViewDataSource  数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _addressArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZAddressListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell" forIndexPath:indexPath];
    
    HZAddressModel *model = _addressArray[indexPath.section];
    
    [cell setAddressmodel:model];
    
    cell.delegate = self;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZAddressModel *model = _addressArray[indexPath.section];
    
    if (_addressListType == addressChoiceType) {
        
        MJWeakSelf;
        
        if (self.addressInfoBlock) {
            //将值传到接收方
            weakSelf.addressInfoBlock(model);
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (_addressListType == addressSeeType){
        
        
    }
  
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return [self createHeaderView];
    
}

#pragma mark - UITableViewDelegate  代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT(125);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)createHeaderView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,10)];
    
    view.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    
    return view;
    
}

#pragma mark ADDRESS_CELL_DELEGATE  自定义cell代理
-(void)buttonEdit:(NSString *)addressId withMode:(HZAddressModel *)model
{
  
    HZNewBuildAddressViewController *buildAddress = [[HZNewBuildAddressViewController alloc] init];
    
    buildAddress.titleString = @"新建地址";
    
    buildAddress.addressType = addressEditType;
    
    buildAddress.addressModel = model;
    
    [self.navigationController pushViewController:buildAddress animated:YES];
    
}

-(void)buttonDelete:(NSString *)addressId
{
  
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"id":addressId
                           };

    [CrazyNetWork CrazyRequest_Post:ADDRESS_DELETE parameters:dict HUD:NO success:^(NSDictionary *dic, NSString *url, NSString *Json) {
       
        LOG(@"删除地址", dic);
        
        if (SUCCESS) {
            
            [self initData];
            
        }else{
            
            [JKToast showWithText:dic[@"message"]];

        }
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}

-(void)buttonIsDefault:(NSString *)addressId
{
    
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"id":addressId
                           };
    
    [CrazyNetWork CrazyRequest_Post:ADDRESS_SET_DEFAULT parameters:dict HUD:NO success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        LOG(@"设置默认地址", dic);
        
        if ([[NSString stringWithFormat:@"%d",[dic[@"status"] intValue]] isEqualToString:@"1"]) {
                        
            [self initData];
            
        }else{
            
            [JKToast showWithText:dic[@"message"]];
            
        }
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initData];

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
