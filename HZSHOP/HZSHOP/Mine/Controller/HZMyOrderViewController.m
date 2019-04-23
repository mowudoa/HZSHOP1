//
//  HZMyOrderViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/17.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZMyOrderViewController.h"
#import "HZOrderModel.h"
#import "HZOrderTableViewCell.h"
#import "HZOrderDetailViewController.h"
@interface HZMyOrderViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *myOrderTableView;

@property(nonatomic,strong) UILabel *lineLabel;

@property(nonatomic,copy) NSString *orderStatus;

@property(nonatomic,strong) NSMutableArray *orderListArray;

@property (strong, nonatomic) IBOutlet UIView *orderNumForSection;

@end

@implementation HZMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
    [self initData];
    
}

-(void)initUI
{
    _orderListArray = [[NSMutableArray alloc] init];
    
    self.navigationItem.title = @"我的订单";
    
    _lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(1,41,SCREEN_WIDTH/5,2)];
    
    _lineLabel.backgroundColor=[UIColor colorWithHexString:@"#FC575A"];
    
    [self.view addSubview:_lineLabel];
    
}

-(void)registercell
{
    UINib* nib = [UINib nibWithNibName:@"HZOrderTableViewCell" bundle:nil];
    
    [_myOrderTableView registerNib:nib forCellReuseIdentifier:@"OrderTableViewCell"];
    
}

-(void)initData
{
    
    for (int i = 0; i < 10; i ++) {
        
        HZOrderModel *model = [[HZOrderModel alloc] init];
        
        [_orderListArray addObject:model];
        
    }
    
    [_myOrderTableView reloadData];
    
}

#pragma  mark ===TbaleViewDateSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _orderListArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZOrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell" forIndexPath:indexPath];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZOrderDetailViewController *orderDetail = [[HZOrderDetailViewController alloc] init];
    
    [self.navigationController pushViewController:orderDetail animated:YES];

}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT(124);
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 31)];
    
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,30,SCREEN_WIDTH - 20,1)];
    
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    
    [backView addSubview:lineLabel];
    
    UILabel *shanghu = [WYFTools createLabel:CGRectMake(10, 5, SCREEN_WIDTH/2-10, 20) bgColor:[UIColor clearColor] text:@"订单号:SH20190418092212" textFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHexString:@"#666666"] tag:section];
    
    shanghu.adjustsFontSizeToFitWidth = YES;
    
    [backView addSubview:shanghu];
    
    UILabel *dingdantime = [WYFTools createLabel:CGRectMake(SCREEN_WIDTH/2, 5, SCREEN_WIDTH/2-10, 20) bgColor:[UIColor clearColor] text:@"待付款" textFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:[UIColor colorWithHexString:@"666666"] tag:section];
    
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
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,39,SCREEN_WIDTH - 20,1)];
    
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];

    [bgView addSubview:lineLabel];
    
    UILabel *dingdanNum = [WYFTools createLabel:CGRectMake(10, 10, SCREEN_WIDTH - 20, 20) bgColor:[UIColor clearColor] text:@"" textFont:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:[UIColor colorWithHexString:@"#BABABA"] tag:section];
    
    NSString *string1 = @"共一件商品,实付:";
    
    NSString *string2 = @"Y11.00";

    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",string1,string2]];
    
    [string3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FC575A"] range:NSMakeRange(string1.length,  string2.length)];
    
    [string3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(string1.length,string2.length)];

    dingdanNum.attributedText = string3;
    
    [bgView addSubview:dingdanNum];
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 48)];
    
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,40,SCREEN_WIDTH,8)];
    
    lineLabel1.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    
    [view addSubview:lineLabel1];
    
    UIButton *leftBtn = [WYFTools createButton:CGRectMake(SCREEN_WIDTH - 80 - 75, 8, 70, 25) bgColor:[UIColor clearColor] title:@"取消订单" titleFont:[UIFont systemFontOfSize:14] titleColor:[UIColor colorWithHexString:@"#666666"] slectedTitleColor:nil tag:section action:@selector(tapleftBtn:) vc:self];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor colorWithHexString:@"#666666"] withView:leftBtn];
    
    [view addSubview:leftBtn];
    
    UIButton *rightBtn = [WYFTools createButton:CGRectMake(SCREEN_WIDTH - 80, 8, 70, 25) bgColor:[UIColor clearColor] title:@"支付订单" titleFont:[UIFont systemFontOfSize:14] titleColor:[UIColor colorWithHexString:@"#FC575A"] slectedTitleColor:nil tag:section action:@selector(tapBtn:) vc:self];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor colorWithHexString:@"#FC575A"] withView:rightBtn];

    [view addSubview:rightBtn];
    
    view.backgroundColor=[UIColor whiteColor];
    
