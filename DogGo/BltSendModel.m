//
//  BltSendModel.m
//  DogGo
//
//  Created by zxc-02 on 16/5/31.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "BltSendModel.h"
#import "BltTool.h"

@interface BltSendModel ()

@property (nonatomic ,copy) void(^responseDataBlock)(id model);
@end

@implementation BltSendModel
singleton_implementation(BltSendModel);

- (void)dataModelFromPerpheralByDay:(UInt8)dayNum ResponseBlock:(void(^)(DailyDataModel *dataModel))responseBlock{
    self.responseDataBlock = responseBlock;
    
    static DailyDataModel *model;
    model = nil;
    
    UInt8 bytes[20] = {0x10, dayNum};
    
    [[BltTool sharedBltTool] sendRequestWithData:[NSData dataWithBytes:bytes length:20] SuccessCallback:^(NSData *data)  {
        
        if (model == nil) {
            model = [DailyDataModel new];
        }
        
        UInt8 bytes[20] = {0};
        [data getBytes:bytes length:20];
        //        NSDate *date = [[NSDate dateWithTimeIntervalSince1970:(bytes[1] | (bytes[2] << 8) | (bytes[3] << 16) | (bytes[4] << 24))] dateByAddingTimeInterval:-60*60*8];
        
        //        NSCalendar *calendar = [NSCalendar currentCalendar];
        //        NSLog(@"%d",(bytes[1] | (bytes[2] << 8) | (bytes[3] << 16) | (bytes[4] << 24)));
        //        NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle];
        //        NSLog(@"%X,%@,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",bytes[0],dateString,bytes[5],bytes[6],bytes[7],bytes[8],bytes[9],bytes[10],bytes[11],bytes[12],bytes[13],bytes[14],bytes[15],bytes[16],bytes[17],bytes[18],bytes[19]);
        
        if (bytes[0] == 0x90 && bytes[1] == 0xFF) {
            
            if (_responseDataBlock) _responseDataBlock(nil);
             NSLog(@"请求返回错误");
        }
        else if (bytes[0] == 0x90 && bytes[1] == 0X00) {
            
            NSLog(@"请求返回错误");
            
        }else if(bytes[0] == 0x10 || bytes[0] == 0x11){
            
            if (_responseDataBlock && [model loadData:data]) _responseDataBlock(model);
            NSLog(@"_responseDataBlock");
        }
        
    }andErrorCallback:nil];
    
}

@end
