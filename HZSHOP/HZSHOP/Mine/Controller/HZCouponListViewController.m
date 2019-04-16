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
}
-(void)initData
{
    
    _couponArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        
        HZcouponModel *model = [[HZcouponModel alloc] init];
        
        model.couponTitle = [NSString stringWithFormat:@"优惠券%d",i];
        
        [_couponArray addObject:model];
        
    }
    
    [_couponTableView reloadData];
    
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
    
    cell.couponTitle.text = [cell.couponTitle.text stringByAppendingString:model.couponTitle];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
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