//    if ([model.orderStatus isEqualToString:@"0"]) {
//
//        [rightBtn setTitle:@"付款" forState:UIControlStateNormal];
//
//        rightBtn.userInteractionEnabled = YES;
//
//        rightBtn.hidden = NO;
//
//        [leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
//
//        leftBtn.userInteractionEnabled = YES;
//
//        leftBtn.hidden = NO;
//
//    }else if ([model.orderStatus isEqualToString:@"1"]){
//
//        [rightBtn setTitle:@"申请退款" forState:UIControlStateNormal];
//
//        rightBtn.userInteractionEnabled = YES;
//
//        rightBtn.hidden = NO;
//
//        [leftBtn setTitle:@"已付款" forState:UIControlStateNormal];
//
//        leftBtn.userInteractionEnabled = NO;
//
//        leftBtn.backgroundColor = [UIColor colorWithHexString:@"#B5B5B5"];
//
//        leftBtn.hidden = NO;
//
//    }else if ([model.orderStatus isEqualToString:@"2"]){
//
//        [rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
//
//        rightBtn.userInteractionEnabled = YES;
//
//        rightBtn.hidden = NO;
//
//        leftBtn.hidden = YES;
//
//    }else if ([model.orderStatus isEqualToString:@"8"]){
//
//        if ([model.orderType isEqualToString:@"0"]) {
//
//            [rightBtn setTitle:@"我要评价" forState:UIControlStateNormal];
//
//        }else if ([model.orderType isEqualToString:@"1"]){
//
//            [rightBtn setTitle:@"已评价" forState:UIControlStateNormal];
//
//            rightBtn.backgroundColor = [UIColor colorWithHexString:@"#B5B5B5"];
//
//        }
//
//        rightBtn.userInteractionEnabled = YES;
//
//        rightBtn.hidden = NO;
//
//        leftBtn.hidden = YES;
//
//    }else if ([model.orderStatus isEqualToString:@"4"]){
//
//        [rightBtn setTitle:@"取消退款" forState:UIControlStateNormal];
//        rightBtn.userInteractionEnabled = YES;
//
//        rightBtn.hidden = NO;
//
//        leftBtn.hidden = YES;
//
//    }else if ([model.orderStatus isEqualToString:@"5"]){
//
//        rightBtn.hidden = YES;
//
//        leftBtn.hidden = YES;
//    }
    
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
            _orderStatus = @"1";
            
            _orderType = WXMyOrderAll;
            break;
        case 1:
            _orderStatus = @"2";
            _orderType = WXMyOrderUnPay;
            
            break;
        case 2:
            _orderStatus = @"11";
            _orderType = WXMyOrderUnSend;
            
            break;
        case 3:
            _orderStatus = @"8";
            _orderType = WXMyOrderUnReceive;
            
            break;
        case 4:
            _orderStatus = @"4";
            _orderType = WXMyOrderComplete;
            
            break;
        default:
            break;
    }
    
    __block CGRect lineFrame  = CGRectMake(_lineLabel.frame.origin.x,_lineLabel.frame.origin.y,SCREEN_WIDTH/5, _lineLabel.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        
        lineFrame.origin.x = 1 + index*SCREEN_WIDTH/5;
        
        self->_lineLabel.frame = lineFrame;
        
    }];
    
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
        case WXMyOrderComplete:
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
