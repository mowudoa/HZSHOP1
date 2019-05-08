//
//  HZGoodsDetailViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/12.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZGoodsDetailViewController.h"
#import "scrollPhotos.h"
#import "HZCartViewController.h"
#import "HZGoodsParameterModel.h"
#import "HZCartOrderViewController.h"
#import "HZGoodsParameterTableViewCell.h"


@interface HZGoodsDetailViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@property (weak, nonatomic) IBOutlet UIView *headerView;//轮播图

@property (weak, nonatomic) IBOutlet UIView *goodsInfoView;

@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;//标题

@property (weak, nonatomic) IBOutlet UILabel *goodsSubTitle;//副标题

@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;//现价

@property (weak, nonatomic) IBOutlet UILabel *goodsOldPrice;//原价

@property (weak, nonatomic) IBOutlet UILabel *expressMoney;//邮费

@property (weak, nonatomic) IBOutlet UILabel *soldNum;//销售数量

@property (weak, nonatomic) IBOutlet UIView *detailView;//详情view

@property (weak, nonatomic) IBOutlet UIView *selecetNumView;//选择规格view

@property (weak, nonatomic) IBOutlet UIView *shopView;//店铺view

@property (weak, nonatomic) IBOutlet UIButton *jumpShopButton;//进入店铺按钮

@property (strong, nonatomic) IBOutlet UIView *goodsParameterView;//参数选择视图

@property (weak, nonatomic) IBOutlet UIView *selecteBgView;//选择参数时的背景图

@property (weak, nonatomic) IBOutlet UITextField *numTextField;//数量选择

@property (weak, nonatomic) IBOutlet UIView *buyOrShopCartView;

@property (weak, nonatomic) IBOutlet UIButton *commitButton;//确认button

@property (weak, nonatomic) IBOutlet UITableView *parameterTableView;

@property(nonatomic,strong) NSMutableArray *bannerArray;

@property(nonatomic,assign) NSInteger stockNum;//库存

@property(nonatomic,strong)scrollPhotos* headScrollView;

@property(nonatomic,copy) NSString * paremeterViewShowType;

@property(nonatomic,strong) NSMutableArray *parameterArray;

@end

@implementation HZGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registerCell];
    
    [self initData];
    
}
-(void)initUI
{
    self.navigationItem.title = @"商品详情";
    
    _bannerArray = [[NSMutableArray alloc] init];
    
    _parameterArray = [[NSMutableArray alloc] init];
    
    [WYFTools viewLayer:_jumpShopButton.height/2 withView:_jumpShopButton];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor colorWithHexString:@"#fc5759"] withView:_jumpShopButton];
    
    [WYFTools viewLayerBorderWidth:1.3 borderColor:RGBACOLOR(201, 201, 201, 1) withView:_numTextField];
 
    self.goodsParameterView.frame = CGRectMake(0,SCREEN_HEIGHT - 300 - SCREEN_NAVRECT - SCREEN_STATUSRECT - BOTTOM_SAFEAREA,SCREEN_WIDTH,300);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(putGoodsNum:) name:@"putGoodsNum" object:nil];

}

-(void)registerCell
{
 
    UINib* nib   =[UINib nibWithNibName:@"HZGoodsParameterTableViewCell" bundle:nil];
    
    [_parameterTableView registerNib:nib forCellReuseIdentifier:@"GoodsParameterTableViewCell"];
    
}

-(void)initData
{
    NSDictionary *dict = @{@"goodsid":_goodsId};
    
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:GOODS_DETAIL parameters:dict HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
       
        LOG(@"商品详情", dic);
        
        MJStrongSelf;
        
        [strongSelf.bannerArray removeAllObjects];
        
        if (SUCCESS) {
         
            NSDictionary *detail = dic[@"data"];
            
            strongSelf.goodsTitle.text = detail[@"title"];
            
            strongSelf.goodsSubTitle.text = detail[@"shorttitle"];
            
            strongSelf.goodsOldPrice.attributedText = [WYFTools AddCenterLineToView:[NSString stringWithFormat:@"￥%@",detail[@"productprice"]]];
            
            strongSelf.goodsPrice.text = [NSString stringWithFormat:@"￥%@",detail[@"marketprice"]];
            
            if ([detail[@"issendfree"] isEqualToString:@"1"]) {
                
                strongSelf.expressMoney.text = @"快递:包邮";
                
            }else{
                
                strongSelf.expressMoney.text = @"快递:自费";

            }
            
            strongSelf.soldNum.text = [NSString stringWithFormat:@"销量:%@件",detail[@"salesreal"]];
            
            [strongSelf.bannerArray addObjectsFromArray:[detail[@"thumb_url"] allValues]];
            
            strongSelf.stockNum = [detail[@"total"] integerValue];
            
        }else{
            
        }
        
        [self reloadData];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}

