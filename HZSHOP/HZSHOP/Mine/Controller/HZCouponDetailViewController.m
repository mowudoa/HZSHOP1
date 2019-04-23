//
//  HZCouponDetailViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/18.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCouponDetailViewController.h"
#import "HZcouponModel.h"
#import "HZHeaderTableViewCell.h"
#import "HZCouponInfoTableViewCell.h"
#import "HZCouponLimeitTableViewCell.h"

@interface HZCouponDetailViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *couponDetailTableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIView *lineView;//白色线框view

@property (weak, nonatomic) IBOutlet UIButton *buyButton;//立即领取

@property (weak, nonatomic) IBOutlet UILabel *couponTitle;

@property (weak, nonatomic) IBOutlet UILabel *couponMoney;

@property (weak, nonatomic) IBOutlet UILabel *couopnLimit;

@property (weak, nonatomic) IBOutlet UILabel *couponLifeTime;

@property(nonatomic,strong) NSMutableArray *couponArray;

@property(assign,nonatomic)BOOL isUserMoney;

@end

@implementation HZCouponDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registerCell];
 
    [self initData];
    
}
-(void)initUI
{
    
    self.navigationItem.title = @"详情";
    
    _isUserMoney = NO;
    
    _couponArray = [[NSMutableArray alloc] init];
    
    self.couponDetailTableView.tableHeaderView = self.headerView;

    [WYFTools viewLayer:5 withView:_couponDetailTableView];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor whiteColor] withView:_lineView];
    
    [WYFTools viewLayer:5 withView:_buyButton];
    
}

-(void)registerCell
{
   
    UINib* nib = [UINib nibWithNibName:@"HZHeaderTableViewCell" bundle:nil];
    
    [_couponDetailTableView registerNib:nib forCellReuseIdentifier:@"HeaderTableViewCell"];
    
    UINib* nib1 = [UINib nibWithNibName:@"HZCouponInfoTableViewCell" bundle:nil];
    
    [_couponDetailTableView registerNib:nib1 forCellReuseIdentifier:@"CouponInfoTableViewCell"];
    
    UINib* nib2 = [UINib nibWithNibName:@"HZCouponLimeitTableViewCell" bundle:nil];
    
    [_couponDetailTableView registerNib:nib2 forCellReuseIdentifier:@"CouponLimeitTableViewCell"];
    
}

-(void)initData
{
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"id":_couponId
                           };
    
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:COUPON_DETAIL parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        LOG(@"优惠券详情", dic)
        
        MJStrongSelf;
        
        if (SUCCESS) {
        
            NSDictionary *coupon = dic[@"data"][@"coupon"];
            
            strongSelf.couponTitle.text = coupon[@"couponname"];
            
            strongSelf.couponMoney.text = [NSString stringWithFormat:@"￥%@",coupon[@"_backmoney"]];
            
            strongSelf.couopnLimit.text = coupon[@"title2"];
            
            NSString *lifeTime;
            
            if ([coupon[@"timestr"] isEqualToString:@"0"]) {
             
                lifeTime = @"永久有效";
                
                strongSelf.couponLifeTime.text = [NSString stringWithFormat:@"有效期%@",lifeTime];
                
            }else if ([coupon[@"timestr"] isEqualToString:@"0"]){
                
                lifeTime = [NSString stringWithFormat:@"即%@日内%@天有效",coupon[@"gettypestr"],coupon[@"timedays"]];
                
                strongSelf.couponLifeTime.text = lifeTime;
                
            }else{
             
                lifeTime = [NSString stringWithFormat:@"有效期:%@",coupon[@"timestr"]];

                strongSelf.couponLifeTime.text = [NSString stringWithFormat:@"有效期%@",lifeTime];
                
            }
            
            if (coupon[@"money"] != nil) {
              
                strongSelf.isUserMoney = YES;
                
                HZcouponModel *model = [[HZcouponModel alloc] init];
                
                model.couponBuyMoney = coupon[@"money"];
                
                model.couponBuyIntegral = coupon[@"credit"];

                [strongSelf.couponArray addObject:model];
                
            }
            
            
        }else{
            
            
        }
        
        [strongSelf.couponDetailTableView reloadData];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}

#pragma mark 立即领取/购买
- (IBAction)buyNow:(UIButton *)sender {
}

#pragma mark - UITableViewDataSource  数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_isUserMoney) {
        
        return 5;
        
    }
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isUserMoney) {
    
        if (indexPath.row == 0) {
            
            HZHeaderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderTableViewCell" forIndexPath:indexPath];
            
            return cell;
            
        }else if (indexPath.row == 1){
            
            HZCouponInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CouponInfoTableViewCell" forIndexPath:indexPath];
            
            [self configureCell:cell atIndexPath:indexPath];
            
            return cell;
            
        }else{
            
            HZCouponLimeitTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CouponLimeitTableViewCell" forIndexPath:indexPath];
            
            [self configureCell:cell atIndexPath:indexPath];
            
            return cell;
            
        }

    }else{
        
        if (indexPath.row == 0) {
            
            HZHeaderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderTableViewCell" forIndexPath:indexPath];
            
            return cell;
            
        }else{
            
            HZCouponLimeitTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CouponLimeitTableViewCell" forIndexPath:indexPath];
            
            [self configureCell:cell atIndexPath:indexPath];
            
            return cell;
            
        }

    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"

    if (_isUserMoney) {
        
        if (indexPath.row == 1) {
            
            if (_couponArray.count <= 0) {
                
                return;
            }
            
            HZCouponInfoTableViewCell *infocell = ((HZCouponInfoTableViewCell *)cell);
            
            HZcouponModel *model = _couponArray[indexPath.row - 1];
            
            infocell.moneyNum.text = [NSString stringWithFormat:@"所需金额:%@",model.couponBuyMoney];
            
            infocell.integralNum.text = [NSString stringWithFormat:@"所需积分:%@",model.couponBuyIntegral];
            
        }else{
            
            HZCouponLimeitTableViewCell *infocell = ((HZCouponLimeitTableViewCell *)cell);
            
            infocell.titleInfo.text = @"限制啊";
            
        }
        
    }else{
        
        HZCouponLimeitTableViewCell *infocell = ((HZCouponLimeitTableViewCell *)cell);
        
        infocell.titleInfo.text = @"限制啊";
        
    }
    
   
    
}


#pragma mark - UITableViewDelegate  代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isUserMoney) {
        
        if (indexPath.row == 0) {
            
            return 20;
            
        }else if (indexPath.row == 1){
            
            return [tableView fd_heightForCellWithIdentifier:@"CouponInfoTableViewCell" cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
                
                [self configureCell:cell atIndexPath:indexPath];
                
            }];
            
        }
        
        return [tableView fd_heightForCellWithIdentifier:@"CouponLimeitTableViewCell" cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
            
            [self configureCell:cell atIndexPath:indexPath];
            
        }];;
        
    }else{
    
        if (indexPath.row == 0) {
            
            return 20;
            
        }
        
        return [tableView fd_heightForCellWithIdentifier:@"CouponLimeitTableViewCell" cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
            
            [self configureCell:cell atIndexPath:indexPath];
            
        }];;
        
    }

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
