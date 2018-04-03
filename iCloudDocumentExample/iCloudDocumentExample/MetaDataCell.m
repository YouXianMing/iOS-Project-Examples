//
//  MetaDataCell.m
//  iCloudDocumentExample
//
//  Created by YouXianMing on 2018/4/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MetaDataCell.h"
#import "ICloudMetadata.h"
#import "UIView+SetRect.h"

@interface MetaDataCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation MetaDataCell

- (void)buildSubview {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 5.f, Width - 10.f, 20.f)];
    [self.contentView addSubview:self.titleLabel];
    
    self.infoLabel               = [[UILabel alloc] init];
    self.infoLabel.numberOfLines = 0;
    self.infoLabel.font          = [UIFont systemFontOfSize:12.f];
    [self.contentView addSubview:self.infoLabel];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:gesture];
}

- (void)longPress:(UILongPressGestureRecognizer *)pressGresture {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:self.data];
    }
}

- (void)loadContent {
    
    ICloudMetadata *data = self.data;
    self.titleLabel.text = [NSString stringWithFormat:@"%@  [%.2fkb]", data.name, data.itemSize];
    
    NSString *fileStatus = nil;
    switch (data.fileStatus) {
            
        case ICloudMetadataFileStatusNotDownloaded:
            fileStatus = @"还没有下载";
            break;
            
        case ICloudMetadataFileStatusNotTheLatest:
            fileStatus = @"不是最新的文件";
            break;
            
        case ICloudMetadataFileStatusCurrent:
            fileStatus = @"最新的文件";
            break;
            
        default:
            break;
    }
    
    NSMutableString *info = [NSMutableString string];
    
    [info appendFormat:@"当前文件是否存在iCloud上:%@\n\n", data.isStoredInTheiCloud ? @"YES" : @"NO"];
    
    [info appendFormat:@"文件状态:%@\n", fileStatus];
    [info appendFormat:@"当前正在下载:%@\n", data.isDownloadingCurrentNow ? @"YES" : @"NO"];
    [info appendFormat:@"下载进度:%.f%%\n\n", data.percentDownloaded];
    
    [info appendFormat:@"是否已经上传:%@\n", data.isUploaded ? @"YES" : @"NO"];
    [info appendFormat:@"当前正在上传:%@\n", data.isUploadingCurrentNow ? @"YES" : @"NO"];
    [info appendFormat:@"上传进度:%.f%%\n", data.percentUploaded];
    
    self.infoLabel.width = Width - 20.f;
    self.infoLabel.left  = 5.f;
    self.infoLabel.top   = self.titleLabel.bottom + 5.f;
    self.infoLabel.text  = info;
    [self.infoLabel sizeToFit];
}

@end
