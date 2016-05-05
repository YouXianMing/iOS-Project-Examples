//
//  ViewController.m
//  GridFlowLayoutExample
//
//  Created by YouXianMing on 16/5/4.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SetRect.h"
#import "GridLayout.h"
#import "FlowStyleCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, GridLayoutDelegate>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) NSMutableArray    *datas;

@end

@implementation ViewController

- (NSNumber *)randomNum {

    return [NSNumber numberWithFloat:arc4random() % 100 + 80];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.datas = [NSMutableArray array];
    for (int i = 0; i < 300; i++) {
        
        [self.datas addObject:[self randomNum]];
    }
    
    
    // 初始化布局文件
    CGFloat gap               = 5;
    NSInteger rowCount        = 3;
    CGFloat rowHeight         = (Height - (rowCount + 1) * gap) / (CGFloat)rowCount;
    GridLayout *layout        = [GridLayout new];
    layout.manager.edgeInsets = UIEdgeInsetsMake(gap, gap, gap, gap);
    layout.manager.gap        = gap;
    layout.delegate           = self;
    
    NSMutableArray *rowHeights = [NSMutableArray array];
    for (int i = 0; i < rowCount; i++) {
        
        [rowHeights addObject:@(rowHeight)];
    }
    layout.manager.rowHeights = rowHeights;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self.collectionView registerClass:[FlowStyleCell class] forCellWithReuseIdentifier:@"FlowStyleCell"];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FlowStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlowStyleCell" forIndexPath:indexPath];
    cell.indexPath      = indexPath;
    [cell loadContent];
    
//    NSLog(@"%@", indexPath);
    
    return cell;
}

- (CGFloat)itemWidthWithIndexPath:(NSIndexPath *)indexPath {

    return [self.datas[indexPath.row] floatValue];
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
