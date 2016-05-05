//
//  CollectionImageCell.h
//  InfiniteLoopCollectionView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionImageCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath  *indexPath;
@property (nonatomic, strong) id            data;

- (void)loadContent;

@end
