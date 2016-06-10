//
//  UnderlineStyleAttribute.m
//  ZiPeiYi
//
//  Created by FrankLiu on 15/12/22.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "UnderlineStyleAttribute.h"

@implementation UnderlineStyleAttribute

- (NSString *)attributeName {
    
    return NSUnderlineStyleAttributeName;
}

- (id)attributeValue {
    
    if (self.number) {
        
        return self.number;
        
    } else {
        
        return @1;
    }
}

@end
