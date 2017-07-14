//
//  LineLayout.m
//  UICollectionViewLayoutExample
//
//  Created by YouXianMing on 2017/7/13.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "LineLayout.h"

@interface LineLayout () {
    
    CGFloat  _itemWidth;
    CGFloat  _itemHeight;
    CGSize   _contentSize;
    
    NSArray <UICollectionViewLayoutAttributes *> *_attributes;
}

@end

@implementation LineLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    CGSize       collectionViewSize = self.collectionView.bounds.size;
    UIEdgeInsets contentInsets      = self.collectionView.contentInset;
    _itemWidth                      = collectionViewSize.width - (contentInsets.left + contentInsets.right);
    _itemHeight                     = collectionViewSize.height - (contentInsets.top + contentInsets.bottom);
    
    NSInteger       numberOfSections = [self.collectionView numberOfSections];
    CGFloat         offsetX          = 0;
    NSMutableArray *arrays           = [NSMutableArray array];
    
    for (int section = 0; section < numberOfSections; section++) {
        
        NSInteger numberOfRows = [self.collectionView numberOfItemsInSection:section];
        
        for (int row = 0; row < numberOfRows; row++) {
            
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
            attribute.frame                             = CGRectMake(offsetX, 0, _itemWidth, _itemHeight);
            offsetX                                    += _itemWidth;
            [arrays addObject:attribute];
        }
    }
    
    _contentSize = CGSizeMake(offsetX, _itemHeight);
    _attributes  = [arrays copy];
}

- (CGSize)collectionViewContentSize {
    
    return _contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *arrays = [NSMutableArray array];
    
    [_attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectIntersectsRect(obj.frame, rect)) {
            
            [arrays addObject:obj];
        }
    }];
    
    return arrays;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {

    UIEdgeInsets contentInsets = self.collectionView.contentInset;
    
    // 校正后的位移
    CGFloat offsetX = proposedContentOffset.x + contentInsets.left;
    
    // 求取的数值
    CGFloat value = offsetX / _itemWidth;
    
    // 获取整数部分
    CGFloat intValue = floor(value);
    
    // 获取小数部分
    CGFloat floatValue = value - intValue;
    
    // 进行计算
    CGFloat outOffsetX = 0;
    if (floatValue >= 0 && floatValue < 0.5f) {
        
        outOffsetX = intValue * _itemWidth;
        
    } else {
        
        outOffsetX = (intValue + 1) * _itemWidth;
    }
    
    return CGPointMake(outOffsetX - contentInsets.left, proposedContentOffset.y);
}

@end
