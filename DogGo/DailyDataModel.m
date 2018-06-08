//
//  DailyDataModel.m
//  zoneBLT
//
//  Created by obzone on 16/4/11.
//  Copyright © 2016年 obzone. All rights reserved.
//

#import "DailyDataModel.h"
#import "LKDBHelper.h"

@implementation MetaDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _data = [NSMutableArray new];
    }
    return self;
}

@end

@implementation DailyDataModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _data = [NSMutableArray new];
        
    }
    return self;
}

- (BOOL)loadData:(NSData *)data{
    
    UInt8 bytes[20] = {0};
    [data getBytes:bytes length:20];
    
    if (bytes[0] != 0x10 && bytes[0] != 0x11) return NO;
    
    MetaDataModel *metaData = [MetaDataModel new];
    metaData.timestamp = bytes[1] | (bytes[2] << 8) | (bytes[3] << 16) | (bytes[4] << 24);
    metaData.dataType = bytes[0];
    for (int i = 4 ; i < 20 ; i ++) {
        
        [metaData.data addObject:@(bytes[i])];
        
    }
    [_data addObject:metaData];
    
    if (_data.count == 96){
        
        [self saveToDB];
        //TODO 保存数据库
        return YES;
        
    }
    return NO;
    
}



@end
