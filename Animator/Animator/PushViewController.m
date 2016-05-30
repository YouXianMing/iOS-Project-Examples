//
//  PushViewController.m
//  Animator
//
//  Created by YouXianMing on 16/5/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PushViewController.h"
#import "UIView+SetRect.h"
#import "UIColor+Random.h"

typedef enum : NSUInteger {
    
    kPushButton = 1000,
    kPopButton,
    
} EViewControllerViewTag;

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Set backgroundColor.
    self.view.backgroundColor = [UIColor randomColorWithAlpha:1.f];
    
    // Init button.
    [self initButtons];
}

- (void)initButtons {
    
    {
        UIButton *button          = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        button.center             = CGPointMake(self.view.width / 2.f, self.view.height / 4.f);
        button.layer.borderWidth  = 0.5f;
        button.layer.cornerRadius = 4.f;
        button.tag                = kPushButton;
        [self.view addSubview:button];
        
        [button setTitle:@"Push"                                                  forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]                                forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        UIButton *button          = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        button.center             = CGPointMake(self.view.width / 2.f, self.view.height / 4.f * 3);
        button.layer.borderWidth  = 0.5f;
        button.layer.cornerRadius = 4.f;
        button.tag                = kPopButton;
        [self.view addSubview:button];
        
        [button setTitle:@"Pop"                                                   forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]                                forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonEvent:(UIButton *)button {
    
    if (button.tag == kPushButton) {
        
        [self.navigationController pushViewController:[PushViewController new] animated:YES];
        
    } else if (button.tag == kPopButton) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
