//
//  ViewController.m
//  DTCoreText
//
//  Created by YouXianMing on 15/6/2.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "TextViewController.h"

#define CELL @"UITableViewCell"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray     *snippets;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self defaultConfig];
    
    [self accessFiles];
    
    [self createTableView];
}

- (void)defaultConfig {
    self.title = @"DTCoreText Example";
}

- (void)accessFiles {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Snippets" ofType:@"plist"];
    self.snippets       = [[NSArray alloc] initWithContentsOfFile:plistPath];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _snippets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell    = [tableView dequeueReusableCellWithIdentifier:CELL];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CELL];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *rowSnippet = [_snippets objectAtIndex:indexPath.row];
    NSString     *fileName   = [rowSnippet objectForKey:@"File"];
    NSString     *title      = [rowSnippet objectForKey:@"Title"];
    
    cell.textLabel.text            = title;
    cell.detailTextLabel.text      = fileName;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *rowSnippet           = [_snippets objectAtIndex:indexPath.row];
    
    TextViewController *viewController = [[TextViewController alloc] init];
    viewController.fileName            = [rowSnippet objectForKey:@"File"];
    viewController.baseURL             = [NSURL URLWithString:[rowSnippet  objectForKey:@"BaseURL"]];
    
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}

@end
