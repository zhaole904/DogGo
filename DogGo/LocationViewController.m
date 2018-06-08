//
//  LocationViewController.m
//  DogGo
//
//  Created by zxc-02 on 16/5/24.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "LocationViewController.h"
#import "LLViewController.h"
@interface LocationViewController ()<UIGestureRecognizerDelegate>


@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 100, 44, 44);
    btn.backgroundColor = [UIColor cyanColor];
    [btn addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftbtn.frame = CGRectMake(0, 0, 44, 44);
    //    [leftbtn setImage:[UIImage imageNamed:@"ic_map_press"]  forState:UIControlStateNormal];
    leftbtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    //imageEdgeInsets
    [leftbtn setTitle:@"back" forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
//  self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self getPan];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 80)];
    UIImage *image = [UIImage imageNamed:@"01"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.8];
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(17, 10, 10, 20) resizingMode:UIImageResizingModeStretch];
    

    imageV.image = image;
    
    
//     container按照imageV裁剪
    UIImageView *container = [[UIImageView alloc] initWithFrame:CGRectMake(50, 300, CGRectGetWidth(imageV.frame) ,CGRectGetHeight(imageV.frame))];
    container.backgroundColor = [UIColor orangeColor];
    container.layer.mask = imageV.layer;
    container.image = [UIImage imageNamed:@"5.jpg"];
    [self.view addSubview:container];

    UIImageView *imageVv = [[UIImageView alloc] initWithFrame:CGRectMake(50, 90, 200, 100)];
    UIImage *maskImage = [[UIImage imageNamed:@"01"]imageWithGradientTintColor:[UIColor redColor]];
    UIImage *imagee = [self maskImage:maskImage withMask:[[UIImage imageNamed:@"0.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    [imagee imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    imageVv.image = imagee;
    [self.view addSubview:imageVv];
}

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(ctx,0.5);
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
    
}  

- (void)go
{
    NSLog(@"afdasf");
    LLViewController *lvc = [[LLViewController alloc] init];
    [self.navigationController pushViewController:lvc animated:YES];
}

- (void)getPan
{
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];

    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if (self.navigationController.viewControllers.count <= 1 )
//        return NO;
//    return YES;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
