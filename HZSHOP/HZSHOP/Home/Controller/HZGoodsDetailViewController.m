//
//  HZGoodsDetailViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/12.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZGoodsDetailViewController.h"

@interface HZGoodsDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

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

@end

@implementation HZGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self initData];
    
}
-(void)initUI
{
    self.navigationItem.title = @"商品详情";
    
    [WYFTools viewLayer:_jumpShopButton.height/2 withView:_jumpShopButton];
    
    [WYFTools viewLayerBorderWidth:1 borderColor:[UIColor colorWithHexString:@"#fc5759"] withView:_jumpShopButton];
    
}
-(void)initData
{
    self.goodsTitle.text = @"就这样，label的高度就能达到初步的自适应，如果要求教过的话，可以设置一些属性，或者使用代码自适应";
    
    self.goodsSubTitle.text = @"就这样";
    
     [self reloadData];
    
}
-(void)reloadData
{
    
    
}
-(void)viewDidLayoutSubviews
{
    self.goodsInfoView.frame = CGRectMake(_goodsInfoView.mj_x, _goodsInfoView.mj_y,SCREEN_WIDTH,_goodsInfoView.height + _goodsTitle.height + _goodsSubTitle.height - 42);

    self.selecetNumView.frame = CGRectMake(_selecetNumView.mj_x, _goodsInfoView.mj_y + _goodsInfoView.height + 8,_selecetNumView.width ,_selecetNumView.height);
    
    self.shopView.frame = CGRectMake(_shopView.mj_x,_selecetNumView.mj_y + _selecetNumView.height + 8,_shopView.width, _shopView.height);
    
    self.detailView.frame = CGRectMake(_detailView.mj_x, _shopView.mj_y + _shopView.height + 8,_detailView.width, _detailView.height);
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  
  //  self.bgView.frame = CGRectMake(0,0,SCREEN_WIDTH,self.detailView.mj_y + _detailView.height + 8);
    
    self.bgScrollView.contentSize = CGSizeMake(0,_shopView.mj_y + _shopView.height + 8 + _detailView.height);
    
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
