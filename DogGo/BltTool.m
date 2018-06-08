//
//  BltTool.m
//  DogGo
//
//  Created by zxc-02 on 16/5/25.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "BltTool.h"
#import "PerModel.h"
#import "BLTUUID.h"
#define lastConnectedDevice @"lastConnectedDevice"  // 用于缓存最后一次连接的设备ID的字符串key
#define lastConnectedDeviceUUIDString [[NSUserDefaults standardUserDefaults] objectForKey:lastConnectedDevice]

@interface BltTool ()<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    NSMutableDictionary *_characteristics;
    NSTimer *_rssiTimer;
    NSTimer *_scanTimer;
}
@property (nonatomic, strong) CBCentralManager *manager;

@property (nonatomic, strong) NSMutableData *receiveData;
@end

@implementation BltTool
singleton_implementation(BltTool);

- (instancetype)init
{
    if (self = [super init]) {
        if (_manager == nil) {
            _manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }
    if (_allPer == nil) {
        _allPer = [[NSMutableDictionary alloc] init];
        _characteristics = [[NSMutableDictionary alloc] init];
        _receiveData = [[NSMutableData alloc] init];
    }
    
    
    
    
    }
    return self;
}

#pragma mark 扫描外设
- (void)startScaning
{
    [_manager stopScan];
    [_manager scanForPeripheralsWithServices:nil options:nil];
  
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_scanTimer) {
            [_scanTimer invalidate];
            _scanTimer = nil;
        }
        _scanTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(newStart:) userInfo:nil repeats:YES];
    });
}

- (void)newStart:(NSTimer *)timer
{
    
    if (_scanTimer) {
        [timer invalidate];
        timer = nil;
        [self startScaning];
    }
}

#pragma mark 停止扫描
- (void)stopScaning
{
    [_manager stopScan];
    if (_per && _per.state == CBPeripheralStateConnected) {
        [_manager cancelPeripheralConnection:_per];
         _per = nil;
    }
}

#pragma mark 必须实现的代理方法
- (void)centralManagerDidUpdateState:(CBCentralManager *)central;
{
    
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"CBCentralManagerStatePoweredOn");
            [_manager scanForPeripheralsWithServices:nil options:nil];
            break;
            
        case CBCentralManagerStatePoweredOff:
            NSLog(@"CBCentralManagerStatePoweredOff");
            break;
            
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict{ // 系统唤起程序后执行方法
    
    _manager = central;
    _manager.delegate = self;
    
}

#pragma mark 发现外设，存储信息
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    PerModel *model = [[PerModel alloc] init];
    model.per = peripheral;
    model.RSSI = RSSI;
    [self.allPer setObject:model forKey:peripheral.identifier.UUIDString];
    [_manager connectPeripheral:peripheral options:nil];
   
    if (self.statusBlock) {
        self.statusBlock(peripheral,STATUS_UPDATEPER);
    }

    
    
//    过滤
//    if ([peripheral.name hasPrefix:@"Get"] && (ABS(RSSI.integerValue) > 40)) {
//     [_manager connectPeripheral:peripheral options:nil];
//    }
  
//    NSLog(@"%s, line = %d,central = %@,peripheral = %@",__func__,__LINE__,central,peripheral);
}

#pragma mark 取消连接
//- (void)cancelPeripheralConnection
//{
//    [_manager cancelPeripheralConnection:_per];
//    _per = nil;
//}

#pragma mark 连接中
//- (void)connectingDecice:(NSString *)UUID
//{
//    PerModel *model = self.allPer[UUID];
//    CBPeripheral *per = model.per;
//    [_manager connectPeripheral:per options:nil];
//}

#pragma mark 已连接
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    _per = peripheral;
    if (self.statusBlock) {
        self.statusBlock(peripheral,STATUS_CONNECTED);
    }
    _per.delegate = self;
    
    //触发--didDiscoverServices:
    [_per discoverServices:@[[BLTUUID uartServiceUUID]]];

    [[NSUserDefaults standardUserDefaults] setObject:peripheral.identifier.UUIDString forKey:lastConnectedDevice];
NSLog(@"didConnectPeripheral");
    
}

