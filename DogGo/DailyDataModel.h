//
//  DailyDataModel.h
//  zoneBLT
//
//  Created by obzone on 16/4/11.
//  Copyright © 2016年 obzone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface MetaDataModel : NSObject

@property (nonatomic ,assign)uint timestamp; // 每小时中每个15分钟时间段开始的时间戳
@property (nonatomic ,assign)NSInteger dataType; // 数据类型 10代表运动 11代表睡眠
@property (nonatomic ,strong)NSMutableArray<NSNumber *> *data; // 15个值，每15分钟中的每一分钟的运动或者睡眠的值
@property (nonatomic ,copy)NSString *macAddress; // 硬件设备的mac地址

@end

// ######################################################

@interface DailyDataModel : BaseModel

@property (nonatomic ,strong)NSMutableArray<MetaDataModel *> *data; // 96个值，一天分成95个15分钟，每15分钟是一个MetaDataModel类型
@property (nonatomic ,strong)NSDate *date; // 当天日期

@end
