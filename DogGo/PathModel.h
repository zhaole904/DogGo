//
//  PathModel.h
//  DogGo
//
//  Created by zxc-02 on 16/5/30.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface PathModel : NSObject
singleton_interface(PathModel);

@property (nonatomic, strong) NSString*docPath;
+ (NSString *)docPath;
@end
