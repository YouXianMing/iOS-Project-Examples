//
//  AddOrRemoveCellsViewController.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "AddOrRemoveCellsViewController.h"
#import "AddOrRemoveCellData.h"
#import "AddOrRemoveCell.h"
#import "AddIconCell.h"

@interface AddOrRemoveCellsViewController ()

@end

@implementation AddOrRemoveCellsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [AddOrRemoveCell registerToTableView:self.tableView];
    [AddIconCell     registerToTableView:self.tableView];
    
    // BarButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(barButtonItem:)];
    
    // datas
    NSArray *datas = @[[AddOrRemoveCellData addOrRemoveCellDataWithTitle:@"0"],
                       [AddOrRemoveCellData addOrRemoveCellDataWithTitle:@"1"],
                       [AddOrRemoveCellData addOrRemoveCellDataWithTitle:@"2"],
                       [AddOrRemoveCellData addOrRemoveCellDataWithTitle:@"3"],
                       [AddOrRemoveCellData addOrRemoveCellDataWithTitle:@"4"],
                       [AddOrRemoveCellData addOrRemoveCellDataWithTitle:@"5"],
                       [AddOrRemoveCellData addOrRemoveCellDataWithTitle:@"6"]];
    
    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.adapters addObject:[AddOrRemoveCell dataAdapterWithData:obj cellHeight:60.f]];
    }];    
}

- (void)barButtonItem:(UIBarButtonItem *)item {
    
    if ([item.title isEqualToString:@"Edit"]) {
        
        item.title = @"Done";
        
        [self.adapters insertObject:[AddIconCell dataAdapterWithData:nil cellHeight:30.f] atIndex:0];
        [self.adapters insertObject:[AddIconCell dataAdapterWithData:nil cellHeight:30.f] atIndex:2];
        [self.adapters insertObject:[AddIconCell dataAdapterWithData:nil cellHeight:30.f] atIndex:4];
        
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],
                                                 [NSIndexPath indexPathForRow:2 inSection:0],
                                                 [NSIndexPath indexPathForRow:4 inSection:0],]
                              withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        
        item.title = @"Edit";
        
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        [indexSet addIndex:0];
        [indexSet addIndex:2];
        [indexSet addIndex:4];
        [self.adapters removeObjectsAtIndexes:indexSet];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],
                                                 [NSIndexPath indexPathForRow:2 inSection:0],
                                                 [NSIndexPath indexPathForRow:4 inSection:0],]
                              withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
