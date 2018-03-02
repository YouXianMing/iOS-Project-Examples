//
//  ViewController.m
//  CoreTextExample
//
//  Created by YouXianMing on 2017/7/19.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ViewController.h"
#import "CellData.h"
#import "Demo_1_ViewController.h"
#import "Demo_2_ViewController.h"
#import "Demo_3_ViewController.h"
#import "Demo_4_ViewController.h"
#import "Demo_5_ViewController.h"
#import "Demo_6_ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <CellData *> *datas;
@property (nonatomic, strong) UITableView          *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.datas = @[[CellData cellDataWithControllerClass:Demo_1_ViewController.class title:@"Demo_1"],
                   [CellData cellDataWithControllerClass:Demo_2_ViewController.class title:@"Demo_2"],
                   [CellData cellDataWithControllerClass:Demo_3_ViewController.class title:@"Demo_3"],
                   [CellData cellDataWithControllerClass:Demo_4_ViewController.class title:@"Demo_4"],
                   [CellData cellDataWithControllerClass:Demo_5_ViewController.class title:@"Demo_5"],
                   [CellData cellDataWithControllerClass:Demo_6_ViewController.class title:@"Demo_6"]];
    
    self.tableView            = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.rowHeight  = 50.f;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    CellData        *data = self.datas[indexPath.row];
    cell.textLabel.text   = data.title;
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellData *data = self.datas[indexPath.row];
    
    BaseViewController *controller = [data.controllerClass new];
    controller.title               = data.title;
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
