//
//  BLTUUID.h
//  ProductionTest
//
//  Created by zorro on 15-1-16.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
// 服务 0x6e400001-b5a3-f393-e0a9-e50e24dcca9e
// 写 0X6E400002-B5A3-F393-E0A9-E50E24DCCA9E
// NOTIFY 0X6E400003-B5A3-F393-E0A9-E50E24DCCA9E
@interface BLTUUID : NSObject

+ (CBUUID *)uartServiceUUID;
+ (CBUUID *)txCharacteristicUUID;
+ (CBUUID *)rxCharacteristicUUID;
+ (CBUUID *)hardwareRevisionStringUUID;
+ (CBUUID *)deviceInformationServiceUUID;

// 大数据写
+ (CBUUID *)bigDataWriteCharacteristicUUID;

// 大数据读
+ (CBUUID *)bigDataReadCharacteristicUUID;

// 升级时的服务.
+ (CBUUID *)updateServiceUUID;
// 控制中心.
+ (CBUUID *)controlPointCharacteristicUUID;
// 数据传输通道.
+ (CBUUID *)packetCharacteristicUUID;
// 固件版本特征
+ (CBUUID *)versionCharacteristicUUID;
// uuid 转字符串.
+ (NSString *)representativeString:(CBUUID *)uuid;

@end
