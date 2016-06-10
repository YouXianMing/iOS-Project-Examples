//
//  ParagraphAttribute.m
//  TextCapital
//
//  Created by FrankLiu on 15/8/14.
//  Copyright (c) 2015年 FrankLiu. All rights reserved.
//

#import "ParagraphAttribute.h"

@implementation ParagraphAttribute

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.paragraphStyle = [NSMutableParagraphStyle new];
        self.paragraphStyle.lineSpacing      = 4.f;
        self.paragraphStyle.paragraphSpacing = 10.f;
    }
    return self;
}

- (NSString *)attributeName {
    
    return NSParagraphStyleAttributeName;
}

- (id)attributeValue {
        
    return self.paragraphStyle;
}

@end
