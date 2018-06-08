//
//  PerModel.h
//  DogGo
//
//  Created by zxc-02 on 16/5/25.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface PerModel : NSObject
@property (nonatomic, strong) CBPeripheral *per;
@property (nonatomic, strong) NSNumber *RSSI;
@end
