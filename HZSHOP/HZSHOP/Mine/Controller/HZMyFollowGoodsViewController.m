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
}
-(void)initData
{
    _followGoodsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        
        HZGoodsModel *model = [[HZGoodsModel alloc] init];
        
        model.rootTitle = [NSString stringWithFormat:@"商品0%d",i];
        
        model.rootId = [NSString stringWithFormat:@"%d",i];
        
        model.goodsPrice = [NSString stringWithFormat:@"%d",i*10];
        
        [_followGoodsArray addObject:model];
        
    }
    
    [_followGoodsTableView reloadData];
    
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

        [self.followGoodsArray removeObject:_followGoodsArray[indexPath.row]];
        
        [self.followGoodsTableView reloadData];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
