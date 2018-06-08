//
//  BltSendModel.h
//  DogGo
//
//  Created by zxc-02 on 16/5/31.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "DailyDataModel.h"

@interface BltSendModel : NSObject

singleton_interface(BltSendModel);
- (void)dataModelFromPerpheralByDay:(UInt8)dayNum ResponseBlock:(void(^)(DailyDataModel *dataModel))responseBlock;
@end
