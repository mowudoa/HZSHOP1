//
//  HZMyOrderViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/17.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZMyOrderViewController.h"
#import "HZOrderModel.h"
#import "HZGoodsModel.h"
#import "HZOrderTableViewCell.h"
#import "HZEvaluateViewController.h"
#import "HZOrderDetailViewController.h"
#import "HZApplyForRefundViewController.h"
@interface HZMyOrderViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *myOrderTableView;

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UIView *orderNumForSection;

@property(nonatomic,strong) UILabel *lineLabel;

@property(nonatomic,copy) NSString *orderStatus;

@property(nonatomic,strong) NSMutableArray *orderListArray;

@end

@implementation HZMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
}

-(void)initUI
{
    _orderListArray = [[NSMutableArray alloc] init];
    
    self.navigationItem.title = @"我的订单";
    
    _lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(1,41,SCREEN_WIDTH/5,2)];
    
    _lineLabel.backgroundColor=[UIColor colorWithHexString:@"#FC575A"];
    
    [self.view addSubview:_lineLabel];
    
    // 下拉加载
    self.myOrderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initData];
        
    }];
    
    // 上拉刷新
    self.myOrderTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.nowPage ++;
        
        [self initMoreData];
        
    }];
    
    [WYFTools autuLayoutNewMJ:_myOrderTableView];
    
}

-(void)registercell
{
    UINib* nib = [UINib nibWithNibName:@"HZOrderTableViewCell" bundle:nil];
    
    [_myOrderTableView registerNib:nib forCellReuseIdentifier:@"OrderTableViewCell"];
    
}

-(void)initData
{
    self.nowPage = 1;
    
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"status":_orderStatus,
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]
                           };

    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:MY_ORDER parameters:dict HUD:NO success:^(NSDictionary *dic, NSString *url, NSString *Json) {
       
        LOG(@"我的订单", dic);
        
        MJStrongSelf;
        
        [strongSelf.orderListArray removeAllObjects];
        
        if (SUCCESS) {
        
            NSArray *orderList = dic[@"data"][@"list"];
            
            for (NSDictionary *order in orderList) {
                
                HZOrderModel *model = [[HZOrderModel alloc] init];
                
                model.rootId = order[@"id"];
                
                model.orderCode = order[@"ordersn"];
                
                model.orderGoodsNum = [order[@"goods_num"] stringValue];
                
                model.orderStatus = order[@"status"];
                
                model.orderStatusString = order[@"statusstr"];
                
                model.orderPrice = order[@"price"];
                
                NSArray *goodsList = order[@"goods"][0][@"goods"];
                
                for (NSDictionary *goods in goodsList) {
                 
                    HZGoodsModel *model1 = [[HZGoodsModel alloc] init];
                    
                    model1.rootTitle = goods[@"title"];
                    
                    model1.goodsNum = goods[@"total"];
                    
                    model1.rootImageUrl = goods[@"thumb"];
                    
                    model1.goodsPrice = goods[@"price"];
                    
                    [model.goodsArray addObject:model1];
                }
                
                [strongSelf.orderListArray addObject:model];
                
            }
            
        }else{
            
        }
        
        [strongSelf.myOrderTableView reloadData];
        
        [strongSelf.myOrderTableView.mj_header endRefreshing];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}

