//
//  HZOrderDetailViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/19.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZOrderDetailViewController.h"
#import "HZOrderCodeTableViewCell.h"
#import "HZCartOrderTableViewCell.h"
#import "HZGoodsPriceTableViewCell.h"
#import "HZOrderStatusTableViewCell.h"
#import "HZAddressSelectTableViewCell.h"
@interface HZOrderDetailViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *OrderDetailTableView;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation HZOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
}

-(void)initUI
{
    self.navigationItem.title = @"订单详情";

    [_leftButton setTitle:@"   删除订单   " forState:UIControlStateNormal];
    
    [_rightButton setTitle:@"   支付订单   " forState:UIControlStateNormal];
    
    [WYFTools viewLayer:_leftButton.height/2 withView:_leftButton];
    
    [WYFTools viewLayer:_rightButton.height/2 withView:_rightButton];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor colorWithHexString:@"#666666"] withView:_leftButton];
 
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor colorWithHexString:@"#666666"] withView:_rightButton];

}

-(void)registercell
{
    //费用cell
    UINib* nib = [UINib nibWithNibName:@"HZGoodsPriceTableViewCell" bundle:nil];
    
    [_OrderDetailTableView registerNib:nib forCellReuseIdentifier:@"GoodsPriceTableViewCell"];
    //订单状态cell
    UINib* nib1 = [UINib nibWithNibName:@"HZOrderStatusTableViewCell" bundle:nil];
    
    [_OrderDetailTableView registerNib:nib1 forCellReuseIdentifier:@"OrderStatusTableViewCell"];
    //地址cell
    UINib* nib3 = [UINib nibWithNibName:@"HZAddressSelectTableViewCell" bundle:nil];
    
    [_OrderDetailTableView registerNib:nib3 forCellReuseIdentifier:@"AddressSelectTableViewCell"];
    //商品cell
    UINib* nib4 = [UINib nibWithNibName:@"HZCartOrderTableViewCell" bundle:nil];
    
    [_OrderDetailTableView registerNib:nib4 forCellReuseIdentifier:@"CartOrderTableViewCell"];
    //订单code cell
    UINib* nib5 = [UINib nibWithNibName:@"HZOrderCodeTableViewCell" bundle:nil];
    
    [_OrderDetailTableView registerNib:nib5 forCellReuseIdentifier:@"OrderCodeTableViewCell"];
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
    if (indexPath.section == OrderStatusType - 100) {
        
        HZOrderStatusTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderStatusTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else if (indexPath.section == AddressTYpe - 100){
        
        HZAddressSelectTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddressSelectTableViewCell" forIndexPath:indexPath];
        
        cell.addressAddView.hidden = YES;
        
        cell.addressInfoView.hidden = NO;
        
        return cell;
        
    }else if (indexPath.section == OrderGoodsType - 100){
        
        HZCartOrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CartOrderTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else if (indexPath.section == 6){
        
        HZOrderCodeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCodeTableViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else{
        
        HZGoodsPriceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsPriceTableViewCell" forIndexPath:indexPath];
        
        if (indexPath.section == 3) {
            
            cell.title.text = @"商品小计:";
            
            cell.money.text = @"￥ 3.00";
            
            cell.money.textColor = [UIColor colorWithHexString:@"#666666"];

        }else if (indexPath.section == 4) {
            
            cell.title.text = @"运费:";
            
            cell.money.text = @"￥ 4.00";
            
            cell.money.textColor = [UIColor colorWithHexString:@"#666666"];

        }else if (indexPath.section == 5) {
            
            cell.title.text = @"实付费(含运费):";
            
            cell.money.text = @"￥ 7.00";
            
            cell.money.textColor = [UIColor redColor];
            
        }
        
        return cell;
        
    }
    
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == AddressTYpe - 100 || indexPath.section == OrderStatusType - 100) {
        
        return 70;
        
    }else if (indexPath.section == OrderGoodsType - 100){
        
        return (HEIGHT(127) + 30) * 10;
        
    }else if (indexPath.section == 6){
        
        return 48;
        
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
    if (section < 3 || section > 4) {
        
        return 8;
    }
    
    return 0.01;
}

#pragma mark 订单支付/取消/删除
- (IBAction)orderButton:(UIButton *)sender {

    
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
