//
//  YGTransparentNavController.m
//  导航栏透明效果
//
//  Created by wuyiguang on 16/3/8.
//  Copyright (c) 2016年 YG. All rights reserved.
//

#import "YGTransparentNavController.h"

@interface YGTransparentNavController ()

@end

@implementation YGTransparentNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 创建透明图片
    UIImage *image = [self transparentImageWithSize:CGSizeMake(1, 1)];
    
    // 2. 设置导航背景图片
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    // 3. 创建自定义透明的view
    self.transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, -21, self.navigationBar.bounds.size.width, 65)];
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.titleLab.center = CGPointMake(self.transparentView.center.x, self.transparentView.center.y+32);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.tag = 5006;
    [self.transparentView addSubview:self.titleLab];
    // tag
    self.transparentView.tag = 5005;
    
    // 4. 添加到导航栏上
    [self.navigationBar insertSubview:self.transparentView atIndex:0];
    
    // 隐藏导航栏底部分割线
    // 1. 创建全透明的UIImage
    // 2. 创建空的UIImage
    self.navigationBar.shadowImage = [[UIImage alloc] init];
}

/**
 *  获取透明图片
 *
 *  @param size 图片的大小
 *
 *  @return UIImage
 */

- (UIImage *)transparentImageWithSize:(CGSize)size
{
    /**
     创建一个基于位图的上下文
     size: 图片的大小
     opaque: 当为NO时全透明
     scale: 缩放因子，0 ~ 1.0
     */
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


@implementation UINavigationController (Transparent)

- (UIView *)transparentView
{
    // 判断是不是自定义的导航
    if ([self isKindOfClass:[YGTransparentNavController class]]) {
        return [self.navigationBar viewWithTag:5005];
    }
    return nil;
}

- (UILabel *)titleLab
{
    if ([self isKindOfClass:[YGTransparentNavController class]]) {
        return [self.transparentView viewWithTag:5006];
    }
    return nil;
}
@end


