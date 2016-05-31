//
//  ViewController.m
//  FMDB-Example
//
//  Created by YouXianMing on 16/5/31.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "FileManager.h"
#import "NSDictionary+JSONData.h"
#import "NSData+JSONData.h"

#import "FMDB.h"
#import "SQLTable.h"
#import "SQLInsert.h"
#import "SQLUpdate.h"
#import "SQLDelete.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString   *dbPath = filePath(@"~/Documents/fmdb.db");
    FMDatabase *db     = [FMDatabase databaseWithPath:dbPath];
    
    if ([db open]) {
        
        // Create Table.
        SQLTable *table = sqlTable(@"Infomation", ^(NSMutableArray<SQLDataType *> *dataTypes) {
            
            // age [Int], data [Blob], name [Text].
            [dataTypes addObject:sqlDataType(kIntegerType, @"age")];
            [dataTypes addObject:sqlDataType(kBlobType,    @"data")];
            [dataTypes addObject:sqlDataType(kTextType,    @"name")];
        });
        
        NSLog(@"%@", table);
        [db executeStatements:table.sqlString];
        
        // Insert data to table.
        [self insertDataToTable:table db:db];
        
        // Update data to table.
//        [self updateDataToTable:table db:db];
        
        // Delete data from table.
//                [self deleteDataFromTable:table db:db];
        
        // Query data from table.
        [self queryFromTable:table db:db];
        
        [db close];
    }
}

- (void)insertDataToTable:(SQLTable *)table db:(FMDatabase *)db {
    
    NSDictionary *dic = @{@"A" : @"B"};
    NSString     *sql = [SQLInsert insertIntoTable:table set:@[@"data", @"age", @"name"]];
    NSLog(@"%@", sql);
    
    [db executeUpdate:sql, [dic toJSONData], @(arc4random() % 1000), @"YouXianMing"];
}

- (void)updateDataToTable:(SQLTable *)table db:(FMDatabase *)db {
    
    NSString *sql = [SQLUpdate updateTable:table
                                     where:@{@"name" : @"YouXianMing"}
                                       set:@[@"name"]];
    NSLog(@"%@", sql);
    
    [db executeUpdate:sql, @"Good"];
}

- (void)deleteDataFromTable:(SQLTable *)table db:(FMDatabase *)db {
    
    NSString *sql = [SQLDelete deleteTable:table where:@{@"name" : @"YouXianMing"}];
    NSLog(@"%@", sql);
    
    [db executeUpdate:sql];
}

- (void)queryFromTable:(SQLTable *)table db:(FMDatabase *)db {
    
    NSString    *sql = [NSString stringWithFormat:@"SELECT * FROM %@", table.tableName];
    NSLog(@"%@", sql);
    
    FMResultSet *results = [db executeQuery:sql];
    while (results.next) {
        
        NSLog(@"name -> %@  age -> %d", [results stringForColumn:@"name"], [results intForColumn:@"age"]);
        NSLog(@"%@", [[results dataForColumn:@"data"] toListProperty]);
    }
}

@end
