//
//  HZMyCouponsViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/13.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZMyCouponsViewController.h"
#import "HZcouponModel.h"
#import "HZCouponListTableViewCell.h"
#import "HZCouponDetailViewController.h"
@interface HZMyCouponsViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *myCouponTableView;

@property(nonatomic,strong) UILabel *lineLabel;

@property(nonatomic,copy) NSString *couponStatus;

@property(nonatomic,strong) NSMutableArray *couponArray;

@end

@implementation HZMyCouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
    [self initData];
    
}
-(void)initUI
{
    
    self.navigationItem.title = @"我的优惠券";
    
    _couponArray = [[NSMutableArray alloc] init];

    _lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,40,SCREEN_WIDTH/3,2)];
    
    _lineLabel.backgroundColor=[UIColor colorWithHexString:@"#FF0270"];
    
    [self.view addSubview:_lineLabel];
    
    
    [WYFTools autuLayoutNewMJ:_myCouponTableView];
    
}

-(void)registercell
{
    
    _myCouponTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib* nib   =[UINib nibWithNibName:@"HZCouponListTableViewCell" bundle:nil];
    
    [_myCouponTableView registerNib:nib forCellReuseIdentifier:@"CouponListTableViewCell"];
    
}

- (IBAction)couponStatus:(UIButton *)sender {
    
    for (UIView *view in sender.superview.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            ((UIButton *)view).selected = NO;
            
        }
        
    }
    
    sender.selected = !sender.selected;

    
    NSInteger num = sender.tag - 300;
    
    [self moveLineLabel:num];
    
}

-(void)moveLineLabel:(NSInteger)index
{
    
    switch (index) {
        case 0:
            _couponStatus = @"3";
            break;
        case 1:
            _couponStatus = @"1";
            break;
        case 2:
            _couponStatus = @"2";
            break;
        default:
            break;
    }
    
    
    __block CGRect lineFrame  = CGRectMake(_lineLabel.mj_x,_lineLabel.mj_y,SCREEN_WIDTH/3, _lineLabel.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        lineFrame.origin.x = index* SCREEN_WIDTH /3;
        
        self->_lineLabel.frame = lineFrame;
    }];
    
    [self initData];
    
}

-(void)initData
{
    
    for (int i = 0; i < 10; i ++) {
        
         HZcouponModel*model = [[HZcouponModel alloc] init];
        
        model.rootTitle = [NSString stringWithFormat:@"优惠券%d",i];

        [_couponArray addObject:model];
        
    }
    
    [_myCouponTableView reloadData];
    
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
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZCouponDetailViewController *detail = [[HZCouponDetailViewController alloc] init];
    
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
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
