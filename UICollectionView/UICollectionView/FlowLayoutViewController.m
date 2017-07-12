//
//  FlowLayoutViewController.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "FlowLayoutViewController.h"
#import "FlowLayoutCollectionViewCell.h"
#import "GCD.h"
#import "UIView+SetRect.h"
#import "HeaderCollectionReusableView.h"
#import "FooterCollectionReusableView.h"

static NSString *cellIdentifier = @"FlowLayoutCollectionViewCell";
static NSString *headerViewId   = @"headerViewId";
static NSString *footerViewId   = @"footerViewId";

@interface FlowLayoutViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    NSArray *_datasArray;
}

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView           *collectionView;

@end

@implementation FlowLayoutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 数据源(表示2维数组的数据)
    _datasArray = @[@3,
                    @4,
                    @5,
                    @3];
    
    self.flowLayout                         = [UICollectionViewFlowLayout new];
    self.flowLayout.itemSize                = CGSizeMake(80.f, 80.f);
    self.flowLayout.minimumLineSpacing      = 5.f;
    self.flowLayout.minimumInteritemSpacing = 5.f;
    self.flowLayout.headerReferenceSize     = CGSizeMake(0, 20);
    self.flowLayout.footerReferenceSize     = CGSizeMake(0, 20);
    self.flowLayout.sectionInset            = UIEdgeInsetsMake(5, 5, 5, 5);
    
    // 创建UICollectionView
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView.backgroundColor = [UIColor clearColor];
    // self.collectionView.cont
    [self.view addSubview:self.collectionView];
    
    // 注册cell,headerView,footerView
    [self.collectionView registerClass:[FlowLayoutCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewId];
    [self.collectionView registerClass:[FooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewId];
    
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
    
    FlowLayoutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.indexPath                     = indexPath;
    [cell loadContent];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        HeaderCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewId forIndexPath:indexPath];
        return view;
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
        FooterCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerViewId forIndexPath:indexPath];
        return view;
        
    } else {
        
        return nil;
    }
}

@end
