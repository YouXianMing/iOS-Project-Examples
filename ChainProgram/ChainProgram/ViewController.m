//
//  ViewController.m
//  ChainProgram
//
//  Created by YouXianMing on 2017/12/5.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "ViewController.h"
#import "BaseMessageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 1
    BaseMessageView.build.autoHidden.withMessage(@"Hello").showIn(self.view);
    
    // 2
    [BaseMessageView buildMessageView:^(BaseMessageView *messageView) {
        
        messageView.autoHidden.disableContentViewInteraction.showInKeyWindow();
    }];
}

@end
