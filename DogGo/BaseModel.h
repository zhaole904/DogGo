//
//  BaseModel.h
//  zoneBLT
//
//  Created by obzone on 16/4/10.
//  Copyright © 2016年 obzone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic ,strong) NSData *rawData;

// 如果初始化完成返回yes 
- (BOOL)loadData:(NSData *)data;

@end
