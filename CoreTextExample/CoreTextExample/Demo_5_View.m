//
//  CoreTextView.m
//  CoreTextExampleVer2
//
//  Created by YouXianMing on 2018/3/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Demo_5_View.h"
#import <CoreText/CoreText.h>
#import "NSAttributedString+LabelWidthAndHeight.h"

@interface Demo_5_View () {
    
    CGRect _drawFrame;
}

@end

@implementation Demo_5_View

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor redColor].CGColor;
        
        _drawFrame = [self alignCenterFlipFrame:CGRectMake(20, 5, self.bounds.size.width - 40, 238.00)];
    }
    
    return self;
}

- (CTParagraphStyleRef) paragraphStyle {
    
    CTTextAlignment alignment   = kCTTextAlignmentLeft; // 对齐方式
    CGFloat minLineSpacing      = 20;                   // 最小行间距
    CGFloat maxLineSpacing      = 20;                   // 最大行间距
    CGFloat paragraphSpacing    = 30;                   // 段落间距
    CGFloat firstLineHeadIndent = 60;                   // 首行缩进
    CGFloat headIndent          = 30;                   // 行缩进
    
    CTParagraphStyleSetting paragraphSettings[] = {
        
        {kCTParagraphStyleSpecifierAlignment,           sizeof(alignment), &alignment},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,  sizeof(minLineSpacing), &minLineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,  sizeof(maxLineSpacing), &maxLineSpacing},
        {kCTParagraphStyleSpecifierParagraphSpacing,    sizeof(paragraphSpacing), &paragraphSpacing},
        {kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(firstLineHeadIndent), &firstLineHeadIndent},
        {kCTParagraphStyleSpecifierHeadIndent,          sizeof(headIndent), &headIndent},
    };
    
    return CTParagraphStyleCreate(paragraphSettings, 6);
}

- (void)drawRect:(CGRect)rect {
    
//    [self characterAttribute];
    
    NSDictionary *attributes = @{
                                 (id)kCTForegroundColorAttributeName : (id)[UIColor redColor].CGColor,                                              // 字体颜色
                                 (id)kCTFontAttributeName            : (__bridge id)CTFontCreateWithName(CFSTR("PingFangSC-Ultralight"), 40, NULL), // 字体类型
                                 (id)kCTParagraphStyleAttributeName  : (id)[self paragraphStyle],                                                   // 段落样式
                                 
                                 (id)kCTUnderlineStyleAttributeName  : (id)[NSNumber numberWithInt:kCTUnderlineStyleDouble], // 下划线
                                 (id)kCTUnderlineColorAttributeName  : (id)[UIColor greenColor].CGColor,                     // 下划线颜色
                                 };
    
    NSAttributedString *contentAttrString = [[NSAttributedString alloc] initWithString:@"ABCDEFGH\nIJKLMNOPQRSTUVWXUVWXYZ"
                                                                            attributes:attributes];
    

    NSLog(@"%.2f", [contentAttrString coreTextHeightWithFixedWidth:_drawFrame.size.width]); // 计算coreText文本的高度
    
    // Context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Rect
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, _drawFrame); // 按照正常系统给定绘制区域
    
    // Frame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(contentAttrString));
    CTFrameRef       frame       = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, contentAttrString.length), path, NULL);
    
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
    
    // Release
    CFRelease(frame);
    CFRelease(framesetter);
    CFRelease(path);
}

-(void)characterAttribute
{
    NSString *str = @"This is a test of characterAttribute. 中文字符";
    NSMutableAttributedString *mabstring = [[NSMutableAttributedString alloc]initWithString:str];
    
    [mabstring beginEditing];
    /*
     long number = 1;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [mabstring addAttribute:(id)kCTCharacterShapeAttributeName value:(id)num range:NSMakeRange(0, 4)];
     */
    /*
     //设置字体属性
     CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 40, NULL);
     [mabstring addAttribute:(id)kCTFontAttributeName value:(id)font range:NSMakeRange(0, 4)];
     */
    /*
     //设置字体简隔 eg:test
     long number = 10;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [mabstring addAttribute:(id)kCTKernAttributeName value:(id)num range:NSMakeRange(10, 4)];
     */
    
    /*
     long number = 1;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [mabstring addAttribute:(id)kCTLigatureAttributeName value:(id)num range:NSMakeRange(0, [str length])];
     */
    /*
     //设置字体颜色
     [mabstring addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 9)];
     */
    /*
     //设置字体颜色为前影色
     CFBooleanRef flag = kCFBooleanTrue;
     [mabstring addAttribute:(id)kCTForegroundColorFromContextAttributeName value:(id)flag range:NSMakeRange(5, 10)];
     */
    
    /*
     //设置空心字
     long number = 2;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [mabstring addAttribute:(id)kCTStrokeWidthAttributeName value:(id)num range:NSMakeRange(0, [str length])];
     
     //设置空心字颜色
     [mabstring addAttribute:(id)kCTStrokeColorAttributeName value:(id)[UIColor greenColor].CGColor range:NSMakeRange(0, [str length])];
     */
    
    /*
     long number = 1;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [mabstring addAttribute:(id)kCTSuperscriptAttributeName value:(id)num range:NSMakeRange(3, 1)];
     */
    
    /*
     //设置斜体字
     CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 14, NULL);
     [mabstring addAttribute:(id)kCTFontAttributeName value:(id)font range:NSMakeRange(0, 4)];
     */
    
    /*
     //下划线
     [mabstring addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] range:NSMakeRange(0, 4)];
     //下划线颜色
     [mabstring addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 4)];
     */
    
    
    
    //对同一段字体进行多属性设置
    //红色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(id)[UIColor redColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
    //斜体
    CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 40, NULL);
    [attributes setObject:(__bridge id)font forKey:(id)kCTFontAttributeName];
    //下划线
    [attributes setObject:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] forKey:(id)kCTUnderlineStyleAttributeName];
    
    [mabstring addAttributes:attributes range:NSMakeRange(0, 4)];
    
    
    
    NSRange kk = NSMakeRange(0, 4);
    
    NSDictionary * dc = [mabstring attributesAtIndex:0 effectiveRange:&kk];
    
    [mabstring endEditing];
    
    NSLog(@"value = %@",dc);
    
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mabstring);
    
    CGMutablePathRef Path = CGPathCreateMutable();
    
    CGPathAddRect(Path, NULL ,CGRectMake(10 , 0 ,self.bounds.size.width-10 , self.bounds.size.height-10));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    //获取当前(View)上下文以便于之后的绘画，这个是一个离屏。
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    
    //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
    CGContextSaveGState(context);
    
    //x，y轴方向移动
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    CTFrameDraw(frame,context);
    
    CGPathRelease(Path);
    CFRelease(framesetter);
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