#pragma 添加购物车
- (IBAction)addShopCart:(UIButton *)sender {

    self.paremeterViewShowType = @"加入购物车";

    [self showGoodsParameter];

}

#pragma mark 立即购买
- (IBAction)buyNow:(UIButton *)sender {

    self.paremeterViewShowType = @"立即购买";

    [self showGoodsParameter];
    
}

#pragma mark 关闭属性选择
- (IBAction)closeParameter:(UIButton *)sender {

    [self closeGoodsParameter];
    
}

-(void)showGoodsParameter
{
 
    _selecteBgView.hidden = NO;
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:weakSelf.goodsParameterView];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        weakSelf.goodsParameterView.frame = CGRectMake(0,SCREEN_HEIGHT - 300 - SCREEN_NAVRECT - SCREEN_STATUSRECT - BOTTOM_SAFEAREA,SCREEN_WIDTH,300);
        
    } completion:^(BOOL finished) {
        
    }];
    
    if (![_paremeterViewShowType isEqualToString:@"参数选择"]) {
        
        _buyOrShopCartView.hidden = YES;
        
        _commitButton.hidden = NO;
        
    }else{
        
        _buyOrShopCartView.hidden = NO;
        
        _commitButton.hidden = YES;
        
    }
    
    
}

-(void)closeGoodsParameter
{
    
    _selecteBgView.hidden = YES;
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        weakSelf.goodsParameterView.frame = CGRectMake(0,SCREEN_HEIGHT ,SCREEN_WIDTH,300);
        
    } completion:^(BOOL finished) {
        
        [weakSelf.goodsParameterView removeFromSuperview];
        
    }];
}


#pragma mark 商品数量选择
- (IBAction)numChoice:(UIButton *)sender {

    NSInteger num = [_numTextField.text integerValue];
    
        if (sender.tag == 10) {
            
            if (![self.numTextField.text isEqualToString:@"1"]) {
                
                num --;
                
            }else{
                
                [JKToast showWithText:@"数量不能少于1"];
                
                return;
                
            }
            
        }else
        {
            if (num >= _stockNum) {
               
                [JKToast showWithText:@"已达到最大库存限制"];

                return;
            }
            
            num++;
            
        }
    
    _numTextField.text = [NSString stringWithFormat:@"%ld",(long)num];
    
}

#pragma mark a加入购物车/立即购买
- (IBAction)buyNowOrShopCart:(UIButton *)sender {

    if (sender.tag == 200) {
        
        [self addGoodsToShopCart];
        
    }else if (sender.tag == 201){
        
        [self buyGoodsNow];
    }
    
}

#pragma mark 收藏/店铺/跳转购物车
- (IBAction)jumbShopCart:(UIButton *)sender {

    //300
    if (sender.tag == 300) {
        
    }else if (sender.tag == 301){
        
    }else if (sender.tag == 302){
      
        HZCartViewController *cart = [[HZCartViewController alloc] init];
        
        cart.isRootNav = YES;
        
        [self.navigationController pushViewController:cart animated:YES];
        
    }
    
}

