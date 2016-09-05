//
//  LecturerLeverWebViewController.m
//  LeeLogin
//
//  Created by 吕涛 on 16/8/16.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "LecturerLeverWebViewController.h"
#import <WebKit/WebKit.h>
#import "MMProgressHUD.h"
#import <MMProgressHUD/MMRadialProgressView.h>

@interface LecturerLeverWebViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    UIProgressView * _progress;
    WKWebView * web;
}
@end

@implementation LecturerLeverWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleString;
    
    __weak typeof(self) weakSelf = self;
    
    [HTTPURL postRequest:LINK_BASE_URL(@"/userTeach/findTeachLevel") parameters:@{@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        weakSelf.isLecturer = [NSString stringWithFormat:@"%@",responseObject[@"success"]] ;
        if ([weakSelf.isLecturer isEqualToString:@"1"]) {
            weakSelf.urlString =  LINK_URL(@"/lecturer/lecturerInfo");
        }else {
            weakSelf.urlString = LINK_URL(@"/lecturer/unLecturer");
        }
        NSLog(@"讲师信息 --- %@",responseObject);
        [weakSelf progressView];
        [weakSelf createWebView];
        
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"error -- %@",error);
    }showHUD:NO sucessMsg:@"" failureMsg:@""];
}

-(void)createWebView{
    
    web  =[[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height-64)];
    web.UIDelegate = self;
    web.navigationDelegate = self;
    
    [web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld  context:nil];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [web loadRequest:request];
    [self.view addSubview:web];
    [self.view insertSubview:_progress aboveSubview:web];
}
-(void)progressView{
    _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, 5)];
    [self.view addSubview:_progress];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [_progress setProgress:web.estimatedProgress animated:YES];
        if (_progress.progress == 1) {
            [UIView animateWithDuration:1 animations:^{
                _progress.progress = 0;
                _progress.hidden = YES;
            }];
            
        }
        
    }
}

#pragma mark ==  navigationDelegate


//准备加载页面
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _progress.hidden = NO;
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
}

#pragma mark == 移除观察者
-(void)dealloc{
    [web removeObserver:self forKeyPath:@"estimatedProgress"];
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
