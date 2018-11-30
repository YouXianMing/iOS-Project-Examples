//
//  ViewController.m
//  PNGIconsCompressTool
//
//  Created by YouXianMing on 2017/11/7.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "ViewController.h"
#import "PNGManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 获取1024的图片
    UIImage *sourceImage = [UIImage imageNamed:@"new.png"];
    
    // 根据原始图片生成图片
    [PNGManager createPNGsWithSourceImage:sourceImage pngsBlock:^(NSMutableArray<PNG *> *pngs) {
        
        //////////////////////////////////////////////
        //                  iPhone                  //
        //////////////////////////////////////////////
        
        // [60pt] iPhone App iOS 7-11
        {
            NSString *name = @"iPhone App iOS 7-11";
            CGFloat   pt   = 60.f;
            [pngs addObject:[PNG._2x pt:pt name:name]];
            [pngs addObject:[PNG._3x pt:pt name:name]];
        }
        
        // [40pt] iPhone Spotlight iOS 7-11
        {
            NSString *name = @"iPhone Spotlight iOS 7-11";
            CGFloat   pt   = 40.f;
            [pngs addObject:[PNG._2x pt:pt name:name]];
            [pngs addObject:[PNG._3x pt:pt name:name]];
        }
        
        // [29pt] iPhone Settings iOS 5-11
        {
            NSString *name = @"iPhone Settings iOS 5-11";
            CGFloat   pt   = 29.f;
            [pngs addObject:[PNG._2x pt:pt name:name]];
            [pngs addObject:[PNG._3x pt:pt name:name]];
        }
        
        // [20pt] iPhone Notification iOS 7-11
        {
            NSString *name = @"iPhone Notification iOS 7-11";
            CGFloat   pt   = 20.f;
            [pngs addObject:[PNG._2x pt:pt name:name]];
            [pngs addObject:[PNG._3x pt:pt name:name]];
        }
        
        //////////////////////////////////////////////
        //                   iPad                   //
        //////////////////////////////////////////////
        
        // [76pt] iPad App iOS 7-11
        {
            NSString *name = @"iPad App iOS 7-11";
            CGFloat   pt   = 76.f;
            [pngs addObject:[PNG._1x pt:pt name:name]];
            [pngs addObject:[PNG._2x pt:pt name:name]];
        }
        
        // [83.5pt] iPad Pro App iOS 9-11
        {
            NSString *name = @"iPad App iOS 7-11";
            CGFloat   pt   = 83.5f;
            [pngs addObject:[PNG._2x pt:pt name:name]];
        }
        
        // [40pt] iPad Spotlight iOS 7-11
        {
            NSString *name = @"iPad Spotlight iOS 7-11";
            CGFloat   pt   = 40.f;
            [pngs addObject:[PNG._1x pt:pt name:name]];
            [pngs addObject:[PNG._2x pt:pt name:name]];
        }
        
        // [29pt] iPad Settings iOS 5-11
        {
            NSString *name = @"iPad Settings iOS 5-11";
            CGFloat   pt   = 29.f;
            [pngs addObject:[PNG._1x pt:pt name:name]];
            [pngs addObject:[PNG._2x pt:pt name:name]];
        }
        
        // [20pt] iPad Notification iOS 7-11
        {
            NSString *name = @"iPad Notification iOS 7-11";
            CGFloat   pt   = 20.f;
            [pngs addObject:[PNG._1x pt:pt name:name]];
            [pngs addObject:[PNG._2x pt:pt name:name]];
        }
        
        //////////////////////////////////////////////
        //                 App Store                //
        //////////////////////////////////////////////
        
        // [1024pt] App Store iOS
        {
            NSString *name = @"App Store iOS";
            CGFloat   pt   = 1024.f;
            [pngs addObject:[PNG._1x pt:pt name:name]];
        }
    }];
}

@end
