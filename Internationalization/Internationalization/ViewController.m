//
//  ViewController.m
//  Internationalization
//
//  Created by YouXianMing on 16/4/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

#define Localized(key)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Localizable"]

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UILabel *label      = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = [UIColor blackColor];
    label.text          = Localized(@"title");
    [self.view addSubview:label];
}

@end
