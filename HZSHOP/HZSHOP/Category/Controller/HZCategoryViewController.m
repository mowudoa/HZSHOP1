//
//  HZCategoryViewController.m
//  HZSHOP
//
//  Created by 英峰 on 2019/4/9.
//  Copyright © 2019年 英峰. All rights reserved.
//

#import "HZCategoryViewController.h"
#import "HZCategoryModel.h"
#import "HZAllGoodsViewController.h"
#import "HZCategoryCollectionViewCell.h"

@interface HZCategoryViewController ()<
UISearchBarDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (weak, nonatomic) IBOutlet UIScrollView *mainCategoryView;

@property (weak, nonatomic) IBOutlet UICollectionView *subCategoryCollectionView;

@property(nonatomic,strong) UISearchBar *searchBar;

@property(nonatomic,strong) UIView *searchView;

@property(nonatomic,strong) NSMutableArray *mainClassArray;

@property(nonatomic,strong) NSMutableArray *subClassArray;

@end

@implementation HZCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self registerCell];
    
    [self initData];
    
}

-(void)initUI
{
    self.navigationItem.titleView = self.searchView;
    
    _mainClassArray = [[NSMutableArray alloc] init];
    
    _subClassArray = [[NSMutableArray alloc] init];
    
}

-(void)registerCell
{
    
    UINib* cate = [UINib nibWithNibName:@"HZCategoryCollectionViewCell" bundle:nil];
    [_subCategoryCollectionView registerNib:cate forCellWithReuseIdentifier:@"catecell"];
    
    [_subCategoryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

}
-(void)initData
{
  
    NSDictionary* dic = @{@"level":@"1"};
    
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:CATEGORY_GOODS parameters:dic HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        MJStrongSelf;
        
        [strongSelf.mainClassArray removeAllObjects];
        
        LOG(@"商品主分类", dic);
        
        if (SUCCESS) {
            
            //    [JKToast showWithText:dic[@"msg"]];
            
            NSArray *arr = dic[@"data"][@"list"];
            
            for (NSDictionary *dict in arr) {
                
                rootModel *model = [[rootModel alloc] init];
                
                model.rootTitle = dict[@"name"];
                
                model.rootId = dict[@"id"];
                
                [strongSelf.mainClassArray addObject:model];
            }
            
        }else{
            
            [JKToast showWithText:dic[@"msg"]];
            
        }
        
        [self createscrollview];
        
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
        LOG(@"cuow", Json);
        
    }];
    
}

#pragma mark - private
-(void)createscrollview
{
    
    for (int i = 0; i<_mainClassArray.count ; i++) {
        
        rootModel *model = _mainClassArray[i];
        
        UIButton* btn = [UIButton buttonWithType: UIButtonTypeCustom];
        
        [btn setFrame:CGRectMake(0, i*40, 100, 40)];
        
        [btn setTitle:model.rootTitle forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"regbtnfenlei"] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"#Fc5759"] forState:UIControlStateSelected];
        
        btn.tag = [model.rootId integerValue];
        
        
        if (i == 0) {
            
            btn.selected = YES;
            
            [self requestSubClass:model.rootId];
            
        }
    
        
        [_mainCategoryView addSubview:btn];
    }
    
    _mainCategoryView.contentSize = CGSizeMake(0, 40*_mainClassArray.count);
    
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

-(void)touchBtn:(UIButton*)sender
{
    sender.selected = YES;
    
    NSArray* arr = _mainCategoryView.subviews;
    
    for (UIButton* btn in arr) {
    
        if ([btn isKindOfClass:[UIButton class]]) {
        
            if (btn.tag != sender.tag) {
            
                btn.selected = NO;
            
            }
        }
    }

    [self requestSubClass:[NSString stringWithFormat:@"%ld",sender.tag]];
    
}

-(void)requestSubClass:(NSString *)subId
{
 
    NSDictionary* dic = @{@"level":@"2",
                          @"parentid":subId
                          };
    
    MJWeakSelf;
    
    [CrazyNetWork CrazyRequest_Post:CATEGORY_GOODS parameters:dic HUD:YES success:^(NSDictionary *dic, NSString *url, NSString *Json) {
        
        MJStrongSelf;
        
        [strongSelf.subClassArray removeAllObjects];
        
        LOG(@"商品次分类", dic);
        
        if (SUCCESS) {
            
            //    [JKToast showWithText:dic[@"msg"]];
            
            NSArray *arr = dic[@"data"][@"list"];
            
            for (NSDictionary *dict in arr) {
                
                 HZCategoryModel*model = [[HZCategoryModel alloc] init];
                
                model.rootTitle = dict[@"name"];
                
                model.rootId = dict[@"id"];
                
                NSArray *subArr = dict[@"son"];
                
                for (NSDictionary *sub in subArr){
                   
                    rootModel *model1 = [[rootModel alloc] init];
                    
                    model1.rootTitle = sub[@"name"];
                    
                    model1.rootId = sub[@"id"];
                    
                    model1.rootImageUrl = sub[@"advimg"];
                  
                    [model.subArray addObject:model1];
                    
                }
                
                [strongSelf.subClassArray addObject:model];
            }
            
        }else{
            
            [JKToast showWithText:dic[@"msg"]];
            
        }
        
        [strongSelf.subCategoryCollectionView reloadData];
        
    } fail:^(NSError *error, NSString *url, NSString *Json) {
        
        LOG(@"cuow", Json);
        
    }];
    
    
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

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    
    return _subClassArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    HZCategoryModel *model = _subClassArray[section];
    
    return model.subArray.count;
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HZCategoryCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"catecell" forIndexPath:indexPath];
    
    HZCategoryModel *model = _subClassArray[indexPath.section];
   
    rootModel *model1 = model.subArray[indexPath.row];
    
    cell.classTitle.text = model1.rootTitle;
    
    cell.classTitle.adjustsFontSizeToFitWidth = YES;
    
    [cell.classIcon sd_setImageWithURL:[NSURL URLWithString:model1.rootImageUrl] placeholderImage:[UIImage imageNamed:@"appIcon"]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HZAllGoodsViewController *more = [[HZAllGoodsViewController alloc] init];

    HZCategoryModel *model = _subClassArray[indexPath.section];
    
    rootModel *model1 = model.subArray[indexPath.row];
    
    more.classId = model1.rootId;
    
    [self.navigationController pushViewController:more animated:YES];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];

    for (UIView *view in headerView.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    [headerView addSubview:[self createheader2ViewWithSection:indexPath.section]];
    
    return  headerView;
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(_subCategoryCollectionView.frame.size.width,40);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 0, 2);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((_subCategoryCollectionView.width-20)/3-2, (_subCategoryCollectionView.width-20)/3-2+40);
}

-(UIView*)createheader2ViewWithSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0,0, _subCategoryCollectionView.width,40)];
    
    view.userInteractionEnabled = YES;
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0,10,_subCategoryCollectionView.width, 30)];
    
    HZCategoryModel *model = [[HZCategoryModel alloc] init];
    
    model = _subClassArray[section];
    
    label.text = model.rootTitle;
    
    label.textColor = [UIColor colorWithHexString:@"#888888"];
    
    label.font = [UIFont boldSystemFontOfSize:13];
    
    label.textAlignment = NSTextAlignmentLeft;
    
    [view addSubview:label];
    
    return view;
    
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
