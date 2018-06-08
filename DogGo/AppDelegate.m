//
//  AppDelegate.m
//  DogGo
//
//  Created by zxc-02 on 16/5/24.
//  Copyright © 2016年 zxc-02. All rights reserved.
//

#import "AppDelegate.h"
#import "BltTool.h"
#import "YGTransparentNavController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSThread sleepForTimeInterval:1.0];
    [self getTabBarController];
    return YES;
    
//    self.window.rootViewController = [SDAppFrameTabBarController new];
}

- (void)getTabBarController
{
    UITabBarController *tvc = [[UITabBarController alloc] init];
    NSMutableArray *navs = [[NSMutableArray alloc]init];
    NSArray *viewNames = @[@"ViewController",@"PZViewController",@"OURViewController"];
    
    for (NSString *str in viewNames) {
        UIViewController *vc = [[NSClassFromString(str) alloc]init];
        if ([str isEqualToString:@"PZViewController"]) {
            YGTransparentNavController *nvc = [[YGTransparentNavController alloc] initWithRootViewController:vc];
            [navs addObject:nvc];
        } else {
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
            [navs addObject:nvc];
        }
    }
    tvc.viewControllers = navs;
    [BltTool sharedBltTool];

    self.window.rootViewController = tvc;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
