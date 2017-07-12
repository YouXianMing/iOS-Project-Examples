//
//  GridLayoutCollectionViewCell.h
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridLayoutCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) NSIndexPath *indexPath;

- (void)loadContent;

@end
