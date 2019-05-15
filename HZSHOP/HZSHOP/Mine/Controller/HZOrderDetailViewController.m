//
//  HZOrderDetailViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/19.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZOrderDetailViewController.h"
#import "HZGoodsModel.h"
#import "HZOrderPayViewController.h"
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

@property(strong,nonatomic) NSMutableArray *goodsListArray;

@property(strong,nonatomic) NSMutableDictionary *addressDic;

@property(copy,nonatomic) NSString *orderCode;//订单编号

@property(copy,nonatomic) NSString *orderTime;//订单时间

@property(copy,nonatomic) NSString *orderStauts;//订单状态

@property(copy,nonatomic) NSString *orderPrice;//实付金额

@property(copy,nonatomic) NSString *goodsPrice;//商品总价

@property(copy,nonatomic) NSString *expressPrice;//运费

@property(copy,nonatomic) NSString *evaluateStatus;//评价状态

@property(copy,nonatomic) NSString *refundStatus;//评价状态

@end

@implementation HZOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
    [self initData];
    
}

-(void)initUI
{
    self.navigationItem.title = @"订单详情";

    _addressDic = [[NSMutableDictionary alloc] init];
    
    _goodsListArray = [[NSMutableArray alloc] init];
    
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

-(void)initData
{
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"orderid":_orderId
                           };

    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:ORDER_DETAIL parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        LOG(@"订单详情", dic)
        
        MJStrongSelf;

        if (SUCCESS) {
         
            NSDictionary *orderDetailDic = dic[@"data"];
            
            strongSelf.orderStauts = orderDetailDic[@"status"];
            
            strongSelf.orderTime = orderDetailDic[@"createtime"];
            
            strongSelf.orderCode = orderDetailDic[@"ordersn"];
            
            strongSelf.orderPrice = orderDetailDic[@"price"];
            
            strongSelf.expressPrice = orderDetailDic[@"dispatchprice"];
            
            strongSelf.goodsPrice = orderDetailDic[@"goodsprice"];
            
            NSArray *goodsArr = orderDetailDic[@"goods_list"];
            
            for (NSDictionary *goodsDic in goodsArr) {
                
                HZGoodsModel *model = [[HZGoodsModel alloc] init];
                
                model.rootTitle = goodsDic[@"title"];
                
                model.goodsPrice = goodsDic[@"price"];

                model.rootImageUrl = goodsDic[@"thumb"];
                
                model.goodsNum = goodsDic[@"total"];
                
                model.specs = goodsDic[@"optiontitle"];
                
                [strongSelf.goodsListArray addObject:model];
                
            }
            
            [strongSelf.addressDic addEntriesFromDictionary:orderDetailDic[@"address"]];
            
        }else{
            
            
        }
        
        [self reloadData];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
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
        
        switch ([_orderStauts integerValue]) {
            case 0:
                
                cell.orderStatusLabel.text = @"等待付款";
                break;
            case 1:
                
                cell.orderStatusLabel.text = @"买家已付款";
                break;
            case 2:
                
                cell.orderStatusLabel.text = @"卖家已发货";
                break;
            case 3:
                
                cell.orderStatusLabel.text = @"交易完成";
                break;
            default:
                break;
        }
        
        cell.orderPriceLabel.text = [NSString stringWithFormat:@"订单金额(含运费):￥%@",_orderPrice];
        
        return cell;
        
    }else if (indexPath.section == AddressTYpe - 100){
        
        HZAddressSelectTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddressSelectTableViewCell" forIndexPath:indexPath];
        
        cell.addressAddView.hidden = YES;
        
        cell.arrowTipImage.hidden = YES;
        
        cell.addressInfoView.hidden = NO;
        
        cell.addressUserName.text = _addressDic[@"realname"];
        
        cell.addressUserPhone.text = _addressDic[@"mobile"];
        
        cell.addressDetail.text = [NSString stringWithFormat:@"%@%@%@%@",_addressDic[@"province"],_addressDic[@"city"],_addressDic[@"area"],_addressDic[@"address"]];
        
        return cell;
        
    }else if (indexPath.section == OrderGoodsType - 100){
        
        HZCartOrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CartOrderTableViewCell" forIndexPath:indexPath];
        
        [cell setGoodsArray:_goodsListArray];
        
        return cell;
        
    }else if (indexPath.section == 6){
        
        HZOrderCodeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCodeTableViewCell" forIndexPath:indexPath];
        
        cell.orderTimelLabel.text = [NSString stringWithFormat:@"创建时间:%@",[WYFTools ConvertStrToTime:_orderTime dateModel:@"yyyy-MM-dd HH:mm:ss" withDateMultiple:1]];
        
        cell.orderCodelLabel.text = [NSString stringWithFormat:@"订单编号:%@",_orderCode];
        
        return cell;
        
    }else{
        
        HZGoodsPriceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsPriceTableViewCell" forIndexPath:indexPath];
        
        if (indexPath.section == 3) {
            
            cell.title.text = @"商品小计:";
            
            cell.money.text = [NSString stringWithFormat:@"￥ %@",_goodsPrice];
            
            cell.money.textColor = [UIColor colorWithHexString:@"#666666"];

        }else if (indexPath.section == 4) {
            
            cell.title.text = @"运费:";
            
            cell.money.text = [NSString stringWithFormat:@"￥ %@",_expressPrice];
            
            cell.money.textColor = [UIColor colorWithHexString:@"#666666"];

        }else if (indexPath.section == 5) {
            
            cell.title.text = @"实付费(含运费):";
            
            cell.money.text = [NSString stringWithFormat:@"￥ %@",_orderPrice];
            
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
        
        return (HEIGHT(127) + 30) * _goodsListArray.count;
        
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
    
    if ([sender.titleLabel.text containsString:HZOrderPayNow]) {
        
        HZOrderPayViewController *orderPay = [[HZOrderPayViewController alloc] init];
        
        [self.navigationController pushViewController:orderPay animated:YES];
        
    }else if ([sender.titleLabel.text containsString:HZOrderCancleOrder]){
        
        
    }else if ([sender.titleLabel.text containsString:HZOrderGoEvaluate]){
        
        
    }else if ([sender.titleLabel.text containsString:HZOrderApplyForRefund]){
        
        
    }
    
}

-(void)reloadData
{
    if (_addressDic != nil && _goodsListArray != nil) {
     
        [_OrderDetailTableView reloadData];
        
    }

    if ([_orderStauts isEqualToString:@"0"]) {
        
        [_leftButton setTitle:@"   取消订单   " forState:UIControlStateNormal];
        
        [_rightButton setTitle:@"   支付订单   " forState:UIControlStateNormal];
        
    }else if ([_orderStauts isEqualToString:@"1"]){
        
        _leftButton.hidden = YES;
        
        [_rightButton setTitle:@"   申请退款   " forState:UIControlStateNormal];
        
    }else if ([_orderStauts isEqualToString:@"2"]){
        
        [_leftButton setTitle:@"   确认收货   " forState:UIControlStateNormal];

        [_rightButton setTitle:@"   申请售后   " forState:UIControlStateNormal];
        
    }else if ([_orderStauts isEqualToString:@"3"]){
        
        [_leftButton setTitle:@"   删除订单   " forState:UIControlStateNormal];

        if ([_evaluateStatus isEqualToString:@"2"]) {
          
            [_rightButton setTitle:@"   已评价   " forState:UIControlStateNormal];

        }else{
            
            [_rightButton setTitle:@"   立即评价   " forState:UIControlStateNormal];

        }
        
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
