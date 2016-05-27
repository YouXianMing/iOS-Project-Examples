//
//  TextViewController.h
//  DTCoreText
//
//  Created by YouXianMing on 15/6/2.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTAttributedTextView.h"
#import "DTLazyImageView.h"

@interface TextViewController : UIViewController <UIActionSheetDelegate, DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>

@property (nonatomic, strong) NSString *fileName;

@property (nonatomic, strong) NSURL *lastActionLink;

@property (nonatomic, strong) NSURL *baseURL;

@end
