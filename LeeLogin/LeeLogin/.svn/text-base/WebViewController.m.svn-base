//
//  WebViewController.m
//  LeeLogin
//
//  Created by 吕涛 on 16/8/15.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "MMProgressHUD.h"
#import <MMProgressHUD/MMRadialProgressView.h>
@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    UIProgressView * _progress;
    
    WKWebView * web;
    
    NSString * currentURL;//当前页面的URL
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.title = self.titleString;
    NSLog(@"weburl -- %@",self.urlString);
    currentURL = self.urlString;
    [self createWebView];
    [self progressView];
    
    [self loadNavTitle];
}

#pragma mark == 返回  关闭 按钮
- (void)loadNavTitle{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 19, 35);
    [btn setImage:[UIImage imageNamed:@"head_arrow"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButClicled) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    
    if (self.hasRightItem) {
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 50, 40);
        [backBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(popTopView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }

}

-(void)popTopView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createWebView{
    
    web  =[[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height-64)];
    web.UIDelegate = self;
    web.navigationDelegate =self;
    web.allowsBackForwardNavigationGestures = YES;
    [web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld  context:nil];
    web.scrollView.showsVerticalScrollIndicator = NO;
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [web loadRequest:request];
    [self.view addSubview:web];
    
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

#pragma mark ==  WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark ==  navigationDelegate

//准备加载页面
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    _progress.hidden =NO;
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    // 以 html title 设置 导航栏 title
    __weak typeof(self) weakself= self;
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        weakself.title = result;
    }];
    currentURL = [NSString stringWithFormat:@"%@",webView.URL];
    NSLog(@"%@",currentURL);
    //    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
//    [MMProgressHUD dismissWithError:@"加载失败"];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:currentURL]]];
}


- (void)backButClicled{
    NSString * str = [self.urlString stringByAppendingString:@"#"];

    if ([self.urlString isEqualToString:currentURL] || [currentURL isEqualToString:str]) { //如果当前H5页面网址等于 进入webview时的网址 退出webview
        [self.navigationController popViewControllerAnimated:YES];
        return;
    } else if([web canGoBack]){
        [web goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark ==

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
