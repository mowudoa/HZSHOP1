//
//  HZOrderPayViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/23.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZOrderPayViewController.h"
#import "HZPayTypeTableViewCell.h"
@interface HZOrderPayViewController ()<
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UILabel *orderPayMoney;

@property (weak, nonatomic) IBOutlet UILabel *orderCode;

@property (weak, nonatomic) IBOutlet UITableView *payTypeTableView;

@property(nonatomic,strong) NSMutableArray *payTypeArray;

@end

@implementation HZOrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registercell];
    
    [self initData];
    
}
-(void)initUI
{
    
    self.navigationItem.title = @"收银台";
    
    _payTypeArray = [[NSMutableArray alloc] init];
    
}

-(void)registercell
{
    
    UINib *nib = [UINib nibWithNibName:@"HZPayTypeTableViewCell" bundle:nil];
    
    [_payTypeTableView registerNib:nib forCellReuseIdentifier:@"PayTypeTableViewCell"];
    
}
-(void)initData
{
    
    for (int i = 0; i < 2; i ++) {
        
        rootModel *model = [[rootModel alloc] init];

        if (i == 0) {
        
            model.rootTitle = @"微信支付";
            
        }else{
            
            model.rootTitle = @"余额支付";
            
        }
        
        [_payTypeArray addObject:model];
        
    }
    
    [_payTypeTableView reloadData];
    
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _payTypeArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    HZPayTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayTypeTableViewCell"];
    
    rootModel *model = _payTypeArray[indexPath.row];
    
    cell.payTypeName.text = model.rootTitle;
    
    if (indexPath.row == 0) {
        
        cell.payTypeInfo.text = @"微信支付最为安全";
        
    }else{
        
        NSString *infoStr = @"<p style='color:#A1A1A1;'>当前余额:<span style='color:#FC575A;'>￥500.01</span></p>";

        cell.payTypeInfo.attributedText = [WYFTools htmlAttributedString:infoStr];
        
    }
    
    return cell;
    
}
#pragma makr UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(void)viewDidLayoutSubviews
{
    _payTypeTableView.height = _payTypeArray.count *60;

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
