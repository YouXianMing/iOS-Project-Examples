//
//  ListViewController.m
//  AutoLayoutExample
//
//  Created by YouXianMing on 2017/7/7.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ListViewController.h"
#import "ListItem.h"
#import "FlowLayoutViewController.h"
#import "GridLayoutViewController.h"
#import "ComplexGridLayoutViewController.h"
#import "LineLayoutViewController.h"

@interface ListViewController ()

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16.f]};
    
    // https://oleb.net/blog/2014/03/how-i-learned-to-stop-worrying-and-love-auto-layout/
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.datas                = [NSMutableArray array];
    self.tableView.rowHeight  = 60.f;
    
    [self.datas addObject:[ListItem listItemWithClassName:[FlowLayoutViewController   class]      title:@"系统Layout布局"]];
    [self.datas addObject:[ListItem listItemWithClassName:[GridLayoutViewController class]        title:@"GridLayout布局"]];
    [self.datas addObject:[ListItem listItemWithClassName:[ComplexGridLayoutViewController class] title:@"完全的GridLayout布局"]];
    [self.datas addObject:[ListItem listItemWithClassName:[LineLayoutViewController class]        title:@"LineLayout布局"]];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell                           = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle            = UITableViewCellSelectionStyleNone;
        cell.accessoryType             = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    
    // 赋值
    ListItem *item            = self.datas[indexPath.row];
    cell.textLabel.text       = item.title;
    cell.detailTextLabel.text = NSStringFromClass(item.className);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListItem         *item       = self.datas[indexPath.row];
    UIViewController *controller = [item.className new];
    controller.title             = item.title;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
