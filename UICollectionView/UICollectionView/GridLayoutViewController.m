//
//  GridLayoutViewController.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "GridLayoutViewController.h"
#import "GridLayout.h"
#import "GridLayoutCollectionViewCell.h"
#import "UIView+SetRect.h"

static NSString *cellIdentifier = @"GridLayoutCollectionViewCell";

@interface GridLayoutViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    NSArray *_datasArray;
}

@property (nonatomic, strong) GridLayout       *gridLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GridLayoutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 数据源(表示2维数组的数据)
    _datasArray = @[@3,
                    @4,
                    @5,
                    @3];
    
    // 创建布局
    self.gridLayout = [GridLayout new];
    
    // 创建UICollectionView
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.gridLayout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    
    // 注册cell
    [self.collectionView registerClass:[GridLayoutCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
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
    
    GridLayoutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.indexPath                     = indexPath;
    [cell loadContent];
    
    return cell;
}

@end
