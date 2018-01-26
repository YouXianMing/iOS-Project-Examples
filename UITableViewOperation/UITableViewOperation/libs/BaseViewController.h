//
//  BaseViewController.h
//  UITableViewOperation
//
//  Created by YouXianMing on 2018/1/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SetRect.h"
#import "UIView+DebugFrame.h"
#import "CustomCell.h"

@interface BaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView                             *contentView;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@end
