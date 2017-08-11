//
//  ViewController.m
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ViewController.h"
#import "MathSort.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    showArray([MathSort selectionSort:randomsValues(8)]);
    showArray([MathSort bubbleSort:randomsValues(8)]);
}

@end


