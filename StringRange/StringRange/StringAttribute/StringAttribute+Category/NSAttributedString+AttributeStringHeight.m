//
//  NSAttributedString+AttributeStringHeight.m
//  TextCapital
//
//  Created by FrankLiu on 15/10/8.
//  Copyright © 2015年 FrankLiu. All rights reserved.
//

#import "NSAttributedString+AttributeStringHeight.h"

@implementation NSAttributedString (AttributeStringHeight)

- (CGFloat)attributeStringHeightWithWidth:(CGFloat)width {

    CGFloat height = 0;
    
    if (self.length > 0) {
        
        CGSize rectSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                               options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin
                                               context:nil].size;
        
        height = rectSize.height;
    }
    
    return height;
    
}

@end
