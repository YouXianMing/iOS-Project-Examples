//
//  ViewController.m
//  IrregularElementsCreator
//
//  Created by YouXianMing on 2018/8/17.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SetRect.h"
#import "UIView+DebugFrame.h"
#import "IrregularElementsCreator.h"

@interface ViewController ()

@property (nonatomic, strong) IrregularElementsCreator *creator;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self example_2];
}

- (void)example_1 {
    
    UIView *areaView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, Width - 20.f, 20.f)];
    [areaView showOutlineWithColor:UIColor.blackColor];
    [self.view addSubview:areaView];
    
    self.creator                   = [IrregularElementsCreator new];
    self.creator.isRightToLeft     = NO;
    self.creator.isBottomToTop     = YES;
    self.creator.areaWidth         = areaView.width;
    self.creator.edgeInsets        = UIEdgeInsetsMake(20, 30, 40, 50);
    self.creator.itemHorizontalGap = 10.f;
    self.creator.itemVerticalGap   = 10.f;
    self.creator.itemHeight        = 30.f;
    self.creator.itemWidths        = @[@(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30),
                                       @(arc4random() % 25 + 30)];
    [self.creator startCreateElementsFrames];
    
    areaView.height = self.creator.areaHeight;
    UIView *debugView = [[UIView alloc] initWithFrame:CGRectMake(self.creator.edgeInsets.left,
                                                                 self.creator.edgeInsets.top,
                                                                 areaView.width - self.creator.edgeInsets.left - self.creator.edgeInsets.right,
                                                                 areaView.height - self.creator.edgeInsets.top - self.creator.edgeInsets.bottom)];
    [debugView showRandomColorOutlineAndBackgroundColor];
    [areaView addSubview:debugView];
    
    [self.creator.itemFrames enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *label      = [[UILabel alloc] initWithFrame:obj.CGRectValue];
        label.text          = [NSString stringWithFormat:@"%@", @(idx + 1)];
        label.textAlignment = NSTextAlignmentCenter;
        [label showOutlineWithColor:UIColor.redColor];
        [areaView addSubview:label];
    }];
}

- (void)example_2 {
    
    UIView *areaView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, Width - 20.f, 20.f)];
    [areaView showOutlineWithColor:UIColor.blackColor];
    [self.view addSubview:areaView];
    
    UIEdgeInsets edge = UIEdgeInsetsMake(20, 30, 40, 50);
    
    [IrregularElementsCreator irregularElementsCreatorWithItemIsRightToLeft:NO
                                                              isBottomToTop:NO
                                                                  areaWidth:areaView.width
                                                                 edgeInsets:edge
                                                          itemHorizontalGap:10.f
                                                            itemVerticalGap:10.f
                                                                 itemHeight:30.f
                                                                 itemWidths:@[@(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30),
                                                                              @(arc4random() % 25 + 30)]
                                                                    results:^(CGFloat areaHeight, NSArray<NSValue *> *itemFrames) {
                                                                        
                                                                        areaView.height = areaHeight;
                                                                        
                                                                        UIView *debugView = [[UIView alloc] initWithFrame:CGRectMake(edge.left,
                                                                                                                                     edge.top,
                                                                                                                                     areaView.width - edge.left - edge.right,
                                                                                                                                     areaView.height - edge.top - edge.bottom)];
                                                                        [debugView showRandomColorOutlineAndBackgroundColor];
                                                                        [areaView addSubview:debugView];
                                                                        
                                                                        [itemFrames enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                            
                                                                            UILabel *label      = [[UILabel alloc] initWithFrame:obj.CGRectValue];
                                                                            label.text          = [NSString stringWithFormat:@"%@", @(idx + 1)];
                                                                            label.textAlignment = NSTextAlignmentCenter;
                                                                            [label showOutlineWithColor:UIColor.redColor];
                                                                            [areaView addSubview:label];
                                                                        }];
                                                                    }];
}

@end
