//
//  HZMyFollowGoodsViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/11.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZMyFollowGoodsViewController.h"
#import "HZGoodsModel.h"
#import "HZMyFollowTableViewCell.h"
#import "HZGoodsDetailViewController.h"

@interface HZMyFollowGoodsViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *followGoodsTableView;

@property(nonatomic,strong) NSMutableArray *followGoodsArray;

@end

@implementation HZMyFollowGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initUI];
    
    [self initData];
    
    [self registercell];
    
}
-(void)initUI
{
    self.navigationItem.title = @"我的关注";
    
    _followGoodsArray = [[NSMutableArray alloc] init];
    
}
-(void)initData
{
    NSDictionary *dict = @{USER_ID:@"wap_user_4_13720999978"};

    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:MY_FOLLOW parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
      
        MJStrongSelf;
        
        [strongSelf.followGoodsArray removeAllObjects];
        
        LOG(@"我的关注", dic);
        
        if (SUCCESS) {
           
            NSArray *followArray = dic[@"data"][@"list"];
            
            for (NSDictionary *follw in followArray) {
                
                HZGoodsModel *model = [[HZGoodsModel alloc] init];
                
                model.rootId = follw[@"id"];
                
                model.rootTitle = follw[@"title"];
                
                model.goodsOldPrice = follw[@"marketprice"];
                
                model.goodsPrice = follw[@"productprice"];
                
                model.goodsId = follw[@"goodsid"];
                
                model.rootImageUrl = follw[@"thumb"];
                
                [strongSelf.followGoodsArray addObject:model];
                
            }
            
            
        }else{
            
            
        }
        
        [strongSelf.followGoodsTableView reloadData];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}
-(void)registercell
{
    
    _followGoodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib* nib   =[UINib nibWithNibName:@"HZMyFollowTableViewCell" bundle:nil];
    
    [_followGoodsTableView registerNib:nib forCellReuseIdentifier:@"FollowTableViewCell"];
    
}

#pragma mark - UITableViewDataSource  数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _followGoodsArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZMyFollowTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FollowTableViewCell" forIndexPath:indexPath];
    
    HZGoodsModel *model = _followGoodsArray[indexPath.row];
    
    cell.goodsTitle.text = model.rootTitle;
    
    cell.goodsPrice.text = model.goodsPrice;
    
    cell.goodsOldPrice.attributedText = [WYFTools AddCenterLineToView:    [NSString stringWithFormat:@"￥%@",model.goodsOldPrice]];
    
    [cell.iamgeIcon sd_setImageWithURL:[NSURL URLWithString:model.rootImageUrl] placeholderImage:[UIImage imageNamed:@"appIcon"]];
    
    return cell;
    
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
     
        [self cancleGoodsFollow:indexPath];
        
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark 取消关注
-(void)cancleGoodsFollow:(NSIndexPath *)indexpath
{

    HZGoodsModel *model = _followGoodsArray[indexpath.row];
    
    MJWeakSelf;
    
    NSDictionary *dict = @{USER_ID:@"wap_user_4_13720999978",
                           @"ids":model.rootId
                           };

    [CrazyNetWork CrazyRequest_Post:CANCLE_FOLLOW parameters:dict HUD:NO success:^(NSDictionary *dic, NSString *url, NSString *Json) {
      
        LOG(@"取消关注", dic);
        
        MJStrongSelf;
        
        if (SUCCESS) {
        
            [strongSelf.followGoodsArray removeObject:strongSelf.followGoodsArray[indexpath.row]];
            
            [strongSelf.followGoodsTableView reloadData];
            
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
