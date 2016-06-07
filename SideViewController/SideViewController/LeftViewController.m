//
//  LeftViewController.m
//  SideViewController
//
//  Created by YouXianMing on 16/6/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "LeftViewController.h"
#import "leftViewCell.h"

@interface LeftViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSArray      *titlesArray;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titlesArray = @[@"", @"设置", @"开始"];
    
    self.tableView                 = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[LeftViewCell class] forCellReuseIdentifier:@"LeftViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LeftViewCell *cell = (LeftViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LeftViewCell"];
    cell.data          = _titlesArray[indexPath.row];
    [cell loadContent];
    
    return cell;
}

@end
