//
//  TableViewController.m
//  UIDynamicExamples
//
//  Created by YouXianMing on 2017/12/28.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "TableViewController.h"
#import "Item.h"
#import "GravityAndCollisionController.h"
#import "SnapBehaviorController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSArray <Item *> *datas;

@end

@implementation TableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // set title.
    self.title = @"Dynamic";
    
    // register cell.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    // list datas.
    self.datas = @[[self itemWithClass:[GravityAndCollisionController class] title:@"重力行为 + 边界检测"],
                   [self itemWithClass:[SnapBehaviorController        class] title:@"吸附行为"]];
}

- (Item *)itemWithClass:(Class)class title:(NSString *)title {
    
    Item *item           = [Item new];
    item.controllerClass = class;
    item.title           = title;

    return item;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text   = self.datas[indexPath.row].title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *controller = [self.datas[indexPath.row].controllerClass new];
    controller.title             = self.datas[indexPath.row].title;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
