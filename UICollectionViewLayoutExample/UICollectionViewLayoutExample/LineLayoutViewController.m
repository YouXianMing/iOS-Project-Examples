//
//  LineLayoutViewController.m
//  UICollectionViewLayoutExample
//
//  Created by YouXianMing on 2017/7/13.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "LineLayoutViewController.h"
#import "LineLayout.h"
#import "LineLayoutCollectionViewCell.h"

static NSString *reuseIdentifier = @"reuseIdentifier";

@interface LineLayoutViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LineLayout       *layout;
@property (nonatomic, strong) NSMutableArray   *datasArray;

@end

@implementation LineLayoutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 通知中心(检测屏幕旋转)
    self.notificationCenter = [DefaultNotificationCenter defaultNotificationCenterWithDelegate:self addNotificationNames:^(NSMutableArray<NSString *> *names) {
        
        [names addObject:UIApplicationDidChangeStatusBarOrientationNotification];
    }];
    
    self.layout = [LineLayout new];
    
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(10, 20, 10, 20);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[LineLayoutCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // collectionView的一些配置
    self.collectionView.layer.borderWidth = 0.5f;
    self.collectionView.layer.borderColor = [UIColor grayColor].CGColor;
    self.collectionView.showsVerticalScrollIndicator   = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.equalTo(self.view).multipliedBy(0.3f);
    }];
    
    // debug用,显示UICollectionView的contentInset区域
    UIView *debugView                = [UIView new];
    debugView.backgroundColor        = [[UIColor yellowColor] colorWithAlphaComponent:0.15f];
    debugView.userInteractionEnabled = NO;
    debugView.layer.borderWidth      = 0.5f;
    debugView.layer.borderColor      = [UIColor grayColor].CGColor;
    [self.view addSubview:debugView];
    [debugView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        UIEdgeInsets contentInsets = self.collectionView.contentInset;
        
        make.center.equalTo(self.view);
        make.left.equalTo(self.collectionView.mas_left).offset(contentInsets.left);
        make.right.equalTo(self.collectionView.mas_right).offset(-contentInsets.right);
        make.top.equalTo(self.collectionView.mas_top).offset(contentInsets.top);
        make.bottom.equalTo(self.collectionView.mas_bottom).offset(-contentInsets.bottom);
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LineLayoutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath                     = indexPath;
    [cell loadContent];
    
    return cell;
}

#pragma mark - DefaultNotificationCenterDelegate

- (void)defaultNotificationCenter:(DefaultNotificationCenter *)notification name:(NSString *)name object:(id)object {
    
    if ([name isEqualToString:UIApplicationDidChangeStatusBarOrientationNotification]) {
        
        [self.collectionView reloadData];
    }
}

@end
