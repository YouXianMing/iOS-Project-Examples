//
//  AddOrMoveOrDeleteViewController.m
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "AddOrMoveOrDeleteViewController.h"
#import "AddOrMoveOrDeleteCellData.h"
#import "AddOrMoveOrDeleteCell.h"
#import "AddTableViewCell.h"
#import "TitleCell.h"
#import "GCD.h"

@interface AddOrMoveOrDeleteViewController ()

@end

@implementation AddOrMoveOrDeleteViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // BarButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"移动"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(editButtonItem:)];
    
    [AddOrMoveOrDeleteCell registerToTableView:self.tableView];
    [AddTableViewCell      registerToTableView:self.tableView];
    [TitleCell             registerToTableView:self.tableView];

    // title
    [self.adapters addObject:[TitleCell dataAdapterWithData:nil cellHeight:100.f]];
    
    // data
    NSArray *strings = @[@"段落1"];
    [strings enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [self.adapters addObject:[AddOrMoveOrDeleteCell dataAdapterWithData:[self dataWithString:string] cellHeight:60.f]];
    }];
    
    // add add cells.
    [self addAddCells];
}

- (void)addAddCells {

    NSInteger totalCount          = self.adapters.count;
    NSMutableArray *addCellsArray = [NSMutableArray array];
    
    for (int i = 0; i < totalCount; i++) {
        
        [self.adapters insertObject:[AddTableViewCell dataAdapterWithData:nil cellHeight:30.f] atIndex:2 * i + 1];
        [addCellsArray addObject:[NSIndexPath indexPathForRow:2 * i + 1 inSection:0]];
    }
    
    [self.tableView insertRowsAtIndexPaths:addCellsArray withRowAnimation:UITableViewRowAnimationFade];
}

- (void)removeAddCells {
    
    NSMutableIndexSet *indexSet    = [NSMutableIndexSet indexSet];
    NSMutableArray    *deleteArray = [NSMutableArray array];
    
    [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if ([obj.cellReuseIdentifier isEqualToString:NSStringFromClass([AddTableViewCell class])]) {
            
            [indexSet addIndex:idx];
            [deleteArray addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
        }
    }];
    
    [self.adapters removeObjectsAtIndexes:indexSet];
    [self.tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationFade];
}

- (AddOrMoveOrDeleteCellData *)dataWithString:(NSString *)string {
    
    return [AddOrMoveOrDeleteCellData addOrMoveOrDeleteCellDataWithTitle:string];
}

- (void)editButtonItem:(UIBarButtonItem *)item {
    
    if ([item.title isEqualToString:@"移动"]) {
        
        item.enabled = NO;
        item.title   = @"移动中";
        [self removeAddCells];
        
        [GCDQueue executeInMainQueue:^{
        
            [self.tableView setEditing:YES animated:YES];
            
        } afterDelaySecs:0.5];
        
        [GCDQueue executeInMainQueue:^{
            
            item.enabled = YES;
            
        } afterDelaySecs:1.f];
        
    } else {
        
        item.enabled = NO;
        item.title   = @"移动";
        [self.tableView setEditing:NO animated:YES];
        
        [GCDQueue executeInMainQueue:^{
            
            [self addAddCells];
            
        } afterDelaySecs:0.5];
        
        [GCDQueue executeInMainQueue:^{
            
            item.enabled = YES;
            
        } afterDelaySecs:1.f];
    }
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    
    if ([cell isKindOfClass:[AddTableViewCell class]]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        NSString *title = [NSString stringWithFormat:@"段落 - %d", arc4random() % 1000 + 50];
        [self.adapters insertObject:[AddOrMoveOrDeleteCell dataAdapterWithData:[self dataWithString:title] cellHeight:60.f]
                            atIndex:indexPath.row];
        [self.adapters insertObject:[AddTableViewCell dataAdapterWithData:nil cellHeight:30.f]
                            atIndex:indexPath.row];
        
        NSMutableArray *addCellsArray = [NSMutableArray array];
        [addCellsArray addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        [addCellsArray addObject:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
        
        [self.tableView insertRowsAtIndexPaths:addCellsArray withRowAnimation:UITableViewRowAnimationFade];
        
    } else if ([cell isKindOfClass:[AddOrMoveOrDeleteCell class]]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];        
        [indexSet addIndex:indexPath.row - 1];
        [indexSet addIndex:indexPath.row];
        [self.adapters removeObjectsAtIndexes:indexSet];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0],
                                                 [NSIndexPath indexPathForRow:indexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
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
