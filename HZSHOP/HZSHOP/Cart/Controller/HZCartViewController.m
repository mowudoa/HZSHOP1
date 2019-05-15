//
//  HZCartViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/9.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCartViewController.h"
#import "HZCartModel.h"
#import "HZGoodsModel.h"
#import "HZCartTableViewCell.h"
#import "HZCartOrderViewController.h"
@interface HZCartViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *cartListTableView;

@property (weak, nonatomic) IBOutlet UIButton *selecteButton;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIView *settlenentView;//结算view

@property (weak, nonatomic) IBOutlet UIView *editView;//编辑view

@property (weak, nonatomic) IBOutlet UIButton *addToFollowButton;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property(nonatomic,strong) NSMutableArray *cartGoodsArray;

@property(strong,nonatomic)UIBarButtonItem* rightItem;

@end

@implementation HZCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
}

-(void)registercell
{
    
    UINib* nib = [UINib nibWithNibName:@"HZCartTableViewCell" bundle:nil];
    
    [_cartListTableView registerNib:nib forCellReuseIdentifier:@"CartTableViewCell"];
    
}

-(void)initUI
{
    self.navigationItem.title = @"购物车";
    
    _cartGoodsArray = [[NSMutableArray alloc] init];

    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    //通知以刷新价格
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTotalPrice:) name:@"getToalMoney" object:nil];
    
    if (_isRootNav) {
        
        [self initBackButton];
        
    }
    
    // 下拉加载
    self.cartListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self initData];
        
    }];
    
    // 上拉刷新
    self.cartListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.nowPage ++;
        
        [self initMoreData];
        
    }];
    
    [WYFTools autuLayoutNewMJ:_cartListTableView];
    
}

-(void)initData
{
    self.nowPage = 1;
    
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]};

    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:SHOP_CART parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
     
        LOG(@"购物车",dic);
        
        MJStrongSelf;
        
        [strongSelf.cartGoodsArray removeAllObjects];
        
        if (SUCCESS) {
            
            NSArray *cartList = dic[@"data"][@"list"];
            
            for (NSDictionary *cartDic in cartList) {
                
                HZCartModel *model = [[HZCartModel alloc] init];

                model.rootId = cartDic[@"id"];
                
                model.goodsNum = cartDic[@"total"];
                
                model.rootTitle = cartDic[@"title"];
                
                model.rootImageUrl = cartDic[@"thumb"];
                
                model.goodsOptionid = cartDic[@"optionid"];
                
                model.goodsSpecs = cartDic[@"optiontitle"];
                
                model.goodsId = cartDic[@"goodsid"];
                
                model.goodsSalesPrice = cartDic[@"productprice"];
                
                model.goodsOldPrice = [cartDic[@"marketprice"] stringValue];
                
                model.goodsStockNum = cartDic[@"stock"];
               
                [strongSelf.cartGoodsArray addObject:model];
                
            }
            
            if (strongSelf.cartGoodsArray.count > 0) {
                
                self.rightItem.customView.hidden = NO;
                
            }else{
                
                self.rightItem.customView.hidden = YES;

            }
            
        }else{
            
            
        }
    
        
        
        [strongSelf.cartListTableView reloadData];
        
        [strongSelf.cartListTableView.mj_header endRefreshing];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}

-(void)initMoreData
{
    
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]};
    
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
                
                model.goodsOptionid = cartDic[@"optionid"];
                
                model.goodsSpecs = cartDic[@"optiontitle"];
                
                model.goodsId = cartDic[@"goodsid"];
                
                model.rootImageUrl = cartDic[@"thumb"];
                
                model.goodsOldPrice = cartDic[@"productprice"];
                
                model.goodsSalesPrice = [cartDic[@"marketprice"] stringValue];
                
                model.goodsStockNum = cartDic[@"stock"];
                
                [strongSelf.cartGoodsArray addObject:model];
                
            }
            
            [strongSelf.cartListTableView reloadData];
            
            [strongSelf.cartListTableView.mj_footer endRefreshing];
            
            if (cartList.count > 0) {
                
            }else{
                
                [JKToast showWithText:NOMOREDATA_STRING];
                
                [strongSelf.cartListTableView.mj_footer endRefreshingWithNoMoreData];
                
            }
            
        }else{
            
            
        }
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
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
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    for (HZCartModel* shopModel in _cartGoodsArray) {
        
        shopModel.isSelect = sender.selected;
        
        if (sender.selected) {
            
            GoodsPrice +=([shopModel.goodsSalesPrice doubleValue]*[shopModel.goodsNum integerValue]);
            
            [array addObject:shopModel];
            
        }else{
            
            
        }
        
    }
    
    if (array.count > 0) {
        
        [self changeButtonColor];
        
    }else{
        
        [_addToFollowButton setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];
        
        [_deleteButton setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];

    }
    
    _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",GoodsPrice];
    
    [_cartListTableView reloadData];
    
}

