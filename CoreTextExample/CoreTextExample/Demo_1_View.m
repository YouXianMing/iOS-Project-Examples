//
//  CoreText_Examle_1_View.m
//  CoreTextExample
//
//  Created by YouXianMing on 2017/7/20.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "Demo_1_View.h"
#import <CoreText/CoreText.h>

@interface Demo_1_View () {
    
    CGRect          _drawFrame;
    CTFrameRef      _frame;
    NSMutableArray *_CTRunFrames;
}

@end

@implementation Demo_1_View

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.backgroundColor   = [UIColor clearColor];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor redColor].CGColor;
        
        _CTRunFrames = [NSMutableArray array];
        _drawFrame   = [self alignCenterFlipFrame:CGRectMake(5, 5, 85, 75)];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    // Content
    NSMutableAttributedString *contentAttrString = [[NSMutableAttributedString alloc] initWithString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    
    [contentAttrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 8)];
    [contentAttrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor greenColor].CGColor range:NSMakeRange(8, 8)];
    [contentAttrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor blueColor].CGColor range:NSMakeRange(18, 2)];
    
    // Context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Rect
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, _drawFrame); // 按照正常系统给定绘制区域
    
    // Frame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(contentAttrString));
    CTFrameRef       frame       = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, contentAttrString.length), path, NULL);
    _frame = frame;
    
    [self debugFrame:frame context:context];
    
    // CTM transform
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Draw Text
    CTFrameDraw(frame, context);
    
    // 描边draw区域
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetRGBStrokeColor(context, 0, 1, 1, 1.0);
    CGContextStrokeRect(context, _drawFrame); // 在执行了 CTM transform 之后, _drawFrame 相当于在内部做了镜像翻转
    
    // 绘制每个CTRun的边框
    [_CTRunFrames enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect rect = [value CGRectValue];
        
        CGContextSetLineWidth(context, 0.5f);
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1.0);
        CGContextStrokeRect(context, rect); // 在执行了 CTM transform 之后, rect 相当于在内部做了镜像翻转
    }];
    
    // Release
    CFRelease(frame);
    CFRelease(framesetter);
    CFRelease(path);
}

- (void)debugFrame:(CTFrameRef)frame context:(CGContextRef)context {
    
    // 根据frame获取需要绘制的CTLine数组
    NSArray *arrLines = (NSArray *)CTFrameGetLines(frame);
    
    // 获取CTLine的数量
    NSInteger count = [arrLines count];
    
    // CTLine起始点的数组
    CGPoint points[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    
    // 遍历CTLine数组
    for (int coreTextLineIndex = 0; coreTextLineIndex < count; coreTextLineIndex++) {
        
        // 获取CTLine对象
        CTLineRef coreTextLine = (__bridge CTLineRef)arrLines[coreTextLineIndex];
        NSLog(@"\n");
        NSLog(@"%@", NSStringFromCGPoint(points[coreTextLineIndex]));
        
        // 从CTLine中获取CTRun数组
        NSArray * coreTextRunsFromOneLine = (NSArray *)CTLineGetGlyphRuns(coreTextLine);
        
        // 遍历CTRun数组
        for (int coreTextRunIndex = 0; coreTextRunIndex < coreTextRunsFromOneLine.count; coreTextRunIndex++) {
            
            // 获取CTRun对象
            CTRunRef coreTextRun = (__bridge CTRunRef)coreTextRunsFromOneLine[coreTextRunIndex];
            
            // 获取起点
            CGPoint point = points[coreTextLineIndex];
            
            // 定义上距,下距,以及bounds
            CGFloat ascent, descent;
            CGRect coreTextRunBounds;
            
            // 获取CTRun绝对frame(没有任何偏移量)
            coreTextRunBounds.size.width  = CTRunGetTypographicBounds(coreTextRun, CFRangeMake(0, 0), &ascent, &descent, NULL);
            coreTextRunBounds.size.height = ascent + descent;
            CGFloat xOffset = CTLineGetOffsetForStringIndex(coreTextLine, CTRunGetStringRange(coreTextRun).location, NULL);
            coreTextRunBounds.origin.x    = point.x + xOffset;
            coreTextRunBounds.origin.y    = point.y - descent;
            
            // 获取CTRun相对frame(针对内边距调整了下)
            CGPathRef pathRef                   = CTFrameGetPath(frame);
            CGRect    relativeRect              = CGPathGetBoundingBox(pathRef);
            CGRect    relativeCoreTextRunBounds = CGRectOffset(coreTextRunBounds, relativeRect.origin.x, relativeRect.origin.y);
            
            // 存储倒置的frame(倒着的文本的frame)
            [_CTRunFrames addObject:[NSValue valueWithCGRect:relativeCoreTextRunBounds]];
            
            NSLog(@"镜像翻转前的frame : %@", NSStringFromCGRect(relativeCoreTextRunBounds));
            NSLog(@"镜像翻转后的frame : %@", NSStringFromCGRect([self alignCenterFlipFrame:relativeCoreTextRunBounds]));
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch   = [touches anyObject];
    CGPoint location = [self NSPointFromScreenPoint:[touch locationInView:self]];
    NSLog(@"NS坐标点: %@", NSStringFromCGPoint(location));
    NSLog(@"坐标点  : %@", NSStringFromCGPoint([touch locationInView:self]));
    
    [_CTRunFrames enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect rect = [value CGRectValue];
        if ([self isFrame:rect containsPoint:location]) {
            
            NSLog(@"NSFrame %@", NSStringFromCGRect(rect));
            NSLog(@"Frame   %@", NSStringFromCGRect([self alignCenterFlipFrame:rect]));
            *stop = YES;
        }
    }];
}

/*
 * 将正常坐标系的point转换为NS坐标系的point
 */
-(CGPoint)NSPointFromScreenPoint:(CGPoint)origin {
    
    return CGPointMake(origin.x, self.bounds.size.height - origin.y);
}

-(BOOL)isFrame:(CGRect)frame containsPoint:(CGPoint)point {
    
    return CGRectContainsPoint(frame, point);
}

/**
 将frame进行坐标系居中翻转
 
 @param frame 被翻转的frame
 @return 翻转后的frame
 */
- (CGRect)alignCenterFlipFrame:(CGRect)frame {
    
    return CGRectMake(frame.origin.x, self.bounds.size.height - frame.origin.y - frame.size.height, frame.size.width, frame.size.height);
}

@end
