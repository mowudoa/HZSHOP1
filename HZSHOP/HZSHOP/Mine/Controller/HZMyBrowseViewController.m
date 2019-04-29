//
//  HZMyBrowseViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/11.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZMyBrowseViewController.h"
#import "HZGoodsModel.h"
#import "HZMyFollowTableViewCell.h"
#import "HZGoodsDetailViewController.h"

@interface HZMyBrowseViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *browsListTableView;

@property(nonatomic,strong) NSMutableArray *browseListArray;

@end

@implementation HZMyBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self initData];
    
    [self registercell];
    
}

-(void)initUI
{
    self.navigationItem.title = @"我的足迹";
    
    _browseListArray = [[NSMutableArray alloc] init];

    // 下拉加载
    self.browsListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initData];
        
    }];
    
    // 上拉刷新
    self.browsListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.nowPage ++;
        
        [self initMoreData];
        
    }];
    
    [WYFTools autuLayoutNewMJ:_browsListTableView];
    
}
-(void)initData
{
    self.nowPage = 1;
    
    NSDictionary *dict = @{USER_ID:@"wap_user_4_13720999978",
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]
                           };
    
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:MY_BROWSE parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        MJStrongSelf;
        
        LOG(@"我的足迹", dic);
        
        [strongSelf.browseListArray removeAllObjects];
        
        if (SUCCESS) {
            
            NSArray *followArray = dic[@"data"][@"list"];
            
            for (NSDictionary *follw in followArray) {
                
                HZGoodsModel *model = [[HZGoodsModel alloc] init];
                
                model.rootId = follw[@"id"];
                
                model.rootTitle = follw[@"title"];
                
                model.goodsPrice = follw[@"marketprice"];
                
                model.goodsOldPrice = follw[@"productprice"];
                
                model.goodsId = follw[@"goodsid"];
                
                model.goodsTime = follw[@"createtime"];
                
                model.rootImageUrl = follw[@"thumb"];
                
                [strongSelf.browseListArray addObject:model];
                
            }
            
        }else{
            
            
        }
        
        [strongSelf.browsListTableView reloadData];
        
        [strongSelf.browsListTableView.mj_header endRefreshing];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}

-(void)initMoreData
{
    
    NSDictionary *dict = @{USER_ID:@"wap_user_4_13720999978",
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]
                           };
    
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:MY_BROWSE parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        MJStrongSelf;
        
        LOG(@"我的足迹", dic);
        
        if (SUCCESS) {
            
            NSArray *followArray = dic[@"data"][@"list"];
            
            for (NSDictionary *follw in followArray) {
                
                HZGoodsModel *model = [[HZGoodsModel alloc] init];
                
                model.rootId = follw[@"id"];
                
                model.rootTitle = follw[@"title"];
                
                model.goodsPrice = follw[@"marketprice"];
                
                model.goodsOldPrice = follw[@"productprice"];
                
                model.goodsId = follw[@"goodsid"];
                
                model.goodsTime = follw[@"createtime"];
                
                model.rootImageUrl = follw[@"thumb"];
                
                [strongSelf.browseListArray addObject:model];
                
            }
            
            [strongSelf.browsListTableView reloadData];
            
            [strongSelf.browsListTableView.mj_footer endRefreshing];
            
            if (followArray.count > 0) {
                
            }else{
                
                [JKToast showWithText:NOMOREDATA_STRING];
                
                [strongSelf.browsListTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            
            
        }
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}
-(void)registercell
{
    
    _browsListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib* nib   =[UINib nibWithNibName:@"HZMyFollowTableViewCell" bundle:nil];
    
    [_browsListTableView registerNib:nib forCellReuseIdentifier:@"FollowTableViewCell"];
    
}

#pragma mark - UITableViewDataSource  数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _browseListArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZMyFollowTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FollowTableViewCell" forIndexPath:indexPath];
    
    HZGoodsModel *model = _browseListArray[indexPath.section];
    
    cell.goodsTitle.text = model.rootTitle;
    
    cell.goodsPrice.text = [NSString stringWithFormat:@"￥%@",model.goodsPrice];
    
    cell.goodsOldPrice.attributedText = [WYFTools AddCenterLineToView:    [NSString stringWithFormat:@"￥%@",model.goodsOldPrice]];
    
    [cell.iamgeIcon sd_setImageWithURL:[NSURL URLWithString:model.rootImageUrl] placeholderImage:[UIImage imageNamed:@"appIcon"]];
    
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HZGoodsModel *model = _browseListArray[section];
    
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 31)];
    
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,30,SCREEN_WIDTH - 10,1)];
    
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    
    [backView addSubview:lineLabel];
    
    UILabel *timeLabel = [WYFTools createLabel:CGRectMake(10,0,SCREEN_WIDTH - 20,30) bgColor:[UIColor clearColor] text:model.goodsTime textFont:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHexString:@"#686868"] tag:section];
    
    [backView addSubview:timeLabel];
    
    return backView;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZGoodsDetailViewController *detail = [[HZGoodsDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - UITableViewDelegate  代理
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //只要实现这个方法，就实现了默认滑动删除！！！！！
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [self cancleGoodsBrowse:indexPath];
        
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 124;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 31;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark 删除历史记录
-(void)cancleGoodsBrowse:(NSIndexPath *)indexpath
{
    
    HZGoodsModel *model = _browseListArray[indexpath.section];
    
    MJWeakSelf;
    
    NSDictionary *dict = @{USER_ID:@"wap_user_4_13720999978",
                           @"ids":model.rootId
                           };
    
    [CrazyNetWork CrazyRequest_Post:DELETE_BROWSE parameters:dict HUD:NO success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        LOG(@"删除历史记录", dic);
        
        MJStrongSelf;
        
        if (SUCCESS) {
            
            [strongSelf.browseListArray removeObject:strongSelf.browseListArray[indexpath.section]];
            
            [strongSelf.browsListTableView reloadData];
            
        }else{
            
            [JKToast showWithText:dic[@"message"]];
        }
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
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
