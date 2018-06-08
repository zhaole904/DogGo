//
//  PathModel.m
//  DogGo
//
//  Created by zxc-02 on 16/5/30.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "PathModel.h"

@implementation PathModel
singleton_implementation(PathModel);

+ (NSString *)docPath
{
    return [[PathModel sharedPathModel] docPath] ;
}

- (NSString *)docPath
{
    if ( nil == _docPath )
    {
        _docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    }
    
    return _docPath;
}
@end
