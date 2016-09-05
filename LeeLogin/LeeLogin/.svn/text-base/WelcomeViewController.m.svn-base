

//
//  WelcomeViewController.m
//  HeartFuture
//
//  Created by 李雪虎 on 16/7/18.
//  Copyright © 2016年 光之翼. All rights reserved.
//

#import "WelcomeViewController.h"
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
#import "LoginVC.h"//登录
#import "RegisteredVC.h"//注册
#import "HomePageViewController.h"//首页
#define EQUIPMENT_UPDATE @"/statistic/update"//设备更新
#define START_PAGE @"/ad/index"//启动页广告
#define LOGIN_REGISTERED @"/userAccount/getNameByVeCode"//登录/注册
@interface WelcomeViewController ()
{
    NSTimer *timer;
    UIImageView *advertisingImgView;
}
@property (nonatomic ,copy)NSString *pageUrl;
@end

@implementation WelcomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self httpRquest];//广告
    [self addView];
    [self httpRquestUpData];//设备更新
    //获取IP
    [USER_D setObject:[self getDeviceIPIpAddresses] forKey:@"IP"];
    if ([ACCESS_TOKEN isEqualToString:@""]){
        
    }else{
        [self advertising];//广告
    }
    // Do any additional setup after loading the view.
}
-(void)addView
{
    //欢迎页面
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:SCREEN_bounds];
    imgView.image = [UIImage imageNamed:@"qdy_bg"];
    imgView.backgroundColor = [UIColor redColor];
    imgView.userInteractionEnabled=YES;
    [self.view addSubview:imgView];
    UIImageView *titleImg = [[UIImageView alloc]initWithFrame:CGRectMake(50, SCREEN_height/2-15, SCREEN_width-100, 30)];
    titleImg.image = [UIImage imageNamed:@"name"];
    [self.view addSubview:titleImg];
    UIImageView *contentImg = [[UIImageView alloc]initWithFrame:CGRectMake(60, SCREEN_height-60, SCREEN_width-120, 40)];
    contentImg.image = [UIImage imageNamed:@"Copyright"];
    [self.view addSubview:contentImg];
    
    NSArray *array = @[@"登录",@"注册"];
    for (int i=0; i<2; i++){
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:array[i] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(butClicled:) forControlEvents:UIControlEventTouchUpInside];
        [but setBackgroundImage:[UIImage imageNamed:@"qdy_btn"] forState:UIControlStateNormal];
        but.tag = i+10;
        but.frame = CGRectMake(50+(((SCREEN_width-130)/2+30)*i), SCREEN_height/2+60, (SCREEN_width-130)/2, 40);
        [imgView addSubview:but];
    }
}
-(void)butClicled:(UIButton *)button{
     NSLog(@"~~~%@",NSHomeDirectory());
    if (button.tag ==10) {
        [self loginVC];//登录页面
    }else{
        [self registeredVC];//注册页面
    }
    NSLog(@"hello");
}
#pragma mark == 登录页面
-(void)loginVC{
    
    
        LoginVC *vc= [LoginVC new];
        UINavigationController * nv = [[UINavigationController alloc]initWithRootViewController:vc];
        UIWindow *window =[[UIApplication  sharedApplication].delegate window];
        window.rootViewController = nv;
    
    
    
}
#pragma mark == 注册页面
-(void)registeredVC{
    RegisteredVC *vc = [RegisteredVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
//获取手机IP
#pragma mark --获取手机IP
- (NSString *)getDeviceIPIpAddresses{
    
    int sockfd =socket(AF_INET,SOCK_DGRAM, 0);
    
    //    if (sockfd <</span> 0) return nil;
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE =4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            
            int len =sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                
                len = ifr->ifr_addr.sa_len;
                
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
        }
    }
    close(sockfd);
    
    NSString *deviceIP =@"";
    
    for (int i=0; i < ips.count; i++)
    {
        if (ips.count >0)
            
        {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    
    NSLog(@"deviceIP========%@",deviceIP);
    
    return deviceIP;
    
}
#pragma mark --广告View
-(void)advertising{
    UIView *view = [[UIView alloc]initWithFrame:SCREEN_bounds];
    view.backgroundColor = BGCOLOR;
    view.tag = 1000;
    [self.view addSubview:view];
    //广告
    advertisingImgView = [[UIImageView alloc]initWithFrame:SCREEN_bounds];
    [advertisingImgView setImageWithURL:[NSURL URLWithString:[USER_D objectForKey:@"pageUrl"]]];
    advertisingImgView.userInteractionEnabled=YES;
    [view addSubview:advertisingImgView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_width-30, 25, 30, 30);
    button.titleLabel.textColor = BGCOLOR;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(buttonClicke) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 30;
    [button setEnabled:NO];
    [advertisingImgView addSubview:button];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClicke) userInfo:nil repeats:YES];
}
#pragma mark --关闭广告
-(void)buttonClicke{
    NSString *str = [USER_D objectForKey:@"hook"];
    if ([str isEqual:nil]) {
        UIView *view = [self.view viewWithTag:1000];
        [view removeFromSuperview];
    }else{
        if ([[USER_D objectForKey:@"hook"]isEqualToString:@"on"]) {
            [self loginVC];
        }else{
            
            UIView *view = [self.view viewWithTag:1000];
            [view removeFromSuperview];
        }
    }
}
-(void)timerClicke{
   static int a=6;
    a--;
    NSLog(@"%d",a);
    UIButton *button = [self.view viewWithTag:30];
    [button setTitle:[NSString stringWithFormat:@"%d",a] forState:UIControlStateNormal];
    if (a<=0) {
        [button setEnabled:YES];
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [timer invalidate];
        timer =nil;
        
    }else{
        [button setEnabled:NO];
    }
}
#pragma mark --广告请求
-(void)httpRquest
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:LINK_BASE_URL(START_PAGE) parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        _pageUrl = responseObject[@"msg"];
        [USER_D setObject:_pageUrl forKey:@"pageUrl"];
        [advertisingImgView setImageWithURL:[NSURL URLWithString:_pageUrl]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    [self addView];
}
#pragma mark -- 设备更新请求
-(void)httpRquestUpData
{
    NSString *idfv = [USER_D objectForKey:@"idfv"];
    NSString *version = [USER_D objectForKey:@"appCurVersion"];
    NSString *phono;
    if ([USER_D objectForKey:@"phono"] ==nil) {
        phono = @"";
    }else{
        phono = [USER_D objectForKey:@"phono"];
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:LINK_BASE_URL(EQUIPMENT_UPDATE) parameters:@{@"deviceId":idfv,@"version":version,@"mobilePhone":@"ad"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
       NSLog(@"%@",responseObject[@"msg"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
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
