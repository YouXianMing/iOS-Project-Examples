//
//  NormalDragViewController.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MoveCellsViewController.h"
#import "NormalDragViewCell.h"
#import "NormalDragViewCellData.h"

@interface MoveCellsViewController ()

@end

@implementation MoveCellsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // BarButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(barButtonItem:)];
    
    // register tableView.
    [NormalDragViewCell registerToTableView:self.tableView];
    
    // datas
    NSArray *datas = @[[NormalDragViewCellData normalDragViewCellDataWithTitle:@"0 - 不让移动"],
                       [NormalDragViewCellData normalDragViewCellDataWithTitle:@"1"],
                       [NormalDragViewCellData normalDragViewCellDataWithTitle:@"2"],
                       [NormalDragViewCellData normalDragViewCellDataWithTitle:@"3"],
                       [NormalDragViewCellData normalDragViewCellDataWithTitle:@"4"],
                       [NormalDragViewCellData normalDragViewCellDataWithTitle:@"5"],
                       [NormalDragViewCellData normalDragViewCellDataWithTitle:@"6"],
                       [NormalDragViewCellData normalDragViewCellDataWithTitle:@"7"]];
    
    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.adapters addObject:[NormalDragViewCell dataAdapterWithData:obj cellHeight:60.f]];
    }];
}

- (void)barButtonItem:(UIBarButtonItem *)item {
    
    if ([item.title isEqualToString:@"Edit"]) {
        
        item.title = @"Done";
        [self.tableView setEditing:YES animated:YES];
        
    } else {
        
        item.title = @"Edit";
        [self.tableView setEditing:NO animated:YES];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 位置0不显示移动标签
    if (indexPath.row == 0) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    // 如果要移动到0位置,则禁止移动
    if (proposedDestinationIndexPath.row == 0) {
        
        return [NSIndexPath indexPathForRow:1 inSection:0];
        
    } else {
        
        return proposedDestinationIndexPath;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    // 移动之后更新数据
    if (sourceIndexPath.row != destinationIndexPath.row) {
        
        CellDataAdapter *object = [self.adapters objectAtIndex:sourceIndexPath.row];
        [self.adapters removeObjectAtIndex:sourceIndexPath.row];
        
        if (destinationIndexPath.row > self.adapters.count) {
            
            [self.adapters addObject:object];
            
        } else {
            
            [self.adapters insertObject:object atIndex:destinationIndexPath.row];
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 不显示删除等状态
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 进入编辑状态时左侧不缩进
    return NO;
}

@end
