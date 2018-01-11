//
//  BaseViewController.h
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SetRect.h"
#import "UIView+DebugFrame.h"
#import "UIView+ConvertRect.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *contentView;

@end
