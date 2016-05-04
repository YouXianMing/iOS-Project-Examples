//
//  ViewController.m
//  LayoutViewController
//
//  Created by YouXianMing on 16/5/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SetRect.h"
#import "RootModel.h"
#import "FlowStyleCell.h"
#import "CollectionHeaderView.h"
#import "CollectionBottomView.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) RootModel         *rootModel;
@property (nonatomic, strong) UICollectionView  *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createDataSource];
    
    [self createCollectionView];
}

#pragma mark - Create data source.

- (void)createDataSource {
    
    NSDictionary *datas = @{@"response" : @YES,
                            @"datas"    : @[@{@"title"    : @"Header1",
                                              @"subTitle" : @"Bottom1",
                                              @"infos"    : @[@{@"name" : @"1"}, @{@"name" : @"2"},
                                                              @{@"name" : @"3"}, @{@"name" : @"4"},
                                                              @{@"name" : @"5"}, @{@"name" : @"6"},
                                                              @{@"name" : @"7"}, @{@"name" : @"8"},
                                                              @{@"name" : @"9"}]},
                                            @{@"title"    : @"Header2",
                                              @"subTitle" : @"Bottom2",
                                              @"infos"    : @[@{@"name" : @"1"}, @{@"name" : @"2"},
                                                              @{@"name" : @"3"}, @{@"name" : @"4"},
                                                              @{@"name" : @"5"}, @{@"name" : @"6"}]},
                                            @{@"title"    : @"Header3",
                                              @"subTitle" : @"Bottom3",
                                              @"infos"    : @[@{@"name" : @"1"}, @{@"name" : @"2"},
                                                              @{@"name" : @"3"}, @{@"name" : @"4"},
                                                              @{@"name" : @"5"}, @{@"name" : @"6"},
                                                              @{@"name" : @"7"}, @{@"name" : @"8"}]}]};
    self.rootModel = [[RootModel alloc] initWithDictionary:datas];
}

#pragma mark - Create UICollectionView.

- (void)createCollectionView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Setup UICollectionViewFlowLayout.
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize                    = CGSizeMake(90, 120);
    layout.sectionInset                = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing     = 25.f; // 横向排列最小间距
    layout.minimumLineSpacing          = 5.0f; // 纵向排列最小间距
    
    // Init UICollectionView.
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    
    // Register CollectionHeaderView & CollectionBottomView.
    [self.collectionView registerClass:[FlowStyleCell class] forCellWithReuseIdentifier:@"FlowStyleCell"];
    [self.collectionView registerClass:[CollectionHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView"];
    [self.collectionView registerClass:[CollectionBottomView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionBottomView"];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionView's delegate & dataSource.

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    DatasModel *dataModel = self.rootModel.datas[section];
    
    return dataModel.infos.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.rootModel.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DatasModel *dataModel = self.rootModel.datas[indexPath.section];
    InfoModel  *infoModel = dataModel.infos[indexPath.row];
    
    FlowStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlowStyleCell" forIndexPath:indexPath];
    cell.data           = infoModel;
    cell.indexPath      = indexPath;
    [cell loadContent];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionHeaderView"
                                                                 forIndexPath:indexPath];
        
        DatasModel *dataModel  = self.rootModel.datas[indexPath.section];
        reusableView.data      = dataModel;
        reusableView.indexPath = indexPath;
        [reusableView loadContent];
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionBottomView"
                                                                 forIndexPath:indexPath];
        
        DatasModel *dataModel  = self.rootModel.datas[indexPath.section];
        reusableView.data      = dataModel;
        reusableView.indexPath = indexPath;
        [reusableView loadContent];
    }
    
    return reusableView;
}

#pragma mark - UICollectionViewDelegateFlowLayout.

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    // If you have headerView, you must implement this method.
    return CGSizeMake(Width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    // If you have footerView, you must implement this method.
    return CGSizeMake(Width, 40);
}

#pragma mark - Hide statusBar.

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
