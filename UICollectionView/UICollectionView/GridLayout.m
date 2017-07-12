//
//  GridLayout.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "GridLayout.h"

@interface GridLayout ()

/**
 用于存储布局中的每个section中的item的布局信息
 */
@property (nonatomic, strong) NSArray <NSArray <UICollectionViewLayoutAttributes *> *> *cellAttributesArray;

/**
 内容区域的大小
 */
@property (nonatomic) CGSize contentSize;

@end

@implementation GridLayout

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.itemSize          = CGSizeMake(80, 80);
        self.itemVerticalGap   = 5.f;
        self.itemHorizontalGap = 5.f;
    }
    
    return self;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    
    NSLog(@"prepareLayout");
    
    // 从collectionView获取多少个sections
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    
    // 用于存储所有section中的所有的cell的布局信息(2维数组)
    NSMutableArray *sectionCellAttributesArray = [NSMutableArray array];
    
    // 遍历sections
    for (int section = 0; section < numberOfSections; section++) {
        
        // 用于存储当前section中的所有的cell的布局信息(1维数组)
        NSMutableArray *sectionCellAttributes = [NSMutableArray array];
        
        // 从collectionView的section中获取多少个items
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        
        // 遍历sections中的items
        for (int item = 0; item < numberOfItems; item++) {
            
            // 创建cell的坐标信息(NSIndexPath)
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:item inSection:section];
            
            // 根据给定的indexPath(每个cell的坐标)计算该cell的frame值属性
            UICollectionViewLayoutAttributes *cellAttribute = [self layoutAttributesForItemAtIndexPath:cellIndexPath];
            [sectionCellAttributes addObject:cellAttribute];
        }
        
        [sectionCellAttributesArray addObject:sectionCellAttributes];
    }
    
    self.cellAttributesArray = [sectionCellAttributesArray copy];
    
    // 计算collectionViewContentSize的大小
    __block CGRect totalRect = CGRectNull;
    [self.cellAttributesArray enumerateObjectsUsingBlock:^(NSArray<UICollectionViewLayoutAttributes *> *array, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
            
            totalRect = CGRectUnion(attribute.frame, totalRect);
        }];
    }];
    
    CGFloat edgeRight  = self.collectionView.contentInset.right;
    CGFloat edgeBottom = self.collectionView.contentInset.bottom;
    self.contentSize   = CGSizeMake(totalRect.origin.x + totalRect.size.width + edgeRight,
                                    totalRect.origin.y + totalRect.size.height + edgeBottom);
    
}

/**
 获取collectionView内容区域的大小(需要提前计算好)

 @return 内容区域的大小
 */
- (CGSize)collectionViewContentSize {
    
    NSLog(@"collectionViewContentSize");
    
    return self.contentSize;
}

/**
 根据给定的indexPath(每个cell的坐标)计算该cell的frame值属性

 @param indexPath cell的坐标
 @return 该cell的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"layoutAttributesForItemAtIndexPath:");
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger section = indexPath.section;
    NSInteger row     = indexPath.row;
    
    CGFloat edgeLeft   = self.collectionView.contentInset.left;
    CGFloat edgeTop    = self.collectionView.contentInset.top;
    
    CGFloat itemWidth  = self.itemSize.width;
    CGFloat itemHeight = self.itemSize.height;
    
    CGFloat itemHorizontalGap = self.itemHorizontalGap;
    CGFloat itemVerticalGap   = self.itemVerticalGap;
    
    attributes.frame = CGRectMake(edgeLeft + row * (itemWidth + itemHorizontalGap),
                                  edgeTop + section * (itemHeight + itemVerticalGap),
                                  itemWidth,
                                  itemHeight);
    
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSLog(@"layoutAttributesForElementsInRect:");
    
    NSMutableArray *inRectAttributes = [NSMutableArray array];
    
    [self.cellAttributesArray enumerateObjectsUsingBlock:^(NSArray<UICollectionViewLayoutAttributes *> *array, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (CGRectIntersectsRect(attribute.frame, rect)) {
                
                [inRectAttributes addObject:attribute];
            }
        }];
    }];
    
    return inRectAttributes;
}

@end
