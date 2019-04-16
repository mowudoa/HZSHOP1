//
//  HZCategoryViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/9.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCategoryViewController.h"
#import "HZAllGoodsViewController.h"

@interface HZCategoryViewController ()<
UISearchBarDelegate
>

@property(nonatomic,strong) UISearchBar *searchBar;

@property(nonatomic,strong) UIView *searchView;

@end

@implementation HZCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
}

-(void)initUI
{
    self.navigationItem.titleView = self.searchView;
    
}

-(UIView *)searchView
{
    if (_searchView == nil) {
        
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH*0.9,30)];
        
        _searchView.backgroundColor = [UIColor clearColor];
        
        [_searchView addSubview:self.searchBar];
        
    }
    
    return _searchView;
    
}

-(UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH*0.9,30)];
        
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;    
        
        _searchBar.placeholder = @"请输入搜索关键字";
        
        _searchBar.tintColor = [UIColor blueColor];
        
        UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
        
        [searchField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];

        _searchBar.delegate = self;
        
    }
    
    return _searchBar;
}

#pragma mark UISerchBar
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",searchBar.text);
    
    HZAllGoodsViewController *allGoods = [[HZAllGoodsViewController alloc] init];
    
    [self.navigationController pushViewController:allGoods animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#F7F7F7"]];

    
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
