//
//  HZAllGoodsViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/16.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZAllGoodsViewController.h"
#import "HZGoodsModel.h"
#import "HZGoodsCollectionViewCell.h"
#import "HZGoodsDetailViewController.h"
#import "HZTableCollectionViewCell.h"
@interface HZAllGoodsViewController ()<
UISearchBarDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (weak, nonatomic) IBOutlet UICollectionView *allGoodsCollectionView;

@property(nonatomic,strong) UISearchBar *searchBar;

@property(nonatomic,strong) UIView *searchView;

@property(strong,nonatomic)UIBarButtonItem* rightItem;

@property(strong,nonatomic) NSMutableArray *allGoodsArray;

@property(copy,nonatomic) NSString *sortType;//排序方式

@property(copy,nonatomic) NSString *collation;//排序规则

@property(assign,nonatomic) NSInteger tipNum;//价格点击次数


@end

@implementation HZAllGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registeCell];
    
    [self initData];
    
}

-(void)initUI
{
    _tipNum = 1;
 
    _collation = @"1";
    
    self.navigationItem.titleView = self.searchView;
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    _listType = collectionViewType;
    
    self.allGoodsArray = [[NSMutableArray alloc] init];
    
}

-(void)registeCell
{
    
    UINib* cate = [UINib nibWithNibName:@"HZGoodsCollectionViewCell" bundle:nil];
    
    [_allGoodsCollectionView registerNib:cate forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
    
    UINib* cate1 = [UINib nibWithNibName:@"HZTableCollectionViewCell" bundle:nil];
    
    [_allGoodsCollectionView registerNib:cate1 forCellWithReuseIdentifier:@"TableCollectionViewCell"];
    
}

-(void)initData
{
   
    NSMutableDictionary *keyDic = [[NSMutableDictionary alloc] init];

    
    if (_sortType != nil) {
        
        [keyDic addEntriesFromDictionary:@{@"px":_sortType}];
        
        [keyDic addEntriesFromDictionary:@{@"pxgz":_collation}];
        
    }
    
    if (_keyWords != nil) {
        
        [keyDic addEntriesFromDictionary:@{@"title":_keyWords}];
    }
    
    if (_classId != nil) {
        
        [keyDic addEntriesFromDictionary:@{@"pcate":_classId}];

    }
    
    
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:ALL_GOODS parameters:keyDic HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        MJStrongSelf;
        
        [strongSelf.allGoodsArray removeAllObjects];
        
        LOG(@"商品列表", dic);
        
        if (SUCCESS) {
            
            //    [JKToast showWithText:dic[@"msg"]];
            
            NSArray *arr = dic[@"data"][@"list"];
            
            for (NSDictionary *dict in arr) {
                
                HZGoodsModel*model = [[HZGoodsModel alloc] init];
                
                model.rootTitle = dict[@"title"];
                
                model.rootId = dict[@"id"];
                
                model.goodsOldPrice = dict[@"productprice"];
                
                model.goodsPrice = dict[@"marketprice"];

                model.rootImageUrl = dict[@"thumb"];
                
                [strongSelf.allGoodsArray addObject:model];
                
            }
            
        }else{
            
            [JKToast showWithText:dic[@"msg"]];
            
        }
        
        [strongSelf.allGoodsCollectionView reloadData];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
        LOG(@"cuow", Json);
        
    }];
    
    
}

-(UIView *)searchView
{
    if (_searchView == nil) {
        
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH*0.75,30)];
        
        _searchView.backgroundColor = [UIColor clearColor];
        
        [_searchView addSubview:self.searchBar];
        
    }
    
    return _searchView;
    
}

-(UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH*0.75,30)];
        
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        
        _searchBar.placeholder = @"请输入搜索关键字";
        
        _searchBar.tintColor = [UIColor blueColor];
        
        UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
        
        [searchField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        
        _searchBar.delegate = self;
        
    }
    
    return _searchBar;
    
}

#pragma mark rightButtonItem
-(UIBarButtonItem*)rightItem
{
    if (_rightItem == nil) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setFrame:view.frame];
        
        [btn setImage:[UIImage imageNamed:@"liebiao"] forState:UIControlStateNormal];
       
        [btn setImage:[UIImage imageNamed:@"app-liebiao"] forState:UIControlStateSelected];

        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"#9B9B9B"] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:btn];
        
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:view];
        
    }
    
    return _rightItem;
}

#pragma mark 切换商品展示方式
-(void)rightAction:(UIButton *)sender
{
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        _listType = tableViewType;
        
    }else{
        
        _listType = collectionViewType;
        
    }
    
    [_allGoodsCollectionView reloadData];
    
}

#pragma mark 商品选择排序
- (IBAction)goodsSort:(UIButton *)sender {

    for (UIView *view in sender.superview.superview.subviews) {
        
        ((UIButton *)[view.subviews objectAtIndex:0]).selected = NO;
    
    }
 
    sender.selected = !sender.selected;
    
    if ([sender.titleLabel.text isEqualToString:@"综合"]){
       
        _sortType = nil;
        
        _collation = @"1";
        
        _tipNum = 1;
        
    }else if ([sender.titleLabel.text isEqualToString:@"销量"]){
        
        _sortType = @"salesreal";
        
        _collation = @"1";

        _tipNum = 1;

    }else if ([sender.titleLabel.text isEqualToString:@"价格"]){
        
        _sortType = @"marketprice";
        
        if (_tipNum%2 == 0) {
            
            _collation = @"0";

        }else{
            
            _collation = @"1";

        }
        
        _tipNum ++;
    }
    
    [self initData];

}


#pragma mark UISerchBarDelagate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",searchBar.text);
    
    _keyWords = searchBar.text;
    
    [self initData];
    
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _allGoodsArray.count;
    
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HZGoodsModel *model = _allGoodsArray[indexPath.row];
    
    if (_listType == tableViewType) {
        
        HZTableCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TableCollectionViewCell" forIndexPath:indexPath];
        
        [cell.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.rootImageUrl] placeholderImage:[UIImage imageNamed:@"appIcon"]];
        
        cell.goodsTitle.text = model.rootTitle;
        
        cell.goodsOldPrice.attributedText = [WYFTools AddCenterLineToView:model.goodsOldPrice];
        
        cell.goodsPrice.text = [NSString stringWithFormat:@"￥%@",model.goodsPrice];
                
        return cell;
        
    }
    
    HZGoodsCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
    
    cell.goodsTitle.text = model.rootTitle;
    
    cell.goodsOldPrice.attributedText = [WYFTools AddCenterLineToView:model.goodsOldPrice];
    
    cell.goodsPrice.text = [NSString stringWithFormat:@"￥%@",model.goodsPrice];
    
    [cell.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.rootImageUrl] placeholderImage:[UIImage imageNamed:@"appIcon"]];

    return cell;
    
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HZGoodsDetailViewController *goodsDetail = [[HZGoodsDetailViewController alloc] init];
    
    HZGoodsModel *model = _allGoodsArray[indexPath.row];
    
    goodsDetail.goodsId = model.rootId;
    
    [self.navigationController pushViewController:goodsDetail animated:YES];
   
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (_listType == tableViewType) {
        
        return UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    if (_listType == tableViewType) {
        
        return 0;
        
    }
    
    return 5;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_listType == tableViewType) {
        
        return CGSizeMake(SCREEN_WIDTH, 124);
        
    }
    
    return CGSizeMake((_allGoodsCollectionView.width-10)/2-2, ((_allGoodsCollectionView.width-10)/2-2) + 90);
    
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
