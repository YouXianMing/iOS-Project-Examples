//
//  ListTableViewController.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListTableViewCell.h"
#import "ListTableViewData.h"
#import "MoveCellsViewController.h"
#import "AddOrRemoveCellsViewController.h"
#import "AddOrMoveOrDeleteViewController.h"

@interface ListTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"合集";
    
    // tableView
    self.tableView            = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight  = 60.f;
    [self.view addSubview:self.tableView];
    
    // register cells.
    [ListTableViewCell registerToTableView:self.tableView];
    
    // adapters
    self.adapters  = [NSMutableArray array];
    NSArray *datas = @[[ListTableViewData listTableViewDataWithClass:[MoveCellsViewController class]         info:@"cell的移动"],
                       [ListTableViewData listTableViewDataWithClass:[AddOrRemoveCellsViewController class]  info:@"添加删除cell"],
                       [ListTableViewData listTableViewDataWithClass:[AddOrMoveOrDeleteViewController class] info:@"添加删除移动cell"]];
    [datas enumerateObjectsUsingBlock:^(ListTableViewData *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.adapters addObject:[ListTableViewCell dataAdapterWithData:obj]];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.adapters[indexPath.row];
    CustomCell      *cell    = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter         = adapter;
    cell.data                = adapter.data;
    cell.indexPath           = indexPath;
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListTableViewData *data       = self.adapters[indexPath.row].data;
    UIViewController  *controller = [data.controllerClass new];
    controller.title              = data.info;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
