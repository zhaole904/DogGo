//
//  ViewController.m
//  DogGo
//
//  Created by zxc-02 on 16/5/24.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "ViewController.h"
#import "LocationViewController.h"
#import "SportTableViewCell.h"
#import "BltViewController.h"
#import "PathModel.h"
#import "DateTools.h"
#import "NSDate+Simple.h"
@interface ViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UIGestureRecognizerDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *leftbtn;
@property (nonatomic, strong) UIButton *rightbtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *header;
@property (nonatomic, strong) UIActivityIndicatorView *refreshView;
@property (nonatomic, strong) UIButton *imageBtn;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn1;

@end

//NSDate *date;
@implementation ViewController

- (instancetype)init
{
    if (self = [super init])
    {
        self.tabBarItem.title = @"运动";
        self.tabBarItem.image = [[UIImage imageNamed:@"ic_sport_check"]imageWithGradientTintColor:[UIColor grayColor]];
        
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_sport_check"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _date = [NSDate date];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self getNavigationItem];
    
    [self getTableView];
    
    [self getTopView];
    
    [self getUIActivityIndicatorView];

//    NSString *str = @"1";
//    
//    NSLog(@"64--%@",[str dataUsingEncoding:NSUTF8StringEncoding]);

}

- (void)getUIActivityIndicatorView
{
    self.refreshView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.refreshView.center = CGPointMake(SCREEN_W / 2.0, 20);
    [self.refreshView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.refreshView.color = [UIColor orangeColor];
    [self.view addSubview:self.refreshView];
    [self.view bringSubviewToFront:self.refreshView];
}

#pragma mark getNavigationItem
- (void)getNavigationItem
{
    
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _leftbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _leftbtn.frame = CGRectMake(0, 0, 44, 44);
//    _leftbtn.tintColor = [UIColor whiteColor];
    [_leftbtn setImage:[UIImage imageNamed:@"ic_map_press"]  forState:UIControlStateNormal];
    [_leftbtn addTarget:self action:@selector(goLocationViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftbtn];

    _rightbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _rightbtn.frame = CGRectMake(SCREEN_W-44, 0, 44, 44);
    [_rightbtn setImage:[UIImage imageNamed:@"ic_ble_press"] forState:UIControlStateNormal];
    [_rightbtn addTarget:self action:@selector(goBltViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightbtn];
}

#pragma mark 加载navigationItem.titleView
- (void)getTopView
{
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-110, 44)];
    self.navigationItem.titleView = View;
    
    _dateLab = [[UILabel alloc]initWithFrame:CGRectMake(46, 0, 100, 44)];
    //    _dateLab.center =  self.navigationItem.titleView.center;
    _dateLab.textColor = [UIColor whiteColor];
    _dateLab.textAlignment = NSTextAlignmentCenter;
    _dateLab.text = @"今天";
    //    _dateLab.text = [_date dateToDayString];
    
    [View addSubview:_dateLab];

    
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.frame = CGRectMake(0, 7, 30, 30);
    [_btn1 setImage:[[UIImage imageNamed:@"ic_arrow_left_press"] imageWithGradientTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventTouchUpInside];
    _btn1.tag = 2016;
    [View addSubview:_btn1];
    
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2.frame = CGRectMake(SCREEN_W-110-50, 7, 30, 30);
    [_btn2 setImage:[[UIImage imageNamed:@"ic_arrow_right_press"] imageWithGradientTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_btn2 addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventTouchUpInside];
    _btn2.tag = 2017;
    if ([_dateLab.text isEqualToString:@"今天"]) {
        _btn2.enabled = NO;
    }
    [View addSubview:_btn2];
    
}

#pragma mark 改变日期
- (void)changeTime:(UIButton *)btn
{
   
    if (btn.tag == 2016) {
         _btn2.enabled = YES;
         _date = [_date dateByAddingDays:-1];
         _dateLab.text = [_date dateToDayString];
    }else {
        _date = [_date dateByAddingDays:1];
        _dateLab.text = [_date dateToDayString];
        
        if ([_date daysFrom:[NSDate date]] == 0 ){
            _dateLab.text = @"今天";
            _btn2.enabled = NO;
        }
    }
}

- (void)getTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark   leftbtn action
- (void)goLocationViewController
{
//   self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
  
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    LocationViewController *lvc = [[LocationViewController alloc] init];
    lvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lvc animated:YES];

}

#pragma mark   rightbtn action
- (void)goBltViewController
{
     [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back.." style:UIBarButtonItemStyleDone target:self action:nil];
    BltViewController *bvc = [[BltViewController alloc] init];
    bvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bvc animated:YES];
}

#pragma mark UITableViewDataSource/delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[SportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 200)];
    _header.contentMode = UIViewContentModeScaleAspectFill;
    _header.layer.masksToBounds = YES;
     UIImage *dogImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[PathModel docPath] stringByAppendingPathComponent:@"dogImage"]]];

    if (!dogImage) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"bg_dog_1" ofType:@".png"];
        _header.image = [UIImage imageWithContentsOfFile:path];
//        _header.image = [UIImage imageNamed:@"bg_dog_1"];
//        _imageBtn.hidden = YES;

    }else {
        _header.image = dogImage;
        _imageBtn.hidden = YES;
    }
    
    _header.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageBtn:)];
    [_header addGestureRecognizer:tap];
    
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageBtn.frame = CGRectMake((SCREEN_W - 60)/2.0, 100-30, 60, 60);
    self.imageBtn.layer.cornerRadius = 30.0;
    self.imageBtn.layer.masksToBounds = YES;
    self.imageBtn.backgroundColor = [UIColor cyanColor];
    [self.imageBtn addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
    self.imageBtn.hidden = YES;
    [_header addSubview:self.imageBtn];
    return _header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_H -35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

#pragma mark UIGestureRecognizer
- (void)hideImageBtn:(UIGestureRecognizer *)tap
{
    if (_imageBtn.hidden == YES) {
        _imageBtn.hidden = NO;
    }else {
        _imageBtn.hidden = YES;
    }

}

#pragma mark changeImage button
- (void)changeImage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"选择来源", nil) message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"拍照", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"从相册选择", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.delegate = self;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - uiimagepickercontroller - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //选中的图片
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *imageData = UIImageJPEGRepresentation(pickedImage, 1);
    
    NSString *imagePath = [[PathModel docPath] stringByAppendingPathComponent:@"dogImage"];
//    NSLog(@"imagePath--%@",imagePath);
    if ([imageData writeToFile:imagePath atomically:YES]) {
        
        _header.image = pickedImage;
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < -40) {
        [self.refreshView startAnimating];
    }else {
        [self.refreshView stopAnimating];
    }
//    NSLog(@"kkk %f",scrollView.contentOffset.y);
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (scrollView.contentOffset.y < 100) {
//
//        scrollView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
//        
////        [self showData:nil];
//        
//    }
//}
@end
