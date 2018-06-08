//
//  BltTool.h
//  DogGo
//
//  Created by zxc-02 on 16/5/25.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "Singleton.h"
@interface BltTool : NSObject
singleton_interface(BltTool);

typedef enum{
    STATUS_DISCONNECTED = 0, //断开连接
    STATUS_CONNECTING = 1,   //连接中
    STATUS_CONNECTED = 2,    //已连接
    STATUS_UPDATEPER = 3     //扫描到外设

}STATUS;

typedef enum {
    BLTUpdateDataTypeNormalData = 0,        // 普通数据
    BLTUpdateDataTypeBigData = 1,           // 大数据
    BLTUpdateDataTypeTransFail = 2          // 信息传输失败.
    
} BLTUpdateDataType;


typedef void(^BLTPeripheralUpdateData)(NSData *data, BLTUpdateDataType type);
@property (nonatomic, strong) BLTPeripheralUpdateData updateDataBlock;



typedef void(^statusBlock)(CBPeripheral *per,STATUS status);
typedef void(^valueBlock)(CBPeripheral *per,CBCharacteristic *cha,NSNumber *RSSI);
@property (nonatomic, strong) CBPeripheral *per;
@property (nonatomic, strong) NSMutableDictionary *allPer;
@property (nonatomic, copy) statusBlock statusBlock;
@property (nonatomic, strong) valueBlock valueBlock;

@property (nonatomic ,copy) void(^requestSuccessCallback)(NSData *responseData);         // 请求成功回调
@property (nonatomic ,copy) void(^requestFailedCallback)(NSError *error);                // 请求失败回调

@property (nonatomic, strong) CBCharacteristic *tCharacteristic;

- (void)startScaning;
- (void)stopScaning;

- (void)connectingDecice:(NSString *)UUID;
- (void)cancelPeripheralConnection;

- (void)sendDataToPeripheral:(NSData *)data;

- (void)sendRequestWithData:(NSData *)data SuccessCallback:(void(^)(NSData *data))successBlock andErrorCallback:(void(^)(NSError *))errorBlock;
@end
