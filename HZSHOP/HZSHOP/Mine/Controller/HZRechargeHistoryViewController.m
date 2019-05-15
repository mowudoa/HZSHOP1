//
//  HZRechargeHistoryViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/19.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZRechargeHistoryViewController.h"
#import "HZRechareModel.h"
#import "HZRechargeHistoryTableViewCell.h"
@interface HZRechargeHistoryViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *rechargeHistoryTableView;

@property(nonatomic,strong) NSMutableArray *rechageArray;

@end

@implementation HZRechargeHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registrCell];
    
    [self initData];
    
}

-(void)initUI
{
    self.navigationItem.title = @"充值记录";
    
    _rechageArray = [[NSMutableArray alloc] init];
    
}

-(void)registrCell
{
    UINib *nib = [UINib nibWithNibName:@"HZRechargeHistoryTableViewCell" bundle:nil];
    
    [_rechargeHistoryTableView registerNib:nib forCellReuseIdentifier:@"RechargeHistoryTableViewCell"];
    
    // 下拉加载
    self.rechargeHistoryTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initData];
        
    }];
    
    // 上拉刷新
    self.rechargeHistoryTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.nowPage ++;
        
        [self initMoreData];
        
    }];
    
    [WYFTools autuLayoutNewMJ:_rechargeHistoryTableView];
    
}

-(void)initData
{
    self.nowPage = 1;
    
    MJWeakSelf;
    
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]
                           };

    
    [CrazyNetWork CrazyRequest_Post:MY_RECHARGE_HISTORRY parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
       
        LOG(@"充值记录", dic);
        
        MJStrongSelf;
        
        [strongSelf.rechageArray removeAllObjects];

        if (SUCCESS) {
            
            NSArray *rechargeArr = dic[@"data"][@"list"];
            
            for (NSDictionary *dic1 in rechargeArr) {
                
                HZRechareModel *model = [[HZRechareModel alloc] init];
                
                model.rootTitle = dic1[@"title"];
                
                model.rechargeStatus = dic1[@"status"];
                
                model.rechargeTime = dic1[@"createtime"];
                
                model.rechargeMoney = dic1[@"money"];
                
                model.rechargeType = dic1[@"rechargetype"];
                
                model.rechargeRemark = dic1[@"remark"];
                
                [strongSelf.rechageArray addObject:model];
                
            }
            
            
        }else{
            
            
        }
        
        [strongSelf.rechargeHistoryTableView reloadData];
        
        [strongSelf.rechargeHistoryTableView.mj_header endRefreshing];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}

-(void)initMoreData
{
    
    MJWeakSelf;
    
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]
                           };
    
    
    [CrazyNetWork CrazyRequest_Post:MY_RECHARGE_HISTORRY parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        LOG(@"充值记录", dic);
        
        MJStrongSelf;
                
        if (SUCCESS) {
            
            NSArray *rechargeArr = dic[@"data"][@"list"];
            
            for (NSDictionary *dic1 in rechargeArr) {
                
                HZRechareModel *model = [[HZRechareModel alloc] init];
                
                model.rootTitle = dic1[@"title"];
                
                model.rechargeStatus = dic1[@"status"];
                
                model.rechargeTime = dic1[@"createtime"];
                
                model.rechargeMoney = dic1[@"money"];
                
                model.rechargeType = dic1[@"rechargetype"];
                
                model.rechargeRemark = dic1[@"remark"];
                
                [strongSelf.rechageArray addObject:model];
                
            }
          
            [strongSelf.rechargeHistoryTableView reloadData];
            
            [strongSelf.rechargeHistoryTableView.mj_footer endRefreshing];
            
            if (rechargeArr.count > 0) {
                
            }else{
                
                [JKToast showWithText:NOMOREDATA_STRING];
                
                [strongSelf.rechargeHistoryTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            
            
        }
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _rechageArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZRechargeHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeHistoryTableViewCell"];
    
    HZRechareModel *model = _rechageArray[indexPath.row];
    
    cell.rechargeMoneyLabel.text = [NSString stringWithFormat:@"%@:%@元",model.rootTitle,model.rechargeMoney];
    
    cell.rechargeTimeLabel.text = model.rechargeTime;
    
    if ([model.rechargeStatus isEqualToString:@"1"]) {
        
        cell.rechargeStatusLabel.text = @"成功";
        
        cell.rechargeStatusLabel.backgroundColor = [UIColor colorWithHexString:@"#1AA91B"];
        
    }else if ([model.rechargeStatus isEqualToString:@"-1"]){
        
        cell.rechargeStatusLabel.text = @"失败";
        
        cell.rechargeStatusLabel.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];

    }
    
    return cell;
    
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 60;
    
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
