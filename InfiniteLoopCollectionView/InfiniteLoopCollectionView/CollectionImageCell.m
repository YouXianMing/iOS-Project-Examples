//
//  CollectionImageCell.m
//  InfiniteLoopCollectionView
//
//  Created by YouXianMing on 16/5/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CollectionImageCell.h"

@interface CollectionImageCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation CollectionImageCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
    
        self.label      = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 12.f)];
        self.label.font = [UIFont fontWithName:@"Heiti SC" size:10.f];
        [self addSubview:self.label];
    }
    
    return self;
}

- (void)loadContent {

    self.backgroundColor = self.data;
    self.label.text      = [NSString stringWithFormat:@"section:%03ld row:%03ld",
                            (long)self.indexPath.section,
                            (long)self.indexPath.row];
    [self.label sizeToFit];
}

@end
