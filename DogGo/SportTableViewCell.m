//
//  SportTableViewCell.m
//  DogGo
//
//  Created by zxc-02 on 16/5/24.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "SportTableViewCell.h"
#import "UIView+Simple.h"
#import "BackView.h"

@implementation SportTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self getcell];
    }
    return self;
}

- (void)getcell
{
    CGFloat w = SCREEN_W;
    CGFloat h = 45;
    UIView *view1 = [UIView initWithFrame:CGRectMake(5, 0, w / 3.0, h) Image:@"ic_steps" text:@"0步"];
    UIView *view2 = [UIView initWithFrame:CGRectMake(5+w / 3.0, 0, w / 3.0, h) Image:@"ic_location" text:@"0km"];
    UIView *view3 = [UIView initWithFrame:CGRectMake(10+w / 3.0 * 2, 0, w / 3.0, h) Image:@"ic_clock" text:@"0h"];
    
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    backV.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:backV];
    [backV addSubview:view1];
    [backV addSubview:view2];
    [backV addSubview:view3];
    
    BackView *backView = [[BackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backV.frame), w, SCREEN_H - 64 - h - 49)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.textX = @[@"0",@"4",@"8",@"12",@"16",@"20",@"24"];
    backView.textY = @[@"4000",@"3200",@"2400",@"1600",@"800"];
    backView.dataArr = @[@"1000",@"1600",@"3300",@"2100",@"800",@"3000",@"3900"];
    backView.maxValue = 4000.0;
    [self.contentView addSubview:backView];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
