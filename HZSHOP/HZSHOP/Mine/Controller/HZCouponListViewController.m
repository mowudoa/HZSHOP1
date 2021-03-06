//
//  HZCouponListViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/13.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCouponListViewController.h"
#import "HZcouponModel.h"
#import "HZCouponListTableViewCell.h"
#import "HZCouponDetailViewController.h"
@interface HZCouponListViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *couponTableView;

@property(nonatomic,strong) NSMutableArray *couponArray;

@end

@implementation HZCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
    [self initData];
    
}
-(void)initUI
{
    self.navigationItem.title = @"优惠券领取中心";
    
    _couponArray = [[NSMutableArray alloc] init];

    // 下拉加载
    self.couponTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initData];
        
    }];
    
    // 上拉刷新
    self.couponTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.nowPage ++;
        
        [self initMoreData];
        
    }];
    
    [WYFTools autuLayoutNewMJ:_couponTableView];
}

-(void)initData
{
    self.nowPage = 1;
    
    NSDictionary *dict = @{@"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]};
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Get:COUPON_CENTER parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json)
    {
        
        LOG(@"优惠券中心", dic);
        
        MJStrongSelf;
        
        [strongSelf.couponArray removeAllObjects];
        
        if (SUCCESS) {
           
            NSArray *couponList = dic[@"data"][@"list"];
            
            for (NSDictionary *coupnDic in couponList) {
                
                HZcouponModel *model = [[HZcouponModel alloc] init];
                
                model.rootId = coupnDic[@"id"];
                
                model.rootTitle = coupnDic[@"couponname"];
                
                model.couponMoney = coupnDic[@"_backmoney"];
                
                model.couponLimit = coupnDic[@"title2"];
                
                model.couponInfo = coupnDic[@"title5"];
                
                model.couponNum = [coupnDic[@"last"] stringValue];
                
                model.couponStockNum = [coupnDic[@"total"] stringValue];
                
                model.couponLifeTime = coupnDic[@"title4"];
                
                [strongSelf.couponArray addObject:model];
                
            }
            
        }else{
            
            
        }
        
        [strongSelf.couponTableView reloadData];
        
        [strongSelf.couponTableView.mj_header endRefreshing];

    } fail:^(NSError *error, NSString *url, NSString *Json) {
                               
        
    }];
    
}

-(void)initMoreData
{
    
    NSDictionary *dict = @{@"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]};
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Get:COUPON_CENTER parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json)
     {
         
         LOG(@"优惠券中心", dic);
         
         MJStrongSelf;
         
         if (SUCCESS) {
             
             NSArray *couponList = dic[@"data"][@"list"];
             
             for (NSDictionary *coupnDic in couponList) {
                 
                 HZcouponModel *model = [[HZcouponModel alloc] init];
                 
                 model.rootId = coupnDic[@"id"];
                 
                 model.rootTitle = coupnDic[@"couponname"];
                 
                 model.couponMoney = coupnDic[@"_backmoney"];
                 
                 model.couponLimit = coupnDic[@"title2"];
                 
                 model.couponInfo = coupnDic[@"title5"];
                 
                 model.couponNum = [coupnDic[@"last"] stringValue];
                 
                 model.couponStockNum = [coupnDic[@"total"] stringValue];
                 
                 model.couponLifeTime = coupnDic[@"title4"];
                 
                 [strongSelf.couponArray addObject:model];
                 
             }
            
             [strongSelf.couponTableView reloadData];
             
             [strongSelf.couponTableView.mj_footer endRefreshing];
             
             if (couponList.count > 0) {
                 
             }else{
                 
                 [JKToast showWithText:NOMOREDATA_STRING];
                 
                 [strongSelf.couponTableView.mj_footer endRefreshingWithNoMoreData];
                 
             }
             
         }else{
             
             
         }
         
     } fail:^(NSError *error, NSString *url, NSString *Json) {
         
         
     }];
    
}
-(void)registercell
{
    
    _couponTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib* nib   =[UINib nibWithNibName:@"HZCouponListTableViewCell" bundle:nil];
    
    [_couponTableView registerNib:nib forCellReuseIdentifier:@"CouponListTableViewCell"];
    
}

#pragma mark - UITableViewDataSource  数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _couponArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZCouponListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CouponListTableViewCell" forIndexPath:indexPath];
    
    HZcouponModel *model = _couponArray[indexPath.row];
    
    cell.couponTitle.text = [cell.couponTitle.text stringByAppendingString:model.rootTitle];
    
    cell.couponMoney.text = [NSString stringWithFormat:@"￥%@",model.couponMoney];
    
    cell.couponLimit.text = model.couponLimit;
    
    cell.couponInfo.text = model.couponInfo;
    
    cell.couponStockNum.text = [NSString stringWithFormat:@"剩余%@/%@",model.couponNum,model.couponStockNum];
    
    cell.couponLifeTime.text = model.couponLifeTime;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZcouponModel *model = _couponArray[indexPath.row];
   
    HZCouponDetailViewController *detail = [[HZCouponDetailViewController alloc] init];
    
    detail.couponId = model.rootId;
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - UITableViewDelegate  代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
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
