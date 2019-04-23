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

@property (weak, nonatomic) IBOutlet UIView *settlenentView;//结算view

@property (weak, nonatomic) IBOutlet UIView *editView;//编辑view

@property(nonatomic,strong) NSMutableArray *cartGoodsArray;

@property(strong,nonatomic)UIBarButtonItem* rightItem;

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
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    _cartGoodsArray = [[NSMutableArray alloc] init];

    //通知以刷新价格
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTotalPrice:) name:@"getToalMoney" object:nil];
    
    if (_isRootNav) {
        
        [self initBackButton];
        
    }
    
}

-(void)initData
{
    
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"]};

    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:SHOP_CART parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
     
        LOG(@"购物车",dic);
        
        MJStrongSelf;
        
        if (SUCCESS) {
            
            NSArray *cartList = dic[@"data"][@"list"];
            
            for (NSDictionary *cartDic in cartList) {
                
                HZCartModel *model = [[HZCartModel alloc] init];

                model.rootId = cartDic[@"id"];
                
                model.goodsNum = cartDic[@"total"];
                
                model.rootTitle = cartDic[@"title"];
                
                model.rootImageUrl = cartDic[@"thumb"];
                
                model.goodsSalesPrice = cartDic[@"productprice"];
                
                model.goodsOldPrice = [cartDic[@"marketprice"] stringValue];
                
                model.goodsStockNum = cartDic[@"stock"];
               
                [strongSelf.cartGoodsArray addObject:model];
                
            }
            
        }else{
            
            
        }
        
        [strongSelf.cartListTableView reloadData];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
    [_cartListTableView reloadData];
    
}

#pragma mark rightButtonitem
-(UIBarButtonItem*)rightItem
{
    if (_rightItem == nil) {
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setFrame:CGRectMake(0, 0, 30, 30)];
        
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        
        [btn setTitle:@"完成" forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"#9B9B9B"] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
    }
    
    return _rightItem;
}

#pragma mark 全选
- (IBAction)selecteAll:(UIButton *)sender {

  double GoodsPrice = 0;
    
    sender.selected = !sender.selected;
    
    for (HZCartModel* shopModel in _cartGoodsArray) {
        
        shopModel.isSelect = sender.selected;
        
        if (sender.selected) {
            
            GoodsPrice +=([shopModel.goodsSalesPrice doubleValue]*[shopModel.goodsNum integerValue]);
            
        }else{
            
            
        }
        
    }
    
    _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",GoodsPrice];
    
    [_cartListTableView reloadData];
    
}

#pragma mark 刷新结算价格
-(void)getTotalPrice:(NSNotification*)userinfo
{
  double GoodsPrice = 0;
    
    for (HZCartModel* model in _cartGoodsArray) {
        
        if (model.isSelect) {
            
            GoodsPrice +=([model.goodsSalesPrice doubleValue]*[model.goodsNum integerValue]);
            
        }
    }
    
    _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",GoodsPrice];
    
}

#pragma mark 编辑
-(void)rightAction:(UIButton *)sender
{
    
    sender.selected = !sender.selected;
 
    if (sender.selected) {
    
        _settlenentView.hidden = YES;
        
        _editView.hidden = NO;
        
    }else{
        
        _settlenentView.hidden = NO;
        
        _editView.hidden = YES;
        
    }
    
}

#pragma mark 删除
- (IBAction)deleteCartGoods:(UIButton *)sender {
}

#pragma mark 移入关注
- (IBAction)addFollowGoods:(UIButton *)sender {
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isRootNav) {
        
        [YY_APPDELEGATE.tabBarControll.tabBar setHidden:YES];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_isRootNav) {
        
        [YY_APPDELEGATE.tabBarControll.tabBar setHidden:NO];
    }
    
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
