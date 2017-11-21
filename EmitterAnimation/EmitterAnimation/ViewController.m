//
//  ViewController.m
//  EmitterAnimation
//
//  Created by YouXianMing on 2017/11/20.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SetRect.h"

typedef enum : NSUInteger {
    
    kEmitterMode = 1000,
    kEmitterShape,
    
} EValue;

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    CAEmitterLayer *_emitter;
    NSArray *_modes;
    NSArray *_shapes;
}

@end

static NSArray *s_modes;
static NSArray *s_shapes;

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _modes  = @[kCAEmitterLayerPoints, kCAEmitterLayerOutline, kCAEmitterLayerSurface, kCAEmitterLayerVolume];
    _shapes = @[kCAEmitterLayerPoint, kCAEmitterLayerLine, kCAEmitterLayerRectangle, kCAEmitterLayerCuboid, kCAEmitterLayerCircle, kCAEmitterLayerSphere];
    
    UIView *contentView           = [[UIView alloc] initWithFrame:CGRectMake(15, 15, Width - 30, Width - 30)];
    contentView.layer.borderWidth = 2.f;
    contentView.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5f].CGColor;
    contentView.top               = 20.f;
    [self.view addSubview:contentView];
    
    // 例子layer
    _emitter = [CAEmitterLayer layer];
    [contentView.layer addSublayer:_emitter];
    
    // 给定尺寸 + 显示边框
    _emitter.frame       = CGRectMake(0, 0, 200, 200);
    _emitter.position    = contentView.middlePoint;
    _emitter.borderWidth = 2.f;
    _emitter.borderColor = [[UIColor greenColor] colorWithAlphaComponent:0.5f].CGColor;
    
    // 发射模式
    _emitter.emitterMode = _modes[0];
    
    // 设置发射的区域
    _emitter.emitterSize = CGSizeMake(100, 100);
    
    // 发射位置(emitterSize的中心位置)
    _emitter.emitterPosition = CGPointMake(_emitter.frame.size.width / 2.f, _emitter.frame.size.height / 2.f);
    
    // 发射形状
    _emitter.emitterShape = _shapes[0];
    
    // 超出范围不显示
    // emitter.masksToBounds = YES;
    
    _emitter.shadowOpacity = 1.0;
    _emitter.shadowRadius  = 0.0;
    _emitter.shadowOffset  = CGSizeMake(0.0, 0.0);
    
    // 粒子边缘的颜色
    _emitter.shadowColor  = [[UIColor blackColor] CGColor];
    
    // Debug用
    {
        CALayer *layer        = [CALayer layer];
        layer.frame           = CGRectMake(0, 0, _emitter.emitterSize.width, _emitter.emitterSize.height);
        layer.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25].CGColor;
        layer.position        = _emitter.emitterPosition;
        [_emitter addSublayer:layer];
        
        UIPickerView *modePickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, Width / 2.f, 162.f)];
        modePickView.delegate      = self;
        modePickView.dataSource    = self;
        modePickView.tag           = kEmitterMode;
        modePickView.bottom        = Height;
        [self.view addSubview:modePickView];
        
        UIPickerView *shapePickView = [[UIPickerView alloc] initWithFrame:CGRectMake(Width / 2.f, 0, Width / 2.f, 162.f)];
        shapePickView.delegate      = self;
        shapePickView.dataSource    = self;
        shapePickView.tag           = kEmitterShape;
        shapePickView.bottom        = Height;
        [self.view addSubview:shapePickView];
    }
    
    ////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////
    
    // 创建雪花类型的粒子
    CAEmitterCell *snowflake    = [CAEmitterCell emitterCell];
    
    // 粒子的名字
    snowflake.name = @"snow";
    
    // 粒子参数的速度乘数因子
    snowflake.birthRate = 120.f;
    snowflake.lifetime  = 0.85f;
    
    // 粒子速度
    snowflake.velocity  = 10.0;
    
    // 粒子的速度范围
    snowflake.velocityRange = 10;
    
    // 粒子y方向的加速度分量
    snowflake.yAcceleration = 8;
    
    // 周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;
    
    // 子旋转角度范围
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents  = (id)[[UIImage imageNamed:@"snow"] CGImage];
    
    // 设置雪花形状的粒子的颜色
    snowflake.color      = [[UIColor whiteColor] CGColor];
    snowflake.redRange   = 2.f;
    snowflake.greenRange = 2.f;
    snowflake.blueRange  = 2.f;
    
    snowflake.scaleRange = 0.6f;
    snowflake.scale      = 0.7f;
    
    // 添加粒子
    _emitter.emitterCells = @[snowflake];
}

#pragma mark - UIPickerViewDelegate & UIPickerViewDataSource.

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSInteger number = 0;
    
    if (pickerView.tag == kEmitterMode) {
        
        return _modes.count;
        
    } else if (pickerView.tag == kEmitterShape) {
        
        return _shapes.count;
    }
    
    return number;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title = nil;
    
    if (pickerView.tag == kEmitterMode) {
        
        title = _modes[row];
        
    } else if (pickerView.tag == kEmitterShape) {
        
        title = _shapes[row];
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView.tag == kEmitterMode) {
        
        _emitter.emitterMode = _modes[row];
        
    } else if (pickerView.tag == kEmitterShape) {
        
        _emitter.emitterShape = _shapes[row];
    }
}

@end
