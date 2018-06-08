//
//  UIView+Simple.m
//  DogGo
//
//  Created by zxc-02 on 16/5/24.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "UIView+Simple.h"

@implementation UIView (Simple)

+ (UIView *)initWithFrame:(CGRect)frame Image:(NSString *)name text:(NSString *)text
{
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height - 15;
    UIView *view = [[UIView alloc]  initWithFrame:frame];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7.5, w/2.0-5, h)];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.image = [[UIImage imageNamed:name]imageWithGradientTintColor:[UIColor grayColor]];
    [view addSubview:imageV];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageV.frame), 7.5, w/2.0, h)];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    
    return view;
}

@end
