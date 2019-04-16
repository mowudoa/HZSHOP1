//
//  HZCartOrderViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/15.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCartOrderViewController.h"
#import "HZCartOrderTableViewCell.h"
#import "HZGoodsPriceTableViewCell.h"
#import "HZLeaveMessageTableViewCell.h"
#import "HZCouPonSelectTableViewCell.h"
#import "HZAddressSelectTableViewCell.h"
@interface HZCartOrderViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *cartOrderTableView;

@property(nonatomic,strong) NSMutableArray *goodsArray;

@end

@implementation HZCartOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
 
    [self registercell];
    
}

-(void)initUI
{
    self.navigationItem.title = @"确认订单";
}

-(void)registercell
{
    
    UINib* nib = [UINib nibWithNibName:@"HZGoodsPriceTableViewCell" bundle:nil];
    
    [_cartOrderTableView registerNib:nib forCellReuseIdentifier:@"GoodsPriceTableViewCell"];
    
    UINib* nib1 = [UINib nibWithNibName:@"HZLeaveMessageTableViewCell" bundle:nil];
    
    [_cartOrderTableView registerNib:nib1 forCellReuseIdentifier:@"LeaveMessageTableViewCell"];
    
    UINib* nib2 = [UINib nibWithNibName:@"HZCouPonSelectTableViewCell" bundle:nil];
    
    [_cartOrderTableView registerNib:nib2 forCellReuseIdentifier:@"CouPonSelectTableViewCell"];
    
    UINib* nib3 = [UINib nibWithNibName:@"HZAddressSelectTableViewCell" bundle:nil];
    
    [_cartOrderTableView registerNib:nib3 forCellReuseIdentifier:@"AddressSelectTableViewCell"];
    
    UINib* nib4 = [UINib nibWithNibName:@"HZCartOrderTableViewCell" bundle:nil];
    
    [_cartOrderTableView registerNib:nib4 forCellReuseIdentifier:@"CartOrderTableViewCell"];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 5;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == AddressType - 100) {
     
        HZAddressSelectTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddressSelectTableViewCell" forIndexPath:indexPath];

        return cell;
        
    }else if (indexPath.section == GoodsType - 100){
        
        HZCartOrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CartOrderTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else if (indexPath.section == LeaveMessageType - 100){
        
        HZLeaveMessageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveMessageTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else if (indexPath.section == CouponType - 100){
        
        HZCouPonSelectTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CouPonSelectTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else{
        
        HZGoodsPriceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsPriceTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }
    
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == AddressType - 100) {
        
        return 70;
        
    }else if (indexPath.section == GoodsType - 100){
        
        return (HEIGHT(127) + 30) * 10;

    }else if (indexPath.section == LeaveMessageType - 100){
        
        return 75;
        
    }else{
        
        return 40;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
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
