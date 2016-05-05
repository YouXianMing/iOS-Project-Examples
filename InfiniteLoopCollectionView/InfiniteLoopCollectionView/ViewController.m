//
//  ViewController.m
//  InfiniteLoopCollectionView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SetRect.h"
#import "CollectionImageCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray                     *datas;
@property (nonatomic, strong) UICollectionView            *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout  *flowLayout;
@property (nonatomic, strong) UIPageControl               *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Init datas.
    self.datas = @[[[UIColor redColor]    colorWithAlphaComponent:0.25f],
                   [[UIColor greenColor]  colorWithAlphaComponent:0.25f],
                   [[UIColor blueColor]   colorWithAlphaComponent:0.25f],
                   [[UIColor cyanColor]   colorWithAlphaComponent:0.25f],
                   [[UIColor yellowColor] colorWithAlphaComponent:0.25f]];
    
    // Init layout.
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize           = CGSizeMake(Width, 200);
    self.flowLayout.scrollDirection    = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    
    // Init UICollectionView.
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Width, 200)
                                             collectionViewLayout:self.flowLayout];
    self.collectionView.delegate                       = self;
    self.collectionView.dataSource                     = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled                  = YES;
    self.collectionView.backgroundColor                = [UIColor clearColor];
    [self.collectionView registerClass:[CollectionImageCell class] forCellWithReuseIdentifier:@"CollectionImageCell"];
    [self.view addSubview:self.collectionView];
    
    // Init UIPageControl.
    UIView *grayView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    grayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25f];
    grayView.bottom          = self.collectionView.bottom;
    grayView.userInteractionEnabled = NO;
    [self.view addSubview:grayView];
    
    self.pageControl               = [[UIPageControl alloc] initWithFrame:grayView.bounds];
    self.pageControl.numberOfPages = self.datas.count;
    [grayView addSubview:self.pageControl];
    
    // Scroll to specified position.
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:100]
                                atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    // Start timer event.
    [NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
}

- (void)timerEvent {
    
    if (self.collectionView.dragging == NO && self.collectionView.decelerating == NO) {
        
        NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
        
        NSInteger newRow     = (currentIndexPath.row + 1) % self.datas.count;
        NSInteger newSection = currentIndexPath.section + (newRow == 0 ? 1 : 0);
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newRow inSection:newSection];
        
        [self.collectionView scrollToItemAtIndexPath:newIndexPath
                                    atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

#pragma mark - UICollectionView's delegate & dataSource.

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 5000;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionImageCell"
                                                                          forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.data      = self.datas[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", self.datas[indexPath.row]);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = [self currentIndex] % self.datas.count;
}

#pragma mark - Other.

- (NSInteger)currentIndex {
    
    NSInteger index = 0;
    
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
        
    } else {
        
        index = (_collectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    
    return index;
}

#pragma mark - Hide bar.

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
