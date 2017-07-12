//
//  ComplexGridLayoutViewController.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ComplexGridLayoutViewController.h"
#import "ComplexGridLayout.h"
#import "ComplexGridLayoutCollectionViewCell.h"
#import "UIView+SetRect.h"
#import "GridLayoutHeaderView.h"
#import "GridLayoutFooterView.h"
#import "GridDecorationView.h"

static NSString *cellIdentifier   = @"ComplexGridLayoutCollectionViewCell";
static NSString *headerViewId     = @"headerViewId";
static NSString *footerViewId     = @"footerViewId";

@interface ComplexGridLayoutViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    NSArray *_datasArray;
}

@property (nonatomic, strong) ComplexGridLayout *gridLayout;
@property (nonatomic, strong) UICollectionView  *collectionView;

@end

@implementation ComplexGridLayoutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 数据源(表示2维数组的数据)
    _datasArray = @[@3,
                    @4,
                    @5,
                    @3];
    
    // 创建布局
    self.gridLayout             = [ComplexGridLayout new];
    self.gridLayout.headerWidth = 20.f;
    self.gridLayout.footerWidth = 20.f;
    
    // 创建UICollectionView
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.gridLayout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    
    // 注册cell
    [self.collectionView registerClass:[ComplexGridLayoutCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[GridLayoutHeaderView class] forSupplementaryViewOfKind:complexGridLayoutHeaderView withReuseIdentifier:headerViewId];
    [self.collectionView registerClass:[GridLayoutFooterView class] forSupplementaryViewOfKind:complexGridLayoutFooterView withReuseIdentifier:footerViewId];
    
    // collectionView的一些配置
    self.collectionView.width             = Width - 10.f;
    self.collectionView.height            = Width - 10.f;
    self.collectionView.center            = self.view.center;
    self.collectionView.layer.borderWidth = 0.5f;
    self.collectionView.layer.borderColor = [UIColor grayColor].CGColor;
    self.collectionView.showsVerticalScrollIndicator   = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return _datasArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_datasArray[section] integerValue];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ComplexGridLayoutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.indexPath                            = indexPath;
    [cell loadContent];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:complexGridLayoutHeaderView]) {
        
        GridLayoutHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewId forIndexPath:indexPath];
        return view;
        
    } else if ([kind isEqualToString:complexGridLayoutFooterView]) {
        
        GridLayoutFooterView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerViewId forIndexPath:indexPath];
        return view;
        
    } else {
        
        return nil;
    }
}

@end
