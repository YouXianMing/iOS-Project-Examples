//
//  ICloudMetadataQuery.h
//  iCloudDisk
//
//  Created by YouXianMing on 2018/4/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICloudMetadata.h"
@class ICloudMetadataQuery;

@protocol ICloudMetadataQueryDelegate <NSObject>

@optional

- (void)iCloudMetadataQueryStartGathering:(ICloudMetadataQuery *)metadataQuery;

- (void)iCloudMetadataQueryDidFinishGathering:(ICloudMetadataQuery *)metadataQuery iCloudMetadatas:(NSArray <ICloudMetadata *> *)iCloudMetadatas;

- (void)iCloudMetadataQueryDidUpdate:(ICloudMetadataQuery *)metadataQuery iCloudMetadatas:(NSArray <ICloudMetadata *> *)iCloudMetadatas;

@end

@interface ICloudMetadataQuery : NSObject

@property (nonatomic, weak) id <ICloudMetadataQueryDelegate> delegate;

- (void)startQuery;
- (void)stopQuery; // 在收集数据进行当中进行stop操作,不会触发iCloudMetadataQueryDidFinishGathering:iCloudMetadatas:方法

@property (readonly, getter=isStarted) BOOL started;
@property (readonly, getter=isGathering) BOOL gathering;
@property (readonly, getter=isStopped) BOOL stopped;

@end
