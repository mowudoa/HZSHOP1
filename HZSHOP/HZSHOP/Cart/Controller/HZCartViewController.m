//
//  HZCartViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/9.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCartViewController.h"
#import "HZCartModel.h"
#import "HZCartTableViewCell.h"

@interface HZCartViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *cartListTableView;
@property (weak, nonatomic) IBOutlet UIButton *selecteButton;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property(nonatomic,strong) NSMutableArray *cartGoodsArray;
@end

@implementation HZCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
    [self initData];

}
-(void)registercell
{
    
    UINib* nib = [UINib nibWithNibName:@"HZCartTableViewCell" bundle:nil];
    
    [_cartListTableView registerNib:nib forCellReuseIdentifier:@"CartTableViewCell"];
    
}
-(void)initUI
{
    self.navigationItem.title = @"购物车";
    
    //通知以刷新价格
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTotalPrice:) name:@"getToalMoney" object:nil];
    
}
-(void)initData
{
    _cartGoodsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        
        HZCartModel *model = [[HZCartModel alloc] init];
        
        
        model.goodstitle = [NSString stringWithFormat:@"商品%d",i];
        
        model.goodssalesprice = @"100";
        
        model.goodsnum = @"1";
        
        [_cartGoodsArray addObject:model];
        
    }
    [_cartListTableView reloadData];
    
    
}
- (IBAction)selecteAll:(UIButton *)sender {

  double GoodsPrice = 0;
    
    sender.selected = !sender.selected;
    
    for (HZCartModel* shopModel in _cartGoodsArray) {
        
        shopModel.isSelect = sender.selected;
        
        if (sender.selected) {
            
            GoodsPrice +=([shopModel.goodssalesprice doubleValue]*[shopModel.goodsnum integerValue]);
            
        }else{
            
            
        }
        
    }
    _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",GoodsPrice];
    
    [_cartListTableView reloadData];
    
}
-(void)getTotalPrice:(NSNotification*)userinfo
{
  double GoodsPrice = 0;
    
    
    for (HZCartModel* model in _cartGoodsArray) {
        
        if (model.isSelect) {
            
            GoodsPrice +=([model.goodssalesprice doubleValue]*[model.goodsnum integerValue]);
            
        }
    }
    _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",GoodsPrice];
    
}
#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cartGoodsArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZCartTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CartTableViewCell" forIndexPath:indexPath];
    
    HZCartModel *model = _cartGoodsArray[indexPath.row];
    
    [cell setCarModel:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT(127);
    
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
