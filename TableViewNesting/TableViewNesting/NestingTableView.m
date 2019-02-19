//
//  NestingTableView.m
//  TableViewNesting
//
//  Created by YouXianMing on 2019/2/19.
//  Copyright © 2019 YouXianMing. All rights reserved.
//

#import "NestingTableView.h"

@implementation NestingTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    
    // 返回YES，则可以多个手势一起触发方法，返回NO则为互斥
    return YES;
}

@end
