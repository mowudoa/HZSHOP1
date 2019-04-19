//
//  HZRechargeHistoryViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/19.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZRechargeHistoryViewController.h"
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
    
}

-(void)initData
{
    
    for (int i = 0; i < 10; i ++) {
        
        rootModel *model = [[rootModel alloc] init];
        
        [_rechageArray addObject:model];
    }
    
    [_rechargeHistoryTableView reloadData];
    
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _rechageArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZRechargeHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeHistoryTableViewCell"];
    
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
