//
//  ComplexGridLayout.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ComplexGridLayout.h"
#import "GridLayoutFooterView.h"
#import "GridLayoutHeaderView.h"
#import "GridDecorationView.h"

@interface ComplexGridLayout ()

/**
 用于存储布局中的每个section中的item的布局信息对象数组
 */
@property (nonatomic, strong) NSArray <NSArray <UICollectionViewLayoutAttributes *> *> *cellAttributesArray;

/**
 用于存储布局中的header的布局信息对象数组
 */
@property (nonatomic, strong) NSArray <UICollectionViewLayoutAttributes *> *headerAttributesArray;

/**
 用于存储布局中的footer的布局信息对象数组
 */
@property (nonatomic, strong) NSArray <UICollectionViewLayoutAttributes *> *footerAttributesArray;

/**
 DecorationView的布局信息对象
 */
@property (nonatomic, strong) UICollectionViewLayoutAttributes *gridDecorationViewAttribute;

/**
 内容区域的大小
 */
@property (nonatomic) CGSize contentSize;

@end

@implementation ComplexGridLayout

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.itemSize          = CGSizeMake(80, 80);
        self.itemVerticalGap   = 5.f;
        self.itemHorizontalGap = 5.f;
        self.headerWidth       = 0.f;
        self.footerWidth       = 0.f;
        
        [self registerClass:[GridLayoutHeaderView class] forDecorationViewOfKind:complexGridLayoutHeaderView];
        [self registerClass:[GridLayoutFooterView class] forDecorationViewOfKind:complexGridLayoutFooterView];
        [self registerClass:[GridDecorationView   class] forDecorationViewOfKind:complexGridLayoutDecorationView];
    }
    
    return self;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    
    NSLog(@"prepareLayout");

    /*-----------------------------------------
     -------- 计算并存储items的布局属性对象 --------
     -----------------------------------------*/
    
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
    
    /*------------------------------------------
     -------- 计算并存储header的布局属性对象 --------
     ------------------------------------------*/
    
    // 用于存储所有section中的所有的header的布局信息(1维数组)
    NSMutableArray *sectionHeaderAttributesArray = [NSMutableArray array];
    
    for (int section = 0; section < numberOfSections; section++) {
        
        NSIndexPath                      *indexPath       = [NSIndexPath indexPathForRow:0 inSection:section];
        UICollectionViewLayoutAttributes *headerAttribute = [self layoutAttributesForSupplementaryViewOfKind:complexGridLayoutHeaderView atIndexPath:indexPath];
        [sectionHeaderAttributesArray addObject:headerAttribute];
    }
    
    self.headerAttributesArray = [sectionHeaderAttributesArray copy];
    
    /*------------------------------------------
     -------- 计算并存储footer的布局属性对象 --------
     ------------------------------------------*/
    
    // 用于存储所有section中的所有的footer的布局信息(1维数组)
    NSMutableArray *sectionFooterAttributesArray = [NSMutableArray array];
    
    for (int section = 0; section < numberOfSections; section++) {
        
        NSIndexPath                      *indexPath       = [NSIndexPath indexPathForRow:0 inSection:section];
        UICollectionViewLayoutAttributes *footerAttribute = [self layoutAttributesForSupplementaryViewOfKind:complexGridLayoutFooterView atIndexPath:indexPath];
        [sectionFooterAttributesArray addObject:footerAttribute];
    }
    
    self.footerAttributesArray = [sectionFooterAttributesArray copy];
    
    /*--------------------------------------------------
     -------- 计算collectionViewContentSize的大小 --------
     --------------------------------------------------*/
    
    __block CGRect totalRect = CGRectNull;
    [self.cellAttributesArray enumerateObjectsUsingBlock:^(NSArray<UICollectionViewLayoutAttributes *> *array, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
            
            totalRect = CGRectUnion(attribute.frame, totalRect);
        }];
    }];
    
    [self.headerAttributesArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        
        totalRect = CGRectUnion(attribute.frame, totalRect);
    }];
    
    [self.footerAttributesArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        
        totalRect = CGRectUnion(attribute.frame, totalRect);
    }];
    
    self.contentSize = totalRect.size;
    
    self.gridDecorationViewAttribute = [self layoutAttributesForDecorationViewOfKind:complexGridLayoutDecorationView atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger section = indexPath.section;
    NSInteger row     = indexPath.row;
    
    CGFloat itemWidth  = self.itemSize.width;
    CGFloat itemHeight = self.itemSize.height;
    
    CGFloat itemHorizontalGap = self.itemHorizontalGap;
    CGFloat itemVerticalGap   = self.itemVerticalGap;
    
    attributes.frame = CGRectMake(self.headerWidth + row * (itemWidth + itemHorizontalGap),
                                  section * (itemHeight + itemVerticalGap),
                                  itemWidth,
                                  itemHeight);
    
    return attributes;
}

/**
 根据给定的indexPath计算SupplementaryView的frame值

 @param elementKind A string that identifies the type of the supplementary view.
 @param indexPath The index path of the view.
 @return A layout attributes object containing the information to apply to the supplementary view.
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    if ([elementKind isEqualToString:complexGridLayoutHeaderView]) {
        
        // 计算headerView的frame值并生成布局对象
        NSInteger section       = indexPath.section;
        CGFloat itemHeight      = self.itemSize.height;
        CGFloat itemVerticalGap = self.itemVerticalGap;
        
        attributes.frame  = CGRectMake(0,
                                       section * (itemHeight + itemVerticalGap),
                                       self.headerWidth,
                                       itemHeight);
        
    } else if ([elementKind isEqualToString:complexGridLayoutFooterView]) {
        
        UICollectionViewLayoutAttributes *attribute = self.cellAttributesArray[indexPath.section].lastObject;
        
        // 计算footerView的frame值并生成布局对象
        NSInteger section       = indexPath.section;
        CGFloat itemHeight      = self.itemSize.height;
        CGFloat itemVerticalGap = self.itemVerticalGap;
        
        attributes.frame  = CGRectMake(attribute.frame.origin.x + attribute.frame.size.width,
                                       section * (itemHeight + itemVerticalGap),
                                       self.headerWidth,
                                       itemHeight);
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    
    CGFloat gap      = 0;
    attributes.frame = CGRectMake(gap, gap, self.contentSize.width - gap * 2, self.contentSize.height - gap * 2);
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
    
    [self.headerAttributesArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectIntersectsRect(attribute.frame, rect)) {
            
            [inRectAttributes addObject:attribute];
        }
    }];
    
    [self.footerAttributesArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectIntersectsRect(attribute.frame, rect)) {
            
            [inRectAttributes addObject:attribute];
        }
    }];
    
    if (CGRectIntersectsRect(self.gridDecorationViewAttribute.frame, rect)) {
        
        [inRectAttributes addObject:self.gridDecorationViewAttribute];
    }
    
    return inRectAttributes;
}

@end
