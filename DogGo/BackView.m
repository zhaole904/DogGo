//
//  BackView.m
//  Drawrectview
//
//  Created by zxc-02 on 16/5/12.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "BackView.h"
#define size (self.bounds.size)
#define yNum _textY.count  //y轴数据个数
#define xNum _textX.count  //x轴数据个数
@implementation BackView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
  
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    [self drawFillRectangle:context];
}


- (void)drawFillRectangle:(CGContextRef)context
{
    //绘x轴及y轴上的文字
    CGFloat h = (size.height-20)/yNum;
    for (int i = 0; i < yNum; i ++) {
  
        CGContextMoveToPoint(context, 30, h-1 + i*h);
        
        CGContextAddLineToPoint(context, size.width-20, h-1 + i*h);
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextStrokePath(context);
        
        NSString *text = _textY[i];
//        if (i == _textY.count-1) {
//            [text drawAtPoint:CGPointMake(12, i*h+h-7) withAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:12]}];
//        }else {
            [text drawAtPoint:CGPointMake(0, i*h) withAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor], NSFontAttributeName:[UIFont systemFontOfSize:12]}];
//        }
    }
    
    //绘y轴
    CGContextMoveToPoint(context, 30, yNum*h);
    CGContextAddLineToPoint(context, 30, 0);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokePath(context);
    
    //绘x轴的文字及矩形
    CGFloat x = (size.width)/xNum;
    CGFloat scale = (size.height - 20)/_maxValue;  //数据对应坐标值的比例
    for (int i = 0; i < xNum; i ++) {
        NSString *text = _textX[i];
        [text drawAtPoint:CGPointMake(x*i+20, yNum*h) withAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor], NSFontAttributeName:[UIFont systemFontOfSize:12.0]}];
        
        [[UIColor greenColor] setFill];
        CGFloat data = [_dataArr[i] floatValue];
        CGContextFillRect(context, CGRectMake(x*i+20, yNum*h, 20, -data*scale));
        CGContextStrokePath(context);
        
        //标示data值
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x*i+20-5, (size.height-20)-data*scale-15, 30, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:9.0];
        label.text = _dataArr[i];
        [self addSubview:label];
    }
}


@end
