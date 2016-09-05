



//
//  RecommendedTrainingVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/9.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "RecommendedTrainingVC.h"

@interface RecommendedTrainingVC ()<UIWebViewDelegate>

@end

@implementation RecommendedTrainingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐培养";
    self.view.backgroundColor = BGCOLOR;
    [self addWebView];
    // Do any additional setup after loading the view.
}
-(void)addWebView{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height)];
    //[webView setOpaque:NO];//opaque是不透明的意思
    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    webView.delegate = self;
    [webView setUserInteractionEnabled:YES];//是否支持交互
    [self.view addSubview:webView];
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [LeeAllView accordingHotWheels:self];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [LeeAllView endHotWheels:self];
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
