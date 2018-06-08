//
//  PZViewController.m
//  DogGo
//
//  Created by zxc-02 on 16/5/24.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "PZViewController.h"
#import "UIImage+MJ.h"
#import "YGTransparentNavController.h"
#import "PushViewController.h"

#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kImageHeight 200

@interface PZViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CGFloat _p;
}
@property (nonatomic, strong) UIImageView *scaleImage;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YGTransparentNavController *ygNavigationController;
@property (nonatomic, strong) UIView *backBarView;
@end

@implementation PZViewController

- (instancetype)init
{
    if (self = [super init])
    {
       
        self.tabBarItem.title = @"配置";
        self.tabBarItem.image = [[UIImage imageNamed:@"ic_config_check"]imageWithGradientTintColor:[UIColor grayColor]];
        
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_config_check"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    [self.view addSubview:self.tableView];
    
    [self.tableView insertSubview:self.scaleImage atIndex:0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(kImageHeight, 0, 0, 0);

    self.navigationController.transparentView.backgroundColor = [UIColor greenColor];
    self.navigationController.titleLab.text = @"配置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置毛玻璃效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];

    UIVisualEffectView *visalView = [[UIVisualEffectView alloc] initWithEffect:blur];

    visalView.frame = self.scaleImage.bounds;

    // 将毛玻璃效果添加到对应的View上
    [self.scaleImage addSubview:visalView];

    
//    self.backBarView = [self.navigationController.navigationBar viewWithTag:5005];
//    self.backBarView.backgroundColor = [UIColor greenColor];
//    [self scrollViewDidScroll:_tableView];
   

}

// 缩放的图片
- (UIImageView *)scaleImage
{
    if (!_scaleImage) {
        
        _scaleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kImageHeight, kScreenSize.width, kImageHeight)];
        _scaleImage.image = [UIImage imageNamed:@"001.jpg"];
        _scaleImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _scaleImage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"%f", offsetY);
    
    // 修改导航的透明度
    // 计算透明值
    _p = (offsetY + kImageHeight) / (kImageHeight-64);
    self.navigationController.transparentView.alpha = _p;
//    [self setValue:@(p) forKeyPath:@"_titleLable.alpha"];
    // 缩放图片
    if (offsetY < -kImageHeight) {
        
        // 缩放系数
        CGFloat s = 0.01;
        CGFloat scale = (-offsetY - kImageHeight) * s;
        self.scaleImage.transform = CGAffineTransformMakeScale(1+scale, 1+scale);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"回到首页";
    } else {
        cell.textLabel.text = @"push next view";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.tabBarController.selectedIndex = 0;
    } else {
        PushViewController *pvc = [PushViewController new];
        pvc.hidesBottomBarWhenPushed = YES;
        pvc.alphaNum = _p;
        [(YGTransparentNavController *)self.navigationController pushViewController:pvc animated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.transparentView.backgroundColor = [UIColor greenColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.transparentView.backgroundColor = [UIColor clearColor];
    self.navigationController.titleLab.text = @"配置";
    self.navigationController.transparentView.alpha = 0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
