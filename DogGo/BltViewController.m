//
//  BltViewController.m
//  DogGo
//
//  Created by zxc-02 on 16/5/25.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "BltViewController.h"
#import "PerModel.h"
#import "BltTool.h"
#import "DailyDataModel.h"
#import "RequestDataViewController.h"

@interface BltViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) DailyDataModel *dailyDataModel;
@end

@implementation BltViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor cyanColor];
    [self creatBltTool];
    [self getTableView];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)getTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)creatBltTool
{
    [BltTool sharedBltTool].statusBlock = ^void(CBPeripheral *peripheral, STATUS status){
        
        if (status == STATUS_CONNECTING) {
            
        }else if (status == STATUS_UPDATEPER){
            
            NSDictionary *dic = [BltTool sharedBltTool].allPer;
            _dataArr = dic.allValues;
        
        }else if (status == STATUS_DISCONNECTED){
            
        }else if(status == STATUS_CONNECTED){
            
        }
        [[BltTool sharedBltTool] startScaning];

        [self.tableView reloadData];
    }; 
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[BltSendModel  sharedBltSendModel]dataModelFromPerpheralByDay:0 ResponseBlock:^(DailyDataModel *dataModel) {
        
        NSDate *date = dataModel.date;
        MetaDataModel *model = dataModel.data[0];
        NSInteger type = model.dataType;
        NSString *address = model.macAddress;
        NSArray *dataArr = model.data;
        
        NSLog(@"fca");
        NSLog(@"%@",[NSString stringWithFormat:@"date:%@ \n,type:%ld \n,address:%@ \n,dataArr:%@",date,type,address,dataArr]);
    }];
     NSLog(@"001122");
    
    [[BltTool sharedBltTool] stopScaning];

}

#pragma mark tableView  UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    PerModel *model = _dataArr[indexPath.row];
    cell.textLabel.text = model.per.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"RSSI:%@",model.RSSI];
    cell.imageView.image = [UIImage imageNamed:@"ic_lights"];

    NSString *curent = [BltTool sharedBltTool].per.identifier.UUIDString;
    if ([model.per.identifier.UUIDString isEqualToString:curent]) {

        cell.detailTextLabel.text = @"连接状态:已连接";
       }else{
        
        cell.detailTextLabel.text = @"连接状态:未连接";
    }
    


    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RequestDataViewController *rvc = [[RequestDataViewController alloc] init];
//    [self.navigationController pushViewController:rvc animated:YES];

//    PerModel *model = _dataArr[indexPath.row];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(170, 20, 200, 40)];
//    lab.backgroundColor = [UIColor redColor];
//    [cell.contentView addSubview:lab];
//    
//    NSString *curent = [BltTool sharedBltTool].per.identifier.UUIDString;
//    if ([model.per.identifier.UUIDString isEqualToString:curent]) {
//        
//        lab.text = @"连接状态:已连接";
//    }else{
//        lab.text = @"连接状态:未连接";
//    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end
