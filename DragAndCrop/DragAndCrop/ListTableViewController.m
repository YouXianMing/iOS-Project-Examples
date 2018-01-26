//
//  ListTableViewController.m
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListTableViewModel.h"
#import "DragViewController.h"
#import "DragViewVer2ViewController.h"
#import "DragAndResizeVer1ViewController.h"
#import "DragAndResizeVer2ViewController.h"
#import "DragAndResizeVer3ViewController.h"
#import "DragAndResizeVer4ViewController.h"
#import "DragAndResizeVer5ViewController.h"
#import "DragAndResizeVer6ViewController.h"
#import "DragAndResizeVer7ViewController.h"
#import "CropImageViewController.h"

@interface ListTableViewController ()

@property (nonatomic, strong) NSArray <ListTableViewModel *> *models;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title  = @"DragAndCrop";
    self.models = @[[ListTableViewModel modelWithClass:[DragViewController class]              title:@"Pan手势移动view"],
                    [ListTableViewModel modelWithClass:[DragViewVer2ViewController class]      title:@"矩形"],
                    [ListTableViewModel modelWithClass:[DragAndResizeVer1ViewController class] title:@"Pan手势改变frame 随意比例"],
                    [ListTableViewModel modelWithClass:[DragAndResizeVer2ViewController class] title:@"Pan手势改变frame (1:1)"],
                    [ListTableViewModel modelWithClass:[DragAndResizeVer3ViewController class] title:@"Pan手势改变frame (2:1)"],
                    [ListTableViewModel modelWithClass:[DragAndResizeVer4ViewController class] title:@"Pan手势改变frame (2:1) 不超边界"],
                    [ListTableViewModel modelWithClass:[DragAndResizeVer5ViewController class] title:@"Pan手势改变frame 随意比例 不超外部边界(拖拽会超出)"],
                    [ListTableViewModel modelWithClass:[DragAndResizeVer6ViewController class] title:@"Pan手势改变frame 随意比例 不超外部边界(拖拽不会超出)"],
                    [ListTableViewModel modelWithClass:[DragAndResizeVer7ViewController class] title:@"Pan手势改变frame (1:1) 不超外部边界(拖拽不会超出)"],
                    [ListTableViewModel modelWithClass:[CropImageViewController class]         title:@"UIScrollView图片裁剪"],
                    ];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.models.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell    *cell  = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.accessoryType        = UITableViewCellAccessoryDisclosureIndicator;
    ListTableViewModel *model = self.models[indexPath.row];
    cell.textLabel.font       = [UIFont systemFontOfSize:12.f];
    cell.textLabel.text       = model.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    [self.navigationController pushViewController:[self.models[indexPath.row].controllerClass new] animated:YES];
}

@end
