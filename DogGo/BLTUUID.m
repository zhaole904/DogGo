//
//  BLTUUID.m
//  ProductionTest
//
//  Created by zorro on 15-1-16.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import "BLTUUID.h"

@implementation BLTUUID

#pragma mark --- 设备所包含的所有UUID ---
// 服务
+ (CBUUID *)uartServiceUUID
{
//    return [CBUUID UUIDWithString:@"6E500001-B5A3-F393-E0A9-E50E24DCCA9E"];
    return [CBUUID UUIDWithString:@"0x56FF"];
}

// 写 特征
+ (CBUUID *)txCharacteristicUUID
{
//    return [CBUUID UUIDWithString:@"6E500002-B5A3-F393-E0A9-E50E24DCCA9E"];
//    return [CBUUID UUIDWithString:@"0x33F3"];
    return [CBUUID UUIDWithString:@"FFE0"];
}

// 订阅 特征
+ (CBUUID *)rxCharacteristicUUID
{
//    return [CBUUID UUIDWithString:@"6E500003-B5A3-F393-E0A9-E50E24DCCA9E"];
//    return [CBUUID UUIDWithString:@"0x33F4"];
    return [CBUUID UUIDWithString:@"1802"];
}

// 大数据写
+ (CBUUID *)bigDataWriteCharacteristicUUID
{
    return [CBUUID UUIDWithString:@"00000af1-0000-1000-8000-00805f9b34fb"];
}

// 大数据读
+ (CBUUID *)bigDataReadCharacteristicUUID
{
    return [CBUUID UUIDWithString:@"00000af2-0000-1000-8000-00805f9b34fb"];
}

// 硬件绑定的特征
+ (CBUUID *)hardwareRevisionStringUUID
{
    return [CBUUID UUIDWithString:@"2A27"];
}

// 设备信息服务
+ (CBUUID *)deviceInformationServiceUUID
{
    return [CBUUID UUIDWithString:@"180A"];
}

// 升级服务UUID : 00001530-1212-EFDE-1523-785FEABCD123

// 升级时的服务
+ (CBUUID *)updateServiceUUID
{
    return [CBUUID UUIDWithString:@"00001530-1212-EFDE-1523-785FEABCD123"];
}

// 控制中心.
+ (CBUUID *)controlPointCharacteristicUUID
{
    return [CBUUID UUIDWithString:@"00001531-1212-EFDE-1523-785FEABCD123"];
}

// 数据传输特征
+ (CBUUID *)packetCharacteristicUUID
{
    return [CBUUID UUIDWithString:@"00001532-1212-EFDE-1523-785FEABCD123"];
}

// 固件版本特征
+ (CBUUID *)versionCharacteristicUUID
{
    return [CBUUID UUIDWithString:@"00001534-1212-EFDE-1523-785FEABCD123"];
}

+ (NSString *)representativeString:(CBUUID *)uuid
{
    NSData *data = [uuid data];
    NSUInteger bytesToConvert = [data length];
    const unsigned char *uuidBytes = [data bytes];
    NSMutableString *outputString = [NSMutableString stringWithCapacity:16];
    
    for (NSUInteger currentByteIndex = 0; currentByteIndex < bytesToConvert; currentByteIndex++)
    {
        switch (currentByteIndex)
        {
            case 3:
            case 5:
            case 7:
            case 9:[outputString appendFormat:@"%02x-", uuidBytes[currentByteIndex]];
               
                break;
                
            default:[outputString appendFormat:@"%02x", uuidBytes[currentByteIndex]];
        }
        
    }
    
    return outputString;
}


@end
