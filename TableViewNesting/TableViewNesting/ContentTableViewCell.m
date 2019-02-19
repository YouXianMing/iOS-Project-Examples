//
//  ContentTableViewCell.m
//  TestTableView
//
//  Created by YouXianMing on 2019/2/18.
//  Copyright © 2019 YouXianMing. All rights reserved.
//

#import "ContentTableViewCell.h"
#import "UIView+SetRect.h"
#import "Value.h"

@interface ContentTableViewCell () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;

@end

@implementation ContentTableViewCell

- (void)buildSubview {
    
    self.contentTableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - Value.GapFromTop) style:UITableViewStylePlain];
    self.contentTableView.delegate   = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.rowHeight  = 50.f;
    [self.contentView addSubview:self.contentTableView];
    
    [self.contentTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
    
    // 解决顶部留白问题
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.contentTableView.layer.borderWidth = 2.f;
    self.contentTableView.layer.borderColor = UIColor.redColor.CGColor;
}

- (void)loadContent {
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 里面的tableView移动到顶部时,固定其y位移,并通过代理通知外部tableView
    if (scrollView.contentOffset.y <= 0) {
        
        scrollView.contentOffset = CGPointMake(0, 0);
        
        if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(contentTableViewCellScrollToTop:)]) {
            
            [self.cellDelegate contentTableViewCellScrollToTop:self];
        }
    }
    
    // 如果不能移动,则固定y位移
    if (_tableViewCanMove == NO) {
        
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    scrollView.showsVerticalScrollIndicator = self.tableViewCanMove ? YES : NO;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    cell.textLabel.text          = [NSString stringWithFormat:@"Data - %ld", (long)indexPath.row + 1];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle          = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Data - %ld", (long)indexPath.row + 1]);
}

@end
