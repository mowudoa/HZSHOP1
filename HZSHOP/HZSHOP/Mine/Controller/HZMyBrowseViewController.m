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
}
-(void)initData
{
    _browseListArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        
        HZGoodsModel *model = [[HZGoodsModel alloc] init];
        
        model.rootTitle = [NSString stringWithFormat:@"商品0%d",i];
        
        model.rootId = [NSString stringWithFormat:@"%d",i];
        
        model.goodsPrice = [NSString stringWithFormat:@"%d",i*10];
        
        [_browseListArray addObject:model];
        
    }
    
    [_browsListTableView reloadData];
    
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
    
    cell.goodsPrice.text = model.goodsPrice;
    
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 31)];
    
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,30,SCREEN_WIDTH - 10,1)];
    
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    
    [backView addSubview:lineLabel];
    
    UILabel *timeLabel = [WYFTools createLabel:CGRectMake(10,0,SCREEN_WIDTH - 20,30) bgColor:[UIColor clearColor] text:@"2019-02-19 12:11:10" textFont:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHexString:@"#686868"] tag:section];
    
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
        
        [self.browseListArray removeObject:_browseListArray[indexPath.section]];
        
        [self.browsListTableView reloadData];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
