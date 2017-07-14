//
//  LineLayoutCollectionViewCell.h
//  UICollectionViewLayoutExample
//
//  Created by YouXianMing on 2017/7/13.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineLayoutCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) NSIndexPath *indexPath;

- (void)loadContent;

@end
