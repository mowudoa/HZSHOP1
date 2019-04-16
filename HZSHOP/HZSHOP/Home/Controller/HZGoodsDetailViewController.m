//
//  HZGoodsDetailViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/12.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZGoodsDetailViewController.h"
#import "HZCartOrderViewController.h"

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
@property (strong, nonatomic) IBOutlet UIView *goodsParameterView;//参数选择视图
@property (weak, nonatomic) IBOutlet UIView *selecteBgView;//选择参数时的背景图
@property (weak, nonatomic) IBOutlet UITextField *numTextField;//数量选择

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
    
    [WYFTools viewLayerBorderWidth:1.3 borderColor:RGBACOLOR(201, 201, 201, 1) withView:_numTextField];
 
    self.goodsParameterView.frame = CGRectMake(0,SCREEN_HEIGHT - 300 - SCREEN_NAVRECT - SCREEN_STATUSRECT - BOTTOM_SAFEAREA,SCREEN_WIDTH,300);

}
-(void)initData
{
    self.goodsTitle.text = @"就这样，label的高度就能达到初步的自适应，如果要求教过的话，可以设置一些属性，或者使用代码自适应";
    
    self.goodsSubTitle.text = @"就这样";
    
     [self reloadData];
    
}

#pragma mark 立即购买
- (IBAction)buyNow:(UIButton *)sender {

    _selecteBgView.hidden = NO;
    
    __weak typeof(self) weakSelf = self;

    [self.view addSubview:weakSelf.goodsParameterView];

    [UIView animateWithDuration:0.2 animations:^{
        
        weakSelf.goodsParameterView.frame = CGRectMake(0,SCREEN_HEIGHT - 300 - SCREEN_NAVRECT - SCREEN_STATUSRECT - BOTTOM_SAFEAREA,SCREEN_WIDTH,300);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark 关闭属性选择
- (IBAction)closeParameter:(UIButton *)sender {

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
            num++;
        }
    
    _numTextField.text = [NSString stringWithFormat:@"%ld",(long)num];
    
}

#pragma mark 商品订单提交
- (IBAction)commitOrder:(UIButton *)sender {

    HZCartOrderViewController *cartOrder = [[HZCartOrderViewController alloc] init];
    
    [self.navigationController pushViewController:cartOrder animated:YES];
    
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