#pragma mark 断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if (error) {
        NSLog(@"didDisconnectPeripheral--%@",error.localizedDescription);
        return;
    }else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:lastConnectedDevice];
         _per = nil;
        
        NSLog(@"didDisconnectPeripheral");
    }
}

#pragma mark 连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if (error) {
        NSLog(@"didFailToConnectPeripheral--%@",error.localizedDescription);
        return;
    }
    NSLog(@"didFailToConnectPeripheral");
}


#pragma mark 查找服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        NSLog(@"%d--%@",__LINE__,error.localizedDescription);
        return;
    }
    
    for (CBService *service in peripheral.services) {
//        [_per discoverCharacteristics:nil forService:service];
        if ([service.UUID.UUIDString isEqualToString:[BLTUUID uartServiceUUID].UUIDString]) {
            
            [peripheral discoverCharacteristics:@[[BLTUUID txCharacteristicUUID], [BLTUUID rxCharacteristicUUID]] forService:service];
            
        }
        

    }
}

#pragma mark 查找特征并发射出去
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(nonnull CBService *)service error:(nullable NSError *)error
{
    if (error) {
        NSLog(@"%d--%@",__LINE__,error.localizedDescription);
        return;
    }
    
    for (CBCharacteristic *charact in service.characteristics) {
        [_characteristics setObject:charact forKey:charact.UUID.UUIDString];
//        [_per readValueForCharacteristic:charact];
     
        if ([charact.UUID.UUIDString isEqualToString:[BLTUUID txCharacteristicUUID].UUIDString]) {
            self.tCharacteristic = charact;
            NSLog(@"223 %@",charact);
        }else if ([charact.UUID.UUIDString isEqualToString:[BLTUUID rxCharacteristicUUID].UUIDString]) {
            // 外设为特征订阅通知 数据会进入
            [peripheral setNotifyValue:YES forCharacteristic:charact];
            
    }
    }
}

#pragma mark 更新通知状态，读取特征
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"通知蓝牙数据更新失败");
        return;
    }
    
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"WriteValueForCharacteristic更新失败");
        return;
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error
{
    if (self.valueBlock) {
        self.valueBlock(peripheral,nil,RSSI);
    }
    
    PerModel *model = [[PerModel alloc] init];
    model.per = peripheral;
    model.RSSI = RSSI;
    [_allPer setObject:model forKey:peripheral.identifier.UUIDString];
    
}


#pragma mark writeData
//- (BOOL)characteristicUUID:(NSString *)UUID writeData:(NSData *)data
//{
//    CBCharacteristic *charca = [_characteristics objectForKey:UUID];
//    if (charca) {
//        [_per writeValue:data forCharacteristic:charca type:CBCharacteristicWriteWithResponse];
//        return YES;
//    }
//    
//    return NO;
//}

#pragma mark readData
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    
    NSLog(@"didUpdateValueForCharacteristic --- %@",characteristic.value);
    
    
    if (error) {
        
        if (_requestFailedCallback) _requestFailedCallback(error);
        
    }
    else{
        
        if (_requestSuccessCallback) _requestSuccessCallback(characteristic.value);
        
    }

}


- (void)sendRequestWithData:(NSData *)data SuccessCallback:(void(^)(NSData *data))successBlock andErrorCallback:(void(^)(NSError *))errorBlock{
    
    self.requestSuccessCallback = successBlock;
    self.requestFailedCallback = errorBlock;
    
    [_per writeValue:data forCharacteristic:_tCharacteristic type:CBCharacteristicWriteWithResponse];
    
}


// 匹配相应的服务
- (CBService *)searchServiceFromUUID:(CBUUID *)uuid withPeripheral:(CBPeripheral *)peripheral
{
    for (CBService *service in peripheral.services) {
        if ([service.UUID isEqual:uuid]) {
            return service;
        }
    }
    return  nil;
}

// 匹配相应的具体特征
- (CBCharacteristic *)searchCharacteristcFromUUID:(CBUUID *)uuid withService:(CBService *)service
{
    for (CBCharacteristic *chara in service.characteristics) {
        if ([chara.UUID isEqual:uuid]) {
            return chara;
        }
    }
    
    return nil;
}

@end
