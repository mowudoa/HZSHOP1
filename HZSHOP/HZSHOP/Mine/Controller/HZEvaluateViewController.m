//
//  HZEvaluateViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/28.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZEvaluateViewController.h"
#import "HZOrderModel.h"
#import "HZOrderTableViewCell.h"
@interface HZEvaluateViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *evaluateTableView;//商品cell

@property (strong, nonatomic) IBOutlet UIView *evaluateView;//评价信息footer

@property (weak, nonatomic) IBOutlet UITextView *evaluateTextView;//评价

@property (weak, nonatomic) IBOutlet UILabel *evaluateTipLabel;//评分标签

@property (weak, nonatomic) IBOutlet commentStar *starView;//星星

@property (weak, nonatomic) IBOutlet UIButton *clearevaluateScoreButton;//清除评分

@property (weak, nonatomic) IBOutlet UIButton *evaluateButton;//提交评价

@property(nonatomic,strong) NSMutableArray *evaluateGoodsArray;

@end

@implementation HZEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
    [self initData];
    
}
-(void)initUI
{
    
    self.navigationItem.title = @"评价";
    
    _evaluateGoodsArray = [[NSMutableArray alloc] init];
    
    [WYFTools CreateTextPlaceHolder:@"说点什么吧" WithFont:[UIFont systemFontOfSize:14] WithSuperView:_evaluateTextView];
 
    [WYFTools viewLayer:5 withView:_evaluateButton];
 
    MJWeakSelf;
    
    [_starView returnStar:^(NSInteger starNum) {
      
        switch (starNum) {
            
            case 0:
                weakSelf.evaluateTipLabel.text = @"没有评分";
                break;
            case 1:
                weakSelf.evaluateTipLabel.text = @"差评";
                break;
            default:
                weakSelf.evaluateTipLabel.text = @"";
                break;
        }
        
    }];
    
}

-(void)registercell
{
   
    UINib* nib = [UINib nibWithNibName:@"HZOrderTableViewCell" bundle:nil];
    
    [_evaluateTableView registerNib:nib forCellReuseIdentifier:@"OrderTableViewCell"];
    
}

-(void)initData
{
    
    for (int i = 0; i < 2; i ++) {
        
        HZOrderModel *model = [[HZOrderModel alloc] init];
        
        [_evaluateGoodsArray addObject:model];
        
    }
    
    [_evaluateTableView reloadData];
    
}

#pragma mark 提交评价
- (IBAction)evaluateGoods:(UIButton *)sender {

    
}

#pragma mark 评分清零
- (IBAction)clearScore:(UIButton *)sender {

    _starView.numofStar = 0;
    
}

#pragma  mark ===TbaleViewDateSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _evaluateGoodsArray.count;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZOrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell" forIndexPath:indexPath];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT(124);
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 31)];
    
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,30,SCREEN_WIDTH - 20,1)];
    
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    
    [backView addSubview:lineLabel];
    
    UILabel *shanghu = [WYFTools createLabel:CGRectMake(10, 5, SCREEN_WIDTH/2-10, 20) bgColor:[UIColor clearColor] text:@"订单号:SH20190418092212" textFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHexString:@"#666666"] tag:section];
    
    shanghu.adjustsFontSizeToFitWidth = YES;
    
    [backView addSubview:shanghu];
    
    UILabel *dingdantime = [WYFTools createLabel:CGRectMake(SCREEN_WIDTH/2, 5, SCREEN_WIDTH/2-10, 20) bgColor:[UIColor clearColor] text:@"待付款" textFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:[UIColor colorWithHexString:@"666666"] tag:section];
    
    dingdantime.adjustsFontSizeToFitWidth = YES;
    
    [backView addSubview:dingdantime];
    
    return backView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 31;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH ,279)];
    
    _evaluateView.frame = CGRectMake(0,10,SCREEN_WIDTH,269);
    
    [view addSubview:_evaluateView];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 279;
    
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
