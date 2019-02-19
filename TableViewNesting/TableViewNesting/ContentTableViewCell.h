//
//  ContentTableViewCell.h
//  TestTableView
//
//  Created by YouXianMing on 2019/2/18.
//  Copyright © 2019 YouXianMing. All rights reserved.
//

#import "CustomCell.h"
@class ContentTableViewCell;

@protocol ContentTableViewCellDelegate <NSObject>

- (void)contentTableViewCellScrollToTop:(ContentTableViewCell *)cell;

@end

@interface ContentTableViewCell : CustomCell

@property (nonatomic) BOOL tableViewCanMove;

@property (nonatomic, weak) id <ContentTableViewCellDelegate> cellDelegate;

@end
