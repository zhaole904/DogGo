//
//  OURViewController.m
//  DogGo
//
//  Created by zxc-02 on 16/5/24.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "OURViewController.h"

@interface OURViewController ()

@end

@implementation OURViewController

- (instancetype)init
{
    if (self = [super init])
    {
//        self.tabBarItem.title = @"我们";
//        self.tabBarItem.image = [[UIImage imageNamed:@"ic_about_check"]imageWithGradientTintColor:[UIColor grayColor]];
//        
//        self.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_about_check"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我们" image:[[UIImage imageNamed:@"ic_about_check"]imageWithGradientTintColor:[UIColor grayColor]] selectedImage:[UIImage imageNamed:@"ic_about_check"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.title = @"我们";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
//    self.navigationController.navigationBar.translucent = NO;
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
