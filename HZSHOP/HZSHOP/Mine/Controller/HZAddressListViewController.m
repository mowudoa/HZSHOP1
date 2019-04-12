//
//  HZAddressListViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/10.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZAddressListViewController.h"
#import "HZAddressModel.h"
#import "HZAddressListTableViewCell.h"
#import "HZNewBuildAddressViewController.h"
@interface HZAddressListViewController ()<
deleteBtnDelagate,
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *addressListTableView;

@property (weak, nonatomic) IBOutlet UIButton *buildAddressButton;

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
    
}

-(void)registercell
{
    
    _addressListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib* nib   =[UINib nibWithNibName:@"HZAddressListTableViewCell" bundle:nil];
    
    [_addressListTableView registerNib:nib forCellReuseIdentifier:@"AddressTableViewCell"];
    
}

- (IBAction)newBuildAddress:(UIButton *)sender {

    HZNewBuildAddressViewController *buildAddress = [[HZNewBuildAddressViewController alloc] init];
    
    [self.navigationController pushViewController:buildAddress animated:YES];
    
}

#pragma mark - UITableViewDataSource  数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZAddressListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell" forIndexPath:indexPath];
    
    cell.delegate = self;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
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
    
}
-(void)buttonDelete:(NSString *)addressId
{
    
    
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
