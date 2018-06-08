//
//  RequestDataViewController.m
//  DogGo
//
//  Created by zxc-02 on 16/6/2.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "RequestDataViewController.h"

#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)
@interface RequestDataViewController ()

@end

@implementation RequestDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, 400)];
    lab.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:lab];
    
    [[BltSendModel  sharedBltSendModel]dataModelFromPerpheralByDay:0 ResponseBlock:^(DailyDataModel *dataModel) {
    
    NSDate *date = dataModel.date;
    MetaDataModel *model = dataModel.data[0];
    NSInteger type = model.dataType;
    NSString *address = model.macAddress;
    NSArray *dataArr = model.data;
    
    lab.text = [NSString stringWithFormat:@"date:%@ \n,type:%ld \n,address:%@ \n,dataArr:%@",date,type,address,dataArr];
//    lab.text = @"00111";
        NSLog(@"fca");
        NSLog(@"%@",[NSString stringWithFormat:@"date:%@ \n,type:%ld \n,address:%@ \n,dataArr:%@",date,type,address,dataArr]);
}];

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
