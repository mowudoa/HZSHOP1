//
//  HZCartOrderTableViewCell.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/15.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCartOrderTableViewCell.h"
#import "HZCartTableViewCell.h"

@implementation HZCartOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [self registercell];

    _cartGoodsTableView.delegate = self;
    
    _cartGoodsTableView.dataSource = self;
    
}

-(void)registercell
{
    
    UINib* nib = [UINib nibWithNibName:@"HZCartTableViewCell" bundle:nil];
    
    [_cartGoodsTableView registerNib:nib forCellReuseIdentifier:@"CartTableViewCell"];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZCartTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CartTableViewCell" forIndexPath:indexPath];
    
    return cell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, 30)];
    
    bgView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label = [WYFTools createLabel: CGRectMake(15, 0, SCREEN_WIDTH - 30, 30) bgColor:[UIColor whiteColor] text:@"汇众商城" textFont:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] tag:section];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(10,29,SCREEN_WIDTH - 20,1)];
    
    line.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    
    [bgView addSubview:label];
    
    [bgView addSubview:line];
    
    return bgView;
    
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT(127);
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
    
}
@end
