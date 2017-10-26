//
//  MasterViewController.m
//  iPad_App
//
//  Created by YouXianMing on 2017/10/23.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterTableViewCell.h"
#import "Masonry.h"
#import "UIViewController+DebugFrame.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray <UIViewController *> *viewControllers;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 存储所有控制器对象并移除masterController
    self.viewControllers = [NSMutableArray arrayWithArray:self.splitViewController.viewControllers];
    [self.viewControllers removeObjectAtIndex:0];
    
    self.tableView            = [[UITableView alloc] init];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight  = 100.f;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[MasterTableViewCell class] forCellReuseIdentifier:@"MasterTableViewCell"];
    
    //  适配iPad代码,解决ipad上的tableView的边距问题
    self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self showDebugFrame];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterTableViewCell"];
    cell.textLabel.text       = NSStringFromClass(self.viewControllers[indexPath.row].class);
    cell.backgroundColor      = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.splitViewController showDetailViewController:self.viewControllers[indexPath.row] sender:nil];
}

#pragma mark - view show info

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"'%@' viewWillAppear", NSStringFromClass([self class]));
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"'%@' viewDidAppear", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    NSLog(@"'%@' viewWillDisappear", NSStringFromClass([self class]));
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    NSLog(@"'%@' viewDidDisappear", NSStringFromClass([self class]));
}

@end
