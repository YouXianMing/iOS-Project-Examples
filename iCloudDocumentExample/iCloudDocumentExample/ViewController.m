//
//  ViewController.m
//  iCloudDocumentExample
//
//  Created by YouXianMing on 2018/4/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "MetaDataCell.h"
#import "ICloudManager.h"
#import "ICloudMetadataQuery.h"
#import "ICloudDocument.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, ICloudMetadataQueryDelegate, CustomCellDelegate>

@property (nonatomic, strong) NSArray                            *pics;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic, strong) ICloudMetadataQuery *metaDataQuery;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"iCloudDocumentExample";
    
    self.pics = @[@"1.png", @"2.jpg", @"3.jpeg", @"4.jpeg", @"5.jpg", @"6.jpeg"];
    
    // 添加按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addPicture)];
    
    // tabelView
    self.tableView            = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.rowHeight  = 170.f;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // cells
    [MetaDataCell registerToTableView:self.tableView];
    
    // ICloud
    if (ICloudManager.iCloudEnable) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getiCloudURLInfo:) name:NSGetiCloudURLInfoNotification object:nil];
        [ICloudManager startGetiCloudURL];
    }
}

- (void)addPicture {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加内容" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction     *addAction       = [UIAlertAction actionWithTitle:@"随机添加一张图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSData         *data      = [NSData dataWithContentsOfURL:[NSBundle.mainBundle.resourceURL URLByAppendingPathComponent:self.pics[arc4random() % self.pics.count]]];
        NSString       *name      = [[[NSProcessInfo processInfo] globallyUniqueString] componentsSeparatedByString:@"-"].lastObject;
        NSURL          *iCloudUrl = [ICloudManager documentsFileUrlWithFileName:name];
        ICloudDocument *document  = [[ICloudDocument alloc] initWithFileURL:iCloudUrl];
        document.data             = data;

        [document saveToURL:iCloudUrl forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {

            if (success) {

                NSLog(@"创建成功!");
            }
        }];
    }];

    [alertController addAction:addAction];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)getiCloudURLInfo:(NSNotification *)notification {
 
    if ([notification.name isEqualToString:NSGetiCloudURLInfoNotification]) {
        
        NSLog(@"%@", ICloudManager.iCloudURL.path);
        NSLog(@"%@", [ICloudManager documentsFileUrlWithFileName:@"1.png"]);
        
        // iCloud确实可用
        if ([notification.object boolValue] == YES) {
            
            self.metaDataQuery          = [ICloudMetadataQuery new];
            self.metaDataQuery.delegate = self;
            [self.metaDataQuery startQuery];
        }
    }
}

#pragma mark - ICloudMetadataQueryDelegate

- (void)iCloudMetadataQueryStartGathering:(ICloudMetadataQuery *)metadataQuery {
    
    NSLog(@"start gathering");
}

- (void)iCloudMetadataQueryDidFinishGathering:(ICloudMetadataQuery *)metadataQuery iCloudMetadatas:(NSArray <ICloudMetadata *> *)iCloudMetadatas {
    
    NSLog(@"did gathering");
    
    NSMutableArray *adapters = [NSMutableArray array];
    
    [iCloudMetadatas enumerateObjectsUsingBlock:^(ICloudMetadata * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [adapters addObject:[MetaDataCell dataAdapterWithData:obj]];
    }];
    
    self.adapters = adapters;
    [self.tableView reloadData];
}

- (void)iCloudMetadataQueryDidUpdate:(ICloudMetadataQuery *)metadataQuery iCloudMetadatas:(NSArray <ICloudMetadata *> *)iCloudMetadatas {
    
    NSLog(@"update gathering");
    
    NSMutableArray *adapters = [NSMutableArray array];
    
    [iCloudMetadatas enumerateObjectsUsingBlock:^(ICloudMetadata * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [adapters addObject:[MetaDataCell dataAdapterWithData:obj]];
    }];
    
    self.adapters = adapters;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.adapters[indexPath.row];
    CustomCell      *cell    = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.indexPath           = indexPath;
    cell.dataAdapter         = adapter;
    cell.delegate            = self;
    cell.data                = adapter.data;
    [cell loadContent];
    
    return cell;
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    
    ICloudMetadata *metaData = event;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加内容" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *replaceAction = [UIAlertAction actionWithTitle:@"替换图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSData         *data      = [NSData dataWithContentsOfURL:[NSBundle.mainBundle.resourceURL URLByAppendingPathComponent:self.pics[arc4random() % self.pics.count]]];
        ICloudDocument *document  = [[ICloudDocument alloc] initWithFileURL:metaData.url];
        document.data             = data;
        
        [document saveToURL:metaData.url forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
            
            if (success) {
                
                NSLog(@"保存成功!");
            }
        }];
    }];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([[NSFileManager defaultManager] removeItemAtURL:metaData.url error:nil]) {
            
            NSLog(@"删除成功!");
        }
    }];
    
    UIAlertAction *readAction = [UIAlertAction actionWithTitle:@"读取图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ICloudDocument *document  = [[ICloudDocument alloc] initWithFileURL:metaData.url];
        [document openWithCompletionHandler:^(BOOL success) {
            
            if (success) {
                
                NSLog(@"读取成功!");
            }
        }];
    }];
    
    [alertController addAction:replaceAction];
    [alertController addAction:deleteAction];
    [alertController addAction:readAction];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
