//
//  ICloudMetadataQuery.m
//  iCloudDisk
//
//  Created by YouXianMing on 2018/4/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ICloudMetadataQuery.h"

@interface ICloudMetadataQuery ()

@property (nonatomic, strong) NSMetadataQuery *metadataQuery;

@end

@implementation ICloudMetadataQuery

+ (NSArray *)metaDataAttributes {
    
    return @[NSMetadataItemFSNameKey,
             NSMetadataItemFSSizeKey,
             NSMetadataItemIsUbiquitousKey,
             
             NSMetadataItemFSCreationDateKey,
             NSMetadataItemFSContentChangeDateKey,
             
             NSMetadataItemPathKey,
             NSMetadataItemURLKey,
             
             NSMetadataUbiquitousItemDownloadingStatusKey,
             NSMetadataUbiquitousItemIsDownloadingKey,
             NSMetadataUbiquitousItemPercentDownloadedKey,
             
             NSMetadataUbiquitousItemIsUploadingKey,
             NSMetadataUbiquitousItemPercentUploadedKey,
             NSMetadataUbiquitousItemIsUploadedKey];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.metadataQuery                              = [[NSMetadataQuery alloc] init];
        self.metadataQuery.searchScopes                 = @[NSMetadataQueryUbiquitousDocumentsScope];
        self.metadataQuery.notificationBatchingInterval = 1.f;
        self.metadataQuery.operationQueue               = [NSOperationQueue mainQueue];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didStartGathering:)
                                                     name:NSMetadataQueryDidStartGatheringNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(gatheringProgress:)
                                                     name:NSMetadataQueryGatheringProgressNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didUpdate:)
                                                     name:NSMetadataQueryDidUpdateNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didFinishGathering:)
                                                     name:NSMetadataQueryDidFinishGatheringNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)startQuery {
    
    [self.metadataQuery startQuery];
}

- (void)stopQuery {
    
    [self.metadataQuery stopQuery];
}

- (BOOL)isStarted {
    
    return self.metadataQuery.isStarted;
}

- (BOOL)isGathering {
    
    return self.metadataQuery.isGathering;
}

- (BOOL)isStopped {
    
    return self.metadataQuery.isStopped;
}

- (void)didStartGathering:(NSNotification *)notification {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(iCloudMetadataQueryStartGathering:)]) {
        
        [self.delegate iCloudMetadataQueryStartGathering:self];
    }
}

- (void)gatheringProgress:(NSNotification *)notification {
    
    NSLog(@"%@ %@", notification.name, notification.object);
}

- (void)didUpdate:(NSNotification *)notification {
    
    [self.metadataQuery disableUpdates];
    
    NSMutableArray *datasource = [NSMutableArray array];
    for (NSMetadataItem *item in self.metadataQuery.results) {
        
        NSDictionary   *dic      = [item valuesForAttributes:ICloudMetadataQuery.metaDataAttributes];
        ICloudMetadata *metaData = [ICloudMetadata iCloudMetadataWithDictionary:dic];
        [datasource addObject:metaData];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(iCloudMetadataQueryDidUpdate:iCloudMetadatas:)]) {
        
        [self.delegate iCloudMetadataQueryDidUpdate:self iCloudMetadatas:datasource];
    }
    
    [self.metadataQuery enableUpdates];
}

- (void)didFinishGathering:(NSNotification *)notification {
    
    [self.metadataQuery disableUpdates];
    
    NSMutableArray *datasource = [NSMutableArray array];
    for (NSMetadataItem *item in self.metadataQuery.results) {
        
        NSDictionary   *dic      = [item valuesForAttributes:ICloudMetadataQuery.metaDataAttributes];
        ICloudMetadata *metaData = [ICloudMetadata iCloudMetadataWithDictionary:dic];
        [datasource addObject:metaData];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(iCloudMetadataQueryDidFinishGathering:iCloudMetadatas:)]) {
        
        [self.delegate iCloudMetadataQueryDidFinishGathering:self iCloudMetadatas:datasource];
    }
    
    [self.metadataQuery enableUpdates];
}

- (void)dealloc {
    
    if (self.isStarted || self.isGathering) {
        
        [self stopQuery];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSMetadataQueryDidStartGatheringNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSMetadataQueryDidFinishGatheringNotification object:nil];
}

@end
