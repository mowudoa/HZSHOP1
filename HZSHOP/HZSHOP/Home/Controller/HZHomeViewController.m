//
//  HZHomeViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/9.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZHomeViewController.h"

@interface HZHomeViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (weak, nonatomic) IBOutlet UICollectionView *homecollectionView;

@property (strong,nonatomic) UIView *headerView;

@end

@implementation HZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registerCell];
    
    [self initData];
    
}

-(void)initUI
{
    self.navigationItem.title = @"首页";
}

-(void)registerCell
{
    
}

-(void)initData
{
    
}

-(UIView *)headerView
{
    
    if (_headerView == nil) {
      
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_WIDTH *1.3)];
        
    }
    
    return _headerView;
    
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
