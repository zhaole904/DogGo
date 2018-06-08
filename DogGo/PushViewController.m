//
//  PushViewController.m
//  DogGo
//
//  Created by zxc-02 on 2016/11/25.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "PushViewController.h"
#import "YGTransparentNavController.h"
@interface PushViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UILabel *lab;
@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftbtn.frame = CGRectMake(0, 0, 44, 44);
    leftbtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    //imageEdgeInsets
    [leftbtn setTitle:@"pop.." forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 9287/(5000/320.0)+44);
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 9287/(5000/320.0)+44)];
    imageV.image = [UIImage imageNamed:@"流程图11-15 "];
    [scrollView addSubview:imageV];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];

    
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _lab.center = self.view.center;
    _lab.text = @"press button";
    _lab.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_lab];
    
    UIBarButtonItem *tbarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(itemClick:)];
    tbarItem.tag = 1;
    
    UIBarButtonItem *tbarItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(itemClick:)];
    tbarItem1.tag = 2;
    
    UIBarButtonItem *tbarItem3 = [[UIBarButtonItem alloc] initWithTitle:@"title" style:(UIBarButtonItemStyleDone) target:self action:@selector(itemClick:)];
    tbarItem3.tag = 3;
    
    UIBarButtonItem *tbarItem4 = [[UIBarButtonItem alloc] initWithTitle:@"button1" style:(UIBarButtonItemStyleDone) target:self action:@selector(itemClick:)];
    tbarItem3.tag = 4;
    //设置间隔
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:@selector(itemClick:)];
    
    NSArray *itemArray=
    @[tbarItem,flex,tbarItem1,flex,tbarItem3,flex,tbarItem4];
    
    //默认是隐藏的
    [self.navigationController setToolbarHidden:NO animated:YES];
    [self setToolbarItems:itemArray];
}

- (void)itemClick:(UIBarButtonItem *)item
{
    switch (item.tag) {
        case 1:
            _lab.text = @"share";
            break;
        
        case 2:
            _lab.text = @"add";
            break;

        case 3:
            _lab.text = @"title";
            break;

        case 4:
            _lab.text = @"button1";
            break;
            
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 修改导航的透明度
    // 计算透明值
    CGFloat p = offsetY * 0.005;
    self.navigationController.transparentView.alpha = p;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.transparentView.backgroundColor = [UIColor redColor];
    self.navigationController.titleLab.text = @"Push";
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
//    self.navigationController.transparentView.backgroundColor = [UIColor greenColor];
    self.navigationController.transparentView.alpha = _alphaNum;
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