#pragma mark 刷新结算价格
-(void)getTotalPrice:(NSNotification*)userinfo
{
  double GoodsPrice = 0;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (HZCartModel* model in _cartGoodsArray) {
        
        if (model.isSelect) {
            
            GoodsPrice +=([model.goodsSalesPrice doubleValue]*[model.goodsNum integerValue]);
            
            [array addObject:model];
        }
    }
    
    _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",GoodsPrice];
    
    if (array.count > 0) {
        
        [self changeButtonColor];
        
    }else{
        
        [_addToFollowButton setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];

        [_deleteButton setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];

    }
}

#pragma mark 改变删除按钮颜色
-(void)changeButtonColor
{
    
    [_addToFollowButton setBackgroundColor:[UIColor colorWithHexString:@"#FDA729"]];
    
    [_deleteButton setBackgroundColor:[UIColor colorWithHexString:@"#FB5759"]];
    
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

    if (![[self getGoodsIds] isEqualToString:@"000"]) {
        
        NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                               @"ids":[self getGoodsIds]
                               };
        
        [CrazyNetWork CrazyRequest_Post:DELETE_SHOP_CART parameters:dict HUD:NO success:^(NSDictionary *dic, NSString *url, NSString *Json) {
           
            LOG(@"删除购物车", dic);
            
            if (SUCCESS) {
             
                [self initData];
                
            }else{
                
                [JKToast showWithText:dic[@"message"]];
                
            }
            
        } fail:^(NSError *error, NSString *url, NSString *Json) {
            
        }];
        
        
    }

}

#pragma mark 移入关注
- (IBAction)addFollowGoods:(UIButton *)sender {
}

-(NSString *)getGoodsIds
{
    
    NSMutableString* cid = [NSMutableString string];
    
    for (HZCartModel* model in _cartGoodsArray) {
        
        if (model.isSelect) {
            
            if (cid.length>0) {
                [cid appendString:@","];
            }
            [cid appendString:model.rootId];;
            
        }
        
    }
    if (!(cid.length>0)) {
        
        [JKToast showWithText:@"请选择商品"];
        
        return @"000";
    }
 
    return cid;
    
}

#pragma mark 结算
- (IBAction)submitOrder:(UIButton *)sender {

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (HZCartModel* shopModel in _cartGoodsArray) {
    
        if (shopModel.isSelect) {
         
            HZGoodsModel *model = [[HZGoodsModel alloc] init];
            
            model.rootTitle = shopModel.rootTitle;
            
            model.goodsNum = shopModel.goodsNum;
            
            model.goodsId = shopModel.goodsId;
            
            model.rootImageUrl  =shopModel.rootImageUrl;
            
            model.specs = shopModel.goodsSpecs;
            
            model.optionId = shopModel.goodsOptionid;
            
            model.goodsPrice = shopModel.goodsSalesPrice;
            
            [arr addObject:model];
            
        }
        
    
    }
    
    if (!(arr.count > 0)) {
        
        [JKToast showWithText:@"请选择商品"];
        
        return;
    }
    
    HZCartOrderViewController *cartOrder = [[HZCartOrderViewController alloc] init];
    
    cartOrder.goodsArray = arr;
    
    [self.navigationController pushViewController:cartOrder animated:YES];
    
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
    
    [self initData];

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