-(void)initMoreData
{

    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"status":_orderStatus,
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]
                           };
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:MY_ORDER parameters:dict HUD:NO success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        LOG(@"我的订单", dic);
        
        MJStrongSelf;
                
        if (SUCCESS) {
            
            NSArray *orderList = dic[@"data"][@"list"];
            
            for (NSDictionary *order in orderList) {
                
                HZOrderModel *model = [[HZOrderModel alloc] init];
                
                model.rootId = order[@"id"];
                
                model.orderCode = order[@"ordersn"];
                
                model.orderGoodsNum = [order[@"goods_num"] stringValue];
                
                model.orderStatus = order[@"status"];
                
                model.orderStatusString = order[@"statusstr"];

                model.orderPrice = order[@"price"];
                
                NSArray *goodsList = order[@"goods"][0][@"goods"];
                
                for (NSDictionary *goods in goodsList) {
                    
                    HZGoodsModel *model1 = [[HZGoodsModel alloc] init];
                    
                    model1.rootTitle = goods[@"title"];
                    
                    model1.goodsNum = goods[@"total"];
                    
                    model1.rootImageUrl = goods[@"thumb"];
                    
                    model1.goodsPrice = goods[@"price"];
                    
                    [model.goodsArray addObject:model1];
                }
                
                [strongSelf.orderListArray addObject:model];
                
            }
           
            [strongSelf.myOrderTableView reloadData];
            
            [strongSelf.myOrderTableView.mj_footer endRefreshing];
            
            if (orderList.count > 0) {
                
            }else{
                
                [JKToast showWithText:NOMOREDATA_STRING];
                
                [strongSelf.myOrderTableView.mj_footer endRefreshingWithNoMoreData];
                
            }
        }else{
            
        }
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
}
#pragma  mark ===TbaleViewDateSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _orderListArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HZOrderModel *model = _orderListArray[section];
    
    return model.goodsArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZOrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell" forIndexPath:indexPath];
    
    HZOrderModel *model1 = _orderListArray[indexPath.section];
    
    HZGoodsModel *model = model1.goodsArray[indexPath.row];
    
    cell.goodsTitle.text = model.rootTitle;
    
    cell.goodsPrice.text = model.goodsPrice;
    
    cell.goodsNum.text = [NSString stringWithFormat:@"X%@",model.goodsNum];
    
    [cell.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model.rootImageUrl] placeholderImage:[UIImage imageNamed:@"appIcon"]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZOrderModel *model = _orderListArray[indexPath.section];
    
    HZOrderDetailViewController *orderDetail = [[HZOrderDetailViewController alloc] init];
    
    orderDetail.orderId = model.rootId;
    
    [self.navigationController pushViewController:orderDetail animated:YES];

}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT(124);
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HZOrderModel *model = _orderListArray[section];
    
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 31)];
    
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,30,SCREEN_WIDTH - 20,1)];
    
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    
    [backView addSubview:lineLabel];
    
    UILabel *shanghu = [WYFTools createLabel:CGRectMake(10, 5, SCREEN_WIDTH/2-10, 20) bgColor:[UIColor clearColor] text:[NSString stringWithFormat:@"订单号:%@",model.orderCode] textFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHexString:@"#666666"] tag:section];
    
    shanghu.adjustsFontSizeToFitWidth = YES;
    
    [backView addSubview:shanghu];
    
    UILabel *dingdantime = [WYFTools createLabel:CGRectMake(SCREEN_WIDTH/2, 5, SCREEN_WIDTH/2-10, 20) bgColor:[UIColor clearColor] text:model.orderStatusString textFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:[UIColor colorWithHexString:@"666666"] tag:section];
    
    dingdantime.adjustsFontSizeToFitWidth = YES;
    
    [backView addSubview:dingdantime];
    
    return backView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 31;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    HZOrderModel *model = _orderListArray[section];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,39,SCREEN_WIDTH - 20,1)];
    
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];

    [bgView addSubview:lineLabel];
    
    UILabel *dingdanNum = [WYFTools createLabel:CGRectMake(10, 10, SCREEN_WIDTH - 20, 20) bgColor:[UIColor clearColor] text:@"" textFont:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:[UIColor colorWithHexString:@"#BABABA"] tag:section];
    
    NSString *string1 = [NSString stringWithFormat:@"共%@件商品,实付:",model.orderGoodsNum];
    
    NSString *string2 = [NSString stringWithFormat:@"￥%@",model.orderPrice];

    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",string1,string2]];
    
    [string3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FC575A"] range:NSMakeRange(string1.length,  string2.length)];
    
    [string3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(string1.length,string2.length)];

    dingdanNum.attributedText = string3;
    
    [bgView addSubview:dingdanNum];
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 48)];
    
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,40,SCREEN_WIDTH,8)];
    
    lineLabel1.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    
    [view addSubview:lineLabel1];
    
    UIButton *leftBtn = [WYFTools createButton:CGRectMake(SCREEN_WIDTH - 80 - 75, 8, 70, 25) bgColor:[UIColor clearColor] title:HZOrderCancleOrder titleFont:[UIFont systemFontOfSize:14] titleColor:[UIColor colorWithHexString:@"#666666"] slectedTitleColor:nil tag:section action:@selector(tapleftBtn:) vc:self];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor colorWithHexString:@"#666666"] withView:leftBtn];
    
    [view addSubview:leftBtn];
    
    UIButton *rightBtn = [WYFTools createButton:CGRectMake(SCREEN_WIDTH - 80, 8, 70, 25) bgColor:[UIColor clearColor] title:HZOrderPayNow titleFont:[UIFont systemFontOfSize:14] titleColor:[UIColor colorWithHexString:@"#FC575A"] slectedTitleColor:nil tag:section action:@selector(tapBtn:) vc:self];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor colorWithHexString:@"#FC575A"] withView:rightBtn];

    [view addSubview:rightBtn];
    
    view.backgroundColor=[UIColor whiteColor];
    
    if ([model.orderStatus isEqualToString:@"0"]) {

        [rightBtn setTitle:HZOrderPayNow forState:UIControlStateNormal];

        rightBtn.userInteractionEnabled = YES;

        rightBtn.hidden = NO;

        [leftBtn setTitle:HZOrderCancleOrder forState:UIControlStateNormal];

        leftBtn.userInteractionEnabled = YES;

        leftBtn.hidden = NO;

    }else if ([model.orderStatus isEqualToString:@"1"]){

        [rightBtn setTitle:HZOrderApplyForRefund forState:UIControlStateNormal];

        rightBtn.userInteractionEnabled = YES;

        rightBtn.hidden = NO;

        [leftBtn setTitle:HZOrderPayed forState:UIControlStateNormal];

        leftBtn.userInteractionEnabled = NO;

        leftBtn.hidden = NO;

    }else if ([model.orderStatus isEqualToString:@"2"]){

        [rightBtn setTitle:HZOrderConfirmReceive forState:UIControlStateNormal];

        rightBtn.userInteractionEnabled = YES;

        rightBtn.hidden = NO;

        [leftBtn setTitle:HZOrderLogisticsInfo forState:UIControlStateNormal];
        
        leftBtn.userInteractionEnabled = YES;
        
        leftBtn.hidden = NO;

    }else if ([model.orderStatus isEqualToString:@"4"]){

        [rightBtn setTitle:HZOrderGoEvaluate forState:UIControlStateNormal];

        rightBtn.userInteractionEnabled = YES;

        rightBtn.hidden = NO;

        leftBtn.hidden = YES;

    }
    
    CGSize size = [rightBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, rightBtn.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : rightBtn.titleLabel.font} context:nil].size;

    [rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@(size.width + 20));
        
        make.right.equalTo(view.mas_right).offset(-10);
        
        make.top.equalTo(view.mas_top).offset(8);
        
        make.height.mas_equalTo(25);
        
    }];
    
    [leftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(rightBtn.mas_left).offset(-5);
        
        make.width.equalTo(@(size.width + 20));
        
        make.top.equalTo(view.mas_top).offset(8);
        
        make.height.mas_equalTo(25);
        
    }];
    
    [WYFTools viewLayer:leftBtn.height/2 withView:leftBtn];

    [WYFTools viewLayer:rightBtn.height/2 withView:rightBtn];

    [bgView addSubview:view];
    
    return bgView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 88;
    
}
-(void)tapleftBtn:(UIButton *)sender
{
    
    
}
-(void)tapBtn:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:HZOrderPayNow]){
      //立即支付
        
    }else if ([sender.currentTitle isEqualToString:HZOrderApplyForRefund]){
      //申请退款
      
        HZApplyForRefundViewController *refund = [[HZApplyForRefundViewController alloc] init];
        
        [self.navigationController pushViewController:refund animated:YES];
        
    }else if ([sender.currentTitle isEqualToString:HZOrderConfirmReceive]){
      //确认收货
        
    }else if ([sender.currentTitle isEqualToString:HZOrderGoEvaluate]){
      //评价
        HZEvaluateViewController *evaluate = [[HZEvaluateViewController alloc] init];
        
        [self.navigationController pushViewController:evaluate animated:YES];
        
    }
 
}
- (IBAction)orderStatus:(UIButton *)sender {
    
    
    for (UIButton *button in sender.superview.subviews) {
        
        button.selected = NO;
        
    }
    
    sender.selected = YES;
    
    NSInteger num = sender.tag - 500;
        
    [self moveLineLabel:num];

}

