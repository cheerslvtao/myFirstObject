//
//  AppDelegate.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/27.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import "WelcomeViewController.h"


@interface AppDelegate ()
{
    BMKMapManager* _mapManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"zeRtAjTehhz0qQYbpCZcZO5PUStL6WbY"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    WelcomeViewController *vc = [WelcomeViewController new];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"head_bg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];

    if (![NSUSERDEFAULTS objectForKey:@"APPFIRSTRUN"]) {
        [self registeForFirst];
    }
    NSString * idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [USER_D setObject:idfv forKey:@"idfv"];
    self.window.rootViewController = nvc;
    return YES;
}

//用于统计用户安装量，在APP首次启动时，app应当调用此接口上传注册信息
-(void)registeForFirst{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [USER_D setObject:infoDictionary forKey:@"infoDictionary"];
    NSLog(@"%@",infoDictionary);
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    //NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    //NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    // 获取设备编码
    NSString * idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [USER_D setObject:idfv forKey:@"idfv"];
    [USER_D setObject:appCurVersion forKey:@"appCurVersion"];
    [USER_D synchronize];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:LINK_BASE_URL(@"/statistic/add") parameters:@{@"deviceId":idfv,@"registerType":@"USER",@"clientType":@"IOS",@"version":appCurVersion} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [NSUSERDEFAULTS setObject:@(NO) forKey:@"APPFIRSTRUN"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);

    }];

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
