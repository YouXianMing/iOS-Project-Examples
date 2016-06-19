//
//  ViewController.m
//  SetRect
//
//  Created by YouXianMing on 16/6/19.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "UIView+FrameAndTag.h"
#import "UIView+SetRect.h"
#import "UIImageView+FrameAndTag.h"
#import "UILabel+FrameAndTag.h"

typedef enum : NSUInteger {
    
    kCancheView = 1000,
    kTextView,
    
    kArrowImageView,
    
} EViewControllerTag;

@interface ViewController () <AccessViewTagProtocol>

@property (nonatomic, strong) NSMapTable <NSString *, UIView *> *viewsWeakMap;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.viewsWeakMap = [NSMapTable strongToWeakObjectsMapTable];
    
    // 设置框
    [UIView viewWithFrame:CGRectMake(0, 0, Width, 50) insertIntoView:self.view tag:kCancheView attachedTo:self
               setupBlock:^(UIView *whiteView) {
                   
                   whiteView.top = 100;
                   
                   UIColor *grayColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
                   UIColor *textColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
                   
                   // 图片
                   [UIImageView insertIntoView:whiteView tag:kArrowImageView attachedTo:whiteView imageNamed:@"next" setupBlock:^(UIView *view) {
                       
                       view.right   = whiteView.width - 15.f;
                       view.centerY = whiteView.middleY;
                   }];
                   
                   // 清空缓存
                   [UILabel oneLineLeftAlignmentLabelInsertIntoView:whiteView text:@"清空缓存" font:nil textColor:textColor setupBlock:^(UIView *view) {
                       
                       view.left = 15.f;
                   }];
                   
                   // 缓存大小
                   [UILabel oneLineRightAlignmentLabelInsertIntoView:whiteView text:@"123.53 M" font:nil textColor:textColor setupBlock:^(UIView *view) {
                       
                       UIImageView *imageView = viewFrom(whiteView, kArrowImageView);
                       view.right             = imageView.left - 15.f;
                   }];
                   
                   // 设置线条
                   [UIView lineViewInsertIntoView:whiteView positionY:0.f thick:0.5f leftGap:0 rightGap:0 color:grayColor];
                   [UIView lineViewInsertIntoView:whiteView positionY:whiteView.height - 0.5f thick:0.5f leftGap:0 rightGap:0 color:grayColor];
               }];
    
    // 文本内容
    [UIView viewWithFrame:CGRectMake(0, 0, Width, 100) insertIntoView:self.view tag:kTextView attachedTo:self
               setupBlock:^(UIView *whiteView) {
                   
                   UIColor *grayColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
                   UIColor *textColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
                   
                   UIView *cacheView = viewFrom(self, kCancheView);
                   whiteView.top     = cacheView.bottom + 10;
                   
                   [UILabel oneLineCenterAlignmentLabelInsertIntoView:whiteView positionY:10 height:30 text:@"文本标题"
                                                                 font:nil textColor:textColor setupBlock:^(UIView *view) {
                                                                     
                                                                     whiteView.height = view.bottom + 10.f;
                                                                 }];
                   
                   // 设置线条
                   [UIView lineViewInsertIntoView:whiteView positionY:0.f thick:0.5f leftGap:0 rightGap:0 color:grayColor];
                   [UIView lineViewInsertIntoView:whiteView positionY:whiteView.height - 0.5f thick:0.5f leftGap:0 rightGap:0 color:grayColor];
               }];
}

#pragma mark - AccessViewTagProtocol

- (void)setView:(UIView *)view withTag:(NSInteger)tag {
    
    [_viewsWeakMap setObject:view forKey:@(tag).stringValue];
}

- (id)viewWithTag:(NSInteger)tag {
    
    return [_viewsWeakMap objectForKey:@(tag).stringValue];
}

- (void)removeReferenceWithTag:(NSInteger)tag {
    
    [_viewsWeakMap removeObjectForKey:@(tag).stringValue];
}

@end
