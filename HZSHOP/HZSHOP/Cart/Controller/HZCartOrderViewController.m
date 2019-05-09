//
//  HZCartOrderViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/15.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCartOrderViewController.h"
#import "HZAddressModel.h"
#import "HZOrderPayViewController.h"
#import "HZCartOrderTableViewCell.h"
#import "HZGoodsPriceTableViewCell.h"
#import "HZCouPonSelectTableViewCell.h"
#import "HZAddressListViewController.h"
#import "HZLeaveMessageTableViewCell.h"
#import "HZAddressSelectTableViewCell.h"
@interface HZCartOrderViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *cartOrderTableView;

@property(strong,nonatomic) NSMutableArray *addressArray;

@property(copy,nonatomic) NSString *addressId;

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
    
    _addressArray = [[NSMutableArray alloc] init];
    
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

#pragma mark 提交订单

- (IBAction)submitOrder:(UIButton *)sender {

    NSMutableArray *orderParameter = [[NSMutableArray alloc] init];
    
    
    for (HZGoodsModel *model in _goodsArray) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        [dic addEntriesFromDictionary:@{@"goodsid":model.goodsId}];
        
        [dic addEntriesFromDictionary:@{@"total":model.goodsNum}];
        
        [dic addEntriesFromDictionary:@{@"optionid":model.optionId}];

        [orderParameter addObject:dic];
                
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:orderParameter options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"]
,                         @"goods":jsonStr,
                          @"addressid":_addressId
                          };
    
    [CrazyNetWork CrazyRequest_Post:COMMIT_ORDER parameters:dic HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
       
        LOG(@"提交订单", dic);
        
        if (SUCCESS) {
            
        }else{
            
            
        }
        
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
    
    HZOrderPayViewController *orderPay = [[HZOrderPayViewController alloc] init];
    
    [self.navigationController pushViewController:orderPay animated:YES];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 7;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == AddressType - 100) {
     
        HZAddressSelectTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddressSelectTableViewCell" forIndexPath:indexPath];

        if (_addressArray.count > 0) {
         
            HZAddressModel *model = _addressArray[indexPath.row];
            
            cell.addressInfoView.hidden = NO;
            
            cell.addressAddView.hidden = YES;
            
            cell.addressUserName.text = model.userName;
            
            cell.addressUserPhone.text = model.userPhone;
            
            cell.addressDetail.text = [NSString stringWithFormat:@"%@%@",model.address,model.addressDetail];
            
        }else{
            
        
            cell.addressInfoView.hidden = YES;
            
            cell.addressAddView.hidden = NO;
            
        }
        
        
        
        return cell;
        
    }else if (indexPath.section == GoodsType - 100){
        
        HZCartOrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CartOrderTableViewCell" forIndexPath:indexPath];
        
        [cell setGoodsArray:_goodsArray];
        
        return cell;
        
    }else if (indexPath.section == LeaveMessageType - 100){
        
        HZLeaveMessageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveMessageTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else if (indexPath.section == CouponType - 100){
        
        HZCouPonSelectTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CouPonSelectTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else{
        
        HZGoodsPriceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsPriceTableViewCell" forIndexPath:indexPath];
        
        if (indexPath.section == 4) {
            
            cell.title.text = @"商品小计:";
            
            cell.money.text = @"￥3.00";
            
            cell.money.textColor = [UIColor colorWithHexString:@"#666666"];
            
        }else if (indexPath.section == 5) {
            
            cell.title.text = @"运费:";
            
            cell.money.text = @"￥4.00";
        
            cell.money.textColor = [UIColor colorWithHexString:@"#666666"];

        }else if (indexPath.section == 6) {
            
            cell.title.text = @"实付费(含运费):";
            
            cell.money.text = @"￥7.00";
            
            cell.money.textColor = [UIColor redColor];
            
        }
        
        return cell;
        
    }
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.section == AddressType - 100){
        
        HZAddressListViewController *address = [[HZAddressListViewController alloc] init];
        
        address.addressListType = addressChoiceType;
        
        MJWeakSelf;
        
        address.addressInfoBlock = ^(HZAddressModel *model) {
           
            [weakSelf.addressArray removeAllObjects];
            
            [weakSelf.addressArray addObject:model];
            
            weakSelf.addressId = model.rootId;
            
            [weakSelf.cartOrderTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        };
        
        [self.navigationController pushViewController:address animated:YES];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == AddressType - 100) {
        
        return 70;
        
    }else if (indexPath.section == GoodsType - 100){
        
        return (HEIGHT(127) + 30) * _goodsArray.count;

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
    if (section < 4) {
        
        return 8;

    }else{
        
        return 0.01;
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