-(void)moveLineLabel:(NSInteger)index
{
    
    switch (index) {
        case 0:
            _orderStatus = @"-1";
            
            break;
        case 1:
            _orderStatus = @"0";
            
            break;
        case 2:
            _orderStatus = @"1";
            
            break;
        case 3:
            _orderStatus = @"2";
            
            break;
        case 4:
            _orderStatus = @"3";
            
            break;
        default:
            break;
    }
    
    __block CGRect lineFrame  = CGRectMake(_lineLabel.frame.origin.x,_lineLabel.frame.origin.y,SCREEN_WIDTH/5, _lineLabel.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        
        lineFrame.origin.x = 1 + index*SCREEN_WIDTH/5;
        
        self->_lineLabel.frame = lineFrame;
        
        [self changebuttonColcor:index];
        
    }];
    
    [self initData];

}

-(void)changebuttonColcor:(NSInteger)index
{
    
    for (UIButton *btn in _headerView.subviews) {
        
        if (btn.tag == index + 500) {
            
            btn.selected = YES;
            
        }else{
            
            btn.selected = NO;

        }
        
    }
    
    
}

-(void)initnavBtn
{
    
    NSInteger num = 0;
    
    switch (_orderType) {
        
        case WXMyOrderAll:
            num = 0;
            break;
        case WXMyOrderUnPay:
            num = 1;
            break;
        case WXMyOrderUnSend:
            num = 2;
            break;
        case WXMyOrderUnReceive:
            num = 3;
            break;
        case WXMyOrderUnEvaluate:
            num = 4;
            break;
        default:
            break;
    }
    
    [self moveLineLabel:num];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self initnavBtn];
    
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
