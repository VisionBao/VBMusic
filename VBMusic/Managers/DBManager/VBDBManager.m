//
//  VBDBManager.m
//  VBMusic
//
//  Created by Vision on 15/12/23.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBDBManager.h"
#import "VBFileManager.h"

static NSString *VBFMDbName = @"VBMusic.db.sqlite";

@implementation VBDBManager
+ (id)defaultMgr {
    static VBDBManager *s_dbManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_dbManager = [[VBDBManager alloc] init];
    });
    return s_dbManager;
}
- (id)init {
    self = [super init];
    if (self) {
        NSString *dbPath = [VBFileManager getPathWithType:VBFilePATH_DUCUMENT];
        dbPath = [dbPath stringByAppendingPathComponent:VBFMDbName];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return self;
}
- (FMDatabaseQueue *)fmDabaseQueue {
    return _dbQueue;
}
@end
