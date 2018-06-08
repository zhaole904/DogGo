//
//  BackView.h
//  Drawrectview
//
//  Created by zxc-02 on 16/5/12.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackView : UIView
@property (nonatomic, strong) NSArray *textX; //x轴数据个数
@property (nonatomic, strong) NSArray *textY; //y轴数据个数
@property (nonatomic, strong) NSArray *dataArr; //数据
@property (nonatomic, assign) CGFloat maxValue; //y轴最大值

@end
