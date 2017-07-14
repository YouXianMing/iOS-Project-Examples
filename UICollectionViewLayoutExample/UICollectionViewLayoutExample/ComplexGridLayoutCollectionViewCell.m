//
//  ComplexGridLayoutCollectionViewCell.m
//  UICollectionView
//
//  Created by YouXianMing on 2017/7/12.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ComplexGridLayoutCollectionViewCell.h"
#import "Masonry.h"

@interface ComplexGridLayoutCollectionViewCell ()

@property (nonatomic, strong) UILabel *sectionLabel;
@property (nonatomic, strong) UILabel *rowLabel;

@end

@implementation ComplexGridLayoutCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor redColor].CGColor;
        
        self.sectionLabel           = [UILabel new];
        self.sectionLabel.font      = [UIFont systemFontOfSize:12];
        self.sectionLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.sectionLabel];
        
        [self.sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(5.f);
            make.top.mas_equalTo(5.f);
        }];
        
        self.rowLabel      = [UILabel new];
        self.rowLabel.font = [UIFont systemFontOfSize:25.f];
        [self.contentView addSubview:self.rowLabel];
        
        [self.rowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-10.f);
            make.bottom.mas_equalTo(-5.f);
        }];
    }
    
    return self;
}

- (void)loadContent {
    
    self.sectionLabel.text = [NSString stringWithFormat:@"Section [%ld]", (long)self.indexPath.section];
    self.rowLabel.text     = [NSString stringWithFormat:@"%ld", (long)self.indexPath.row];
}

@end
