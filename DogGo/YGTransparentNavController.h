//
//  YGTransparentNavController.h
//  导航栏透明效果
//
//  Created by wuyiguang on 16/3/8.
//  Copyright (c) 2016年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGTransparentNavController : UINavigationController

/** 设置导航半透明效果的view */
@property (nonatomic, strong) UIView *transparentView;
@property (nonatomic, strong) UILabel *titleLab;
@end


// 给系统导航添加类别，方便拿到transparentView来改变透明度等操作
//如果扩展方法名和原类名相同，则会覆盖掉原类的方法，这是要注意的，还一个是分类无法扩展类的属性。
@interface UINavigationController (Transparent)

@property (nonatomic, readonly) UIView *transparentView;

@property (nonatomic, readonly) UILabel *titleLab;
@end
