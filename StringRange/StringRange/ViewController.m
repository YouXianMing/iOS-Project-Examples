//
//  ViewController.m
//  StringRange
//
//  Created by YouXianMing on 16/6/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Range.h"
#import "StringAttributeHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Init string.
    NSString *string = @"当楼主发布了什么内容，回复全都是“楼主辛苦了，感谢楼主，楼主好人，楼主一生平安！”？\
    \n\n1. 复习资料\n2. 种子\n3. 杂志扫图\n4. 英语模拟题";
    NSMutableAttributedString *richString = [[NSMutableAttributedString alloc] initWithString:string];
    
    // Init Attributes.
    FontAttribute *fontAttribute = [FontAttribute new];
    fontAttribute.font           = [UIFont fontWithName:@"Heiti SC" size:18];
    fontAttribute.effectRange    = NSMakeRange(0, string.length);
    [richString addStringAttribute:fontAttribute];
    
    ForegroundColorAttribute *foregroundColorAttribute = [ForegroundColorAttribute new];
    foregroundColorAttribute.color                     = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
    foregroundColorAttribute.effectRange               = NSMakeRange(0, string.length);
    [richString addStringAttribute:foregroundColorAttribute];
    
    // Get the ranges from the string.
    [[string rangesOfString:@"楼主" options:0 serachRange:NSMakeRange(0, string.length)]
     enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
         ForegroundColorAttribute *foregroundColorAttribute = [ForegroundColorAttribute new];
         foregroundColorAttribute.color                     = [[UIColor redColor] colorWithAlphaComponent:0.75f];
         foregroundColorAttribute.effectRange               = [obj rangeValue];
         [richString addStringAttribute:foregroundColorAttribute];
    }] ;
    
    // Init label.
    UILabel *label       = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 0)];
    label.attributedText = richString;
    label.center         = self.view.center;
    label.numberOfLines  = 0;
    [label sizeToFit];
    [self.view addSubview:label];
}

@end
