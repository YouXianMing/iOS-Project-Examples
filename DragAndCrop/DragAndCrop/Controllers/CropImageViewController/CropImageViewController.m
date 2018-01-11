//
//  CropImageViewController.m
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "CropImageViewController.h"

@interface CropImageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView       *scrollViewContentView;
@property (nonatomic, strong) UIButton     *button;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UIImageView  *showImageView;
@property (nonatomic, strong) UIView       *areaView;
@property (nonatomic, strong) UIImageView  *areaShowView;

@end

@implementation CropImageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // Image
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic_%d.png", arc4random() % 2 + 1]];
    
    // ScrollViewContentView
    self.scrollViewContentView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, Width - 20, self.contentView.height * 0.35)];
    [self.scrollViewContentView showRandomColorOutline];
    [self.contentView addSubview:self.scrollViewContentView];
    
    // ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.scrollViewContentView.bounds];
    [self.scrollViewContentView addSubview:self.scrollView];
    
    self.scrollView.delegate         = self;
    self.scrollView.minimumZoomScale = MAX(self.scrollView.width / image.size.width, self.scrollView.height / image.size.height);
    if (self.scrollView.minimumZoomScale <= 1) {
        
        self.scrollView.maximumZoomScale = 4.f;
        
    } else {
        
        self.scrollView.maximumZoomScale = self.scrollView.minimumZoomScale * 4.f;
    }
    
    // RedAreaView
    self.areaView                        = [[UIView alloc] initWithFrame:CGRectMake(35, 20, 75, 150)];
    self.areaView.userInteractionEnabled = NO;
    [self.areaView showRandomColorOutlineAndBackgroundColor];
    [self.scrollViewContentView addSubview:self.areaView];
    
    // ImageView
    self.imageView              = [[UIImageView alloc] initWithImage:image];
    self.scrollView.contentSize = self.imageView.frame.size;
    self.scrollView.zoomScale   = self.scrollView.minimumZoomScale;
    [self.scrollView addSubview:self.imageView];
    
    // button
    self.button                 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame           = CGRectMake(0, 0, Width - 20, 75);
    self.button.titleLabel.font = [UIFont systemFontOfSize:25.f];
    self.button.top             = self.scrollViewContentView.bottom + 10;
    self.button.left            = 10.f;
    [self.button showRandomColorOutline];
    [self.button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:@"裁剪图片" forState:UIControlStateNormal];
    [self.contentView addSubview:self.button];
    
    // ShowImageView
    self.showImageView        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollViewContentView.width * 0.5, self.scrollViewContentView.height * 0.5)];
    self.showImageView.bottom = self.contentView.height - 10.f;
    self.showImageView.left   = 10.f;
    [self.showImageView showRandomColorOutline];
    [self.contentView addSubview:self.showImageView];
    
    // AreaShowView
    self.areaShowView        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.areaView.width * 1.2, self.areaView.height * 1.2)];
    self.areaShowView.right  = Width - 10.f;
    self.areaShowView.bottom = self.contentView.height - 10.f;
    [self.areaShowView showRandomColorOutline];
    [self.contentView addSubview:self.areaShowView];
}

- (void)buttonEvent:(UIButton *)button {
    
    // 截取全部
    {
        CGFloat x      = self.scrollView.contentOffset.x / self.scrollView.zoomScale;
        CGFloat y      = self.scrollView.contentOffset.y / self.scrollView.zoomScale;
        CGFloat width  = self.scrollView.frame.size.width / self.scrollView.zoomScale;
        CGFloat height = self.scrollView.frame.size.height / self.scrollView.zoomScale;
        
        CGImageRef cgImageRef    = CGImageCreateWithImageInRect(self.imageView.image.CGImage, CGRectMake(x, y, width, height));
        UIImage   *cropImage     = [UIImage imageWithCGImage:cgImageRef];
        self.showImageView.image = cropImage;
        
        NSLog(@"=====================");
        NSLog(@"缩放比例         : %.3f",        self.scrollView.zoomScale);
        NSLog(@"contentSize尺寸 : %.f x %.f",   self.scrollView.contentSize.width, self.scrollView.contentSize.height);
        NSLog(@"图片尺寸         : %.f x %.f",   self.imageView.image.size.width, self.imageView.image.size.height);
        NSLog(@"裁剪图片尺寸      : %.f x %.f",   cropImage.size.width, cropImage.size.height);
        NSLog(@"offset         : (%.2f, %.2f)", self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
        NSLog(@"current frame  : (%.2f, %.2f, %.2f, %.2f)", self.scrollView.contentOffset.x, self.scrollView.contentOffset.y, self.scrollView.width, self.scrollView.height);
        NSLog(@"=====================");
    }
    
    // 截取局部
    {
        CGRect rect    = [self.areaView frameFromView:self.scrollViewContentView];
        CGFloat x      = (rect.origin.x + self.scrollView.contentOffset.x) / self.scrollView.zoomScale;
        CGFloat y      = (rect.origin.y + self.scrollView.contentOffset.y) / self.scrollView.zoomScale;
        CGFloat width  = rect.size.width / self.scrollView.zoomScale;
        CGFloat height = rect.size.height / self.scrollView.zoomScale;
        
        CGImageRef cgImageRef   = CGImageCreateWithImageInRect(self.imageView.image.CGImage, CGRectMake(x, y, width, height));
        self.areaShowView.image = [UIImage imageWithCGImage:cgImageRef];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

@end
