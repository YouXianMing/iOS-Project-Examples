//
//  ViewController.m
//  TableViewNesting
//
//  Created by YouXianMing on 2019/2/19.
//  Copyright © 2019 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "NestingTableView.h"
#import "Value.h"
#import "UIView+SetRect.h"
#import "BannerCell.h"
#import "NoticeCell.h"
#import "ContentTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, ContentTableViewCellDelegate> {
    
    ContentTableViewCell *_cellTableView;
}

@property (nonatomic, strong) NestingTableView *tableView;
@property (nonatomic)         BOOL              tableViewCanMove;
@property (nonatomic, strong) NSMutableArray  <NSMutableArray <CellDataAdapter *> *> *sections;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.sections = [NSMutableArray array];
    
    self.tableViewCanMove = YES;
    
    self.tableView                              = [[NestingTableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStylePlain];
    self.tableView.delegate                     = self;
    self.tableView.dataSource                   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    [BannerCell           registerToTableView:self.tableView];
    [NoticeCell           registerToTableView:self.tableView];
    [ContentTableViewCell registerToTableView:self.tableView];
    
    // 解决顶部留白问题
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    NSMutableArray *section_1 = [NSMutableArray array];
    [section_1 addObject:[BannerCell dataAdapterWithCellHeight:200.f]];
    [section_1 addObject:[NoticeCell dataAdapterWithCellHeight:50.f]];
    [self.sections addObject:section_1];
    
    NSMutableArray *section_2 = [NSMutableArray array];
    [section_2 addObject:[ContentTableViewCell dataAdapterWithCellHeight:Height - Value.GapFromTop]];
    [self.sections addObject:section_2];
}

#pragma mark - ContentTableViewCellDelegate

- (void)contentTableViewCellScrollToTop:(ContentTableViewCell *)cell {
    
    // 里面的tableView移动到顶时,通知外部的tableView并设置其可移动
    _tableViewCanMove = YES;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y >= [self.tableView rectForSection:1].origin.y - Value.GapFromTop) {
    
        // 外部tableView移动到指定位置以下时,将外部tableView设置成不能移动,里面的tableView设置成可移动
        _tableViewCanMove               = NO;
        _cellTableView.tableViewCanMove = YES;
        
    } else {
        
        // 外部tableView移动到指定位置以上时,将里面的tableView设置成不可移动
        _cellTableView.tableViewCanMove = NO;
    }
    
    // 如果不能移动,则固定y位移
    if (_tableViewCanMove == NO) {
        
        self.tableView.contentOffset = CGPointMake(0, [self.tableView rectForSection:1].origin.y - Value.GapFromTop);
    }
    
    scrollView.showsVerticalScrollIndicator = _tableViewCanMove ? YES : NO;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.sections[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.sections[indexPath.section][indexPath.row];
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter = adapter;
    cell.data        = adapter.data;
    cell.indexPath   = indexPath;
    [cell loadContent];
    
    if (_cellTableView == nil && [cell isKindOfClass:ContentTableViewCell.class]) {
        
        _cellTableView              = (ContentTableViewCell *)cell;
        _cellTableView.cellDelegate = self;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.sections[indexPath.section][indexPath.row];
    return adapter.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectedEvent];
}

@end
