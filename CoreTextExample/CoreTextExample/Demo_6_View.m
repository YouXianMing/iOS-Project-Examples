//
//  TextDrawView.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/3/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Demo_6_View.h"
#import "UIView+SetRect.h"
#import <CoreText/CoreText.h>

@interface Demo_6_View () {
    
    CGRect _drawFrame;
    UIImageView *_imageView;
}

@end

@implementation Demo_6_View

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor clearColor];
        _imageView           = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
        
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [[UIColor whiteColor] set];
        CGContextFillRect(context, rect);
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextTranslateCTM(context, 0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"iOS程序在启动时会创建一个主线程，而在一个线程只能执行一件事情，如果在主线程执行某些耗时操作，例如加载网络图片，下载资源文件等会阻塞主线程（导致界面卡死，无法交互），所以就需要使用多线程技术来避免这类情况。iOS中有三种多线程技术 NSThread，NSOperation，GCD，这三种技术是随着IOS发展引入的，抽象层次由低到高，使用也越来越简单。"];
        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 0, rect.size.width, rect.size.height));
        [[UIColor redColor]set];
        CGContextFillEllipseInRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attrString length]), path, NULL);
        CTFrameDraw(frame, context);
        CFRelease(frame);
        CFRelease(path);
        CFRelease(frameSetter);
        CGContextSetTextMatrix(context,CGAffineTransformIdentity);
        CGContextTranslateCTM(context, 0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _imageView.image = img;
        });
    });
}

@end
