//
//  ICloudMetadata.h
//  iCloudDisk
//
//  Created by YouXianMing on 2018/4/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    // 还没有从云端下载到本地iCloud仓库,可以使用startDownloadingUbiquitousItemAtURL:error:下载到本地iCloud仓库
    ICloudMetadataFileStatusNotDownloaded = 1000,
    
    // 本地iCloud仓库不是最新版本的数据,最新版本的数据即将从云端下载
    ICloudMetadataFileStatusNotTheLatest,
    
    // 本地iCloud仓库是最新版本的数据
    ICloudMetadataFileStatusCurrent,
    
} ICloudMetadataFileStatus;

@interface ICloudMetadata : NSObject

/**
 从字典进行初始化

 @param dictionary 字典数据
 @return 对象
 */
+ (instancetype)iCloudMetadataWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSString *name;                // NSMetadataItemFSNameKey        ==>  文件名字
@property (nonatomic) CGFloat           itemSize;            // NSMetadataItemFSSizeKey        ==>  文件大小,以kb计算
@property (nonatomic) BOOL              isStoredInTheiCloud; // NSMetadataItemIsUbiquitousKey  ==>  是否已经存储在iCloud上

@property (nonatomic, strong) NSDate   *creationDate;        // NSMetadataItemFSCreationDateKey       ==>  文件创建时间
@property (nonatomic, strong) NSDate   *contentChangeDate;   // NSMetadataItemFSContentChangeDateKey  ==>  文件最后修改时间

@property (nonatomic, strong) NSString *path;                // NSMetadataItemPathKey  ==>  文件路径
@property (nonatomic, strong) NSURL    *url;                 // NSMetadataItemURLKey   ==>  文件url

@property (nonatomic) ICloudMetadataFileStatus fileStatus;              // NSMetadataUbiquitousItemDownloadingStatusKey  ==>  文件当前状态
@property (nonatomic) BOOL                     isDownloadingCurrentNow; // NSMetadataUbiquitousItemIsDownloadingKey      ==>  当前是不是正在下载
@property (nonatomic) CGFloat                  percentDownloaded;       // NSMetadataUbiquitousItemPercentDownloadedKey  ==>  下载百分比 [0 - 100]

@property (nonatomic) BOOL                     isUploaded;            // NSMetadataUbiquitousItemIsUploadedKey       ==>  是否已经上传到云端
@property (nonatomic) BOOL                     isUploadingCurrentNow; // NSMetadataUbiquitousItemIsUploadingKey      ==>  当前是不是正在上传
@property (nonatomic) CGFloat                  percentUploaded;       // NSMetadataUbiquitousItemPercentUploadedKey  ==>  上传百分比 [0 - 100]


@end