#pragma mark 参数选择
- (IBAction)selectParameter:(UIButton *)sender {

    _paremeterViewShowType = @"参数选择";

    [self showGoodsParameter];
    
    NSDictionary *dict = @{@"goodsid":_goodsId};
    
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:GOODS_PARAMETER parameters:dict HUD:NO success:^(NSDictionary *dic, NSString *url, NSString *Json) {
       
        LOG(@"商品参数获取", dic);
        
        MJStrongSelf;
        
        [strongSelf.parameterArray removeAllObjects];
        
        if (SUCCESS) {
         
            NSArray *list = dic[@"data"];
            
            for (NSDictionary *dic1 in list) {
                
                HZGoodsParameterModel *model = [[HZGoodsParameterModel alloc] init];
                
                model.rootId = dic1[@"id"];
                
                model.rootTitle = dic1[@"title"];
                
                NSArray *itemArray = dic1[@"item"];
                
                for (NSDictionary *dic2 in itemArray) {
                    
                    rootModel *model1 = [[rootModel alloc] init];
                    
                    model1.rootId = dic2[@"id"];
                    
                    model1.rootTitle = dic2[@"title"];
                    
                    [model.parameterArray addObject:model];
                    
                }
                
                [strongSelf.parameterArray addObject:model];

                
            }
            [strongSelf.parameterTableView reloadData];

        }else{
            
            
        }
        
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}

#pragma mark 商品订单提交
- (IBAction)commitOrder:(UIButton *)sender {

    
    if ([_paremeterViewShowType isEqualToString:@"加入购物车"]) {
        
        [self addGoodsToShopCart];
        
    }else if ([_paremeterViewShowType isEqualToString:@"立即购买"]){
        
        [self buyGoodsNow];
        
    }else if ([_paremeterViewShowType isEqualToString:@"参数选择"]){
        
        
    }
    
    
}

-(void)reloadData
{
    
    [self.headerView addSubview:self.headScrollView];
    
}

#pragma mark 商品数量输入

- (void)putGoodsNum:(NSNotification *)notification{
    //done按钮的操作
    
    if (_numTextField.text.length > 1) {
        
        NSString *firstStr = [_numTextField.text substringToIndex:1];
        
        if ([firstStr isEqualToString:@"0"]) {
            
            _numTextField.text = [_numTextField.text substringFromIndex:1];
            
        }
        
    }
    
    if (_stockNum <= 0) {
        
        [JKToast showWithText:@"没有剩余库存"];
        
        return;
        
    }else if ([_numTextField.text integerValue] > _stockNum){
        
        
        [JKToast showWithText:@"已达到最大库存限制"];
        
        _numTextField.text = [NSString stringWithFormat:@"%ld",_stockNum];
        
        return;
        
    }else{
        
        if (_numTextField.text.length > 0) {
            
            
        }else if ([_numTextField.text isEqualToString:@""] ||[_numTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 || [_numTextField.text isEqualToString:@"0"]){
            
            _numTextField.text = @"1";
            
        }
        
    }
    
}

-(void)addGoodsToShopCart
{
  
    NSDictionary *dict = @{USER_ID:[USER_DEFAULT objectForKey:@"user_id"],
                           @"goodsid":_goodsId,
                           @"total":_numTextField.text
                           };

    [CrazyNetWork CrazyRequest_Post:GOODS_ADD_CART parameters:dict HUD:NO success:^(NSDictionary *dic, NSString *url, NSString *Json) {
       
        LOG(@"加入购物车", dic);
        
        if (SUCCESS) {
           
            [JKToast showWithText:Shop_AddCart_Success];
            
            [self closeGoodsParameter];
            
        }else{
            
            [JKToast showWithText:dic[@"message"]];
            
        }
        
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
    }];
    
}

-(void)buyGoodsNow
{
    
    HZCartOrderViewController *cartOrder = [[HZCartOrderViewController alloc] init];
    
    [self.navigationController pushViewController:cartOrder animated:YES];
    
}

-(scrollPhotos *)headScrollView
{
    
    if (_headScrollView == nil) {
        
        _headScrollView = [[scrollPhotos alloc]initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH, SCREEN_WIDTH)];
        
        _headScrollView.delegate = self;
        
        _headScrollView.photos = _bannerArray;
        
    }
    
    return _headScrollView;

}

-(void)viewDidLayoutSubviews
{
  
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  
    self.goodsInfoView.frame = CGRectMake(_goodsInfoView.mj_x, _goodsInfoView.mj_y,SCREEN_WIDTH,_goodsInfoView.height + _goodsTitle.height + _goodsSubTitle.height - 26);
    
    self.selecetNumView.frame = CGRectMake(_selecetNumView.mj_x, _goodsInfoView.mj_y + _goodsInfoView.height + 8,_selecetNumView.width ,_selecetNumView.height);
    
    self.shopView.frame = CGRectMake(_shopView.mj_x,_selecetNumView.mj_y + _selecetNumView.height + 8,_shopView.width, _shopView.height);
    
    self.detailView.frame = CGRectMake(_detailView.mj_x, _shopView.mj_y + _shopView.height + 8,_detailView.width, _detailView.height);
    
    self.bgScrollView.contentSize = CGSizeMake(0,_shopView.mj_y + _shopView.height + 8 + _detailView.height);
    
}

#pragma mark - UITableViewDataSource  数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _parameterArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZGoodsParameterTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsParameterTableViewCell" forIndexPath:indexPath];
    
    HZGoodsParameterModel *model = _parameterArray[indexPath.section];
    
    [cell setParameterModel:model];
    
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HZGoodsParameterModel *model = _parameterArray[section];
    
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 20)];
    
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,30,SCREEN_WIDTH - 10,1)];
    
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    
  //  [backView addSubview:lineLabel];
    
    UILabel *timeLabel = [WYFTools createLabel:CGRectMake(10,0,SCREEN_WIDTH - 20,20) bgColor:[UIColor clearColor] text:model.rootTitle textFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] tag:section];
    
    [backView addSubview:timeLabel];
    
    return backView;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate  代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"putGoodsNum" object:nil];
    
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
