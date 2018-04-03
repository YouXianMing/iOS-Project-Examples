//
//  ICloudMetadata.m
//  iCloudDisk
//
//  Created by YouXianMing on 2018/4/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ICloudMetadata.h"

@implementation ICloudMetadata

+ (instancetype)iCloudMetadataWithDictionary:(NSDictionary *)dictionary {
    
    ICloudMetadata *metaData     = [[self class] new];
    metaData.name                = dictionary[NSMetadataItemFSNameKey];
    metaData.itemSize            = [dictionary[NSMetadataItemFSSizeKey] floatValue] / 1024.f;
    metaData.isStoredInTheiCloud = [dictionary[NSMetadataItemIsUbiquitousKey] boolValue];
    
    metaData.creationDate        = dictionary[NSMetadataItemFSCreationDateKey];
    metaData.contentChangeDate   = dictionary[NSMetadataItemFSContentChangeDateKey];
    
    metaData.path                = dictionary[NSMetadataItemPathKey];
    metaData.url                 = dictionary[NSMetadataItemURLKey];
    
    NSString *fileStatus = dictionary[NSMetadataUbiquitousItemDownloadingStatusKey];
    if ([fileStatus isEqualToString:NSMetadataUbiquitousItemDownloadingStatusNotDownloaded]) {
        
        metaData.fileStatus = ICloudMetadataFileStatusNotDownloaded;
        
    } else if ([fileStatus isEqualToString:NSMetadataUbiquitousItemDownloadingStatusDownloaded]) {
        
        metaData.fileStatus = ICloudMetadataFileStatusNotTheLatest;
        
    } else if ([fileStatus isEqualToString:NSMetadataUbiquitousItemDownloadingStatusCurrent]) {
        
        metaData.fileStatus = ICloudMetadataFileStatusCurrent;
    }
    
    metaData.isDownloadingCurrentNow = [dictionary[NSMetadataUbiquitousItemIsDownloadingKey] boolValue];
    metaData.percentDownloaded       = [dictionary[NSMetadataUbiquitousItemPercentDownloadedKey] floatValue];
    
    metaData.isUploadingCurrentNow = [dictionary[NSMetadataUbiquitousItemIsUploadingKey] boolValue];
    metaData.percentUploaded       = [dictionary[NSMetadataUbiquitousItemPercentUploadedKey] floatValue];
    metaData.isUploaded            = [dictionary[NSMetadataUbiquitousItemIsUploadedKey] boolValue];
    
    return metaData;
}

@end
