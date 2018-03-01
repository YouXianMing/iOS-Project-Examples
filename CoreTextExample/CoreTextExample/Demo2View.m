//
//  Demo2View.m
//  CoreTextExample
//
//  Created by YouXianMing on 2017/7/19.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "Demo2View.h"
#import <CoreText/CoreText.h>

@interface Demo2View () {
    
    CGRect _pathRect;
    CGRect _nsPathRect;
}

@property (nonatomic, strong) UIView *debug_1_View;
@property (nonatomic, strong) UIView *debug_2_View;

@end

@implementation Demo2View

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width  = 80.f;
        CGFloat height = 30.f;
        _pathRect   = CGRectMake(5, 10, width, height);
        _nsPathRect = CGRectMake(5, self.bounds.size.height - height - 10.f, width, height);
        
//        self.debug_1_View                        = [[UIView alloc] initWithFrame:_pathRect];
//        self.debug_1_View.backgroundColor        = [[UIColor redColor] colorWithAlphaComponent:0.1f];
//        self.debug_1_View.userInteractionEnabled = NO;
//        [self addSubview:self.debug_1_View];
        
        self.debug_2_View                        = [[UIView alloc] initWithFrame:_nsPathRect];
        self.debug_2_View.backgroundColor        = [[UIColor redColor] colorWithAlphaComponent:0.1f];
        self.debug_2_View.userInteractionEnabled = NO;
        [self addSubview:self.debug_2_View];
        
        self.backgroundColor   = [UIColor clearColor];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    // Content
    NSMutableAttributedString *contentAttrString = [[NSMutableAttributedString alloc] initWithString:@"测试测试测试"];
    
    long number = 10;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [contentAttrString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, 4)];
    
    // Context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Rect
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, _pathRect);
    
    // Frame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(contentAttrString));
    CTFrameRef       frame       = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    // CTM transform
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Draw
    CTFrameDraw(frame, context);
    
    // Release
    CFRelease(frame);
    CFRelease(framesetter);
    CFRelease(path);
}

@end
