


//
//  IndividualAccountContenVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/4.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "IndividualAccountContenVC.h"
#define SetLoginPwd @"/userAccount/setLoginPwd"//重置密码
#define YiMoney @"/account/yiMoney"//翼币
#define CASH @"/account/cash"//现金
#define CASHWithdrawalWithdrawal @"/account/cashWithdrawal"//现金体现
#define SCORE @"/account/score"//积分
#define UNboundBankCard @"/account/unboundBankCard"//未绑定银行卡
#define BoundBankCard @"/account/boundBankCard"//已绑定银行卡
#define BinDingBankCard @"/account/bindingBankCard"//绑定银行卡
#define ChangePayPassword @"/account/changePayPassword"//修改支付密码
#define SetPayPassword @"/account/setPayPassword"//设置支付密码
@interface IndividualAccountContenVC ()<UIWebViewDelegate>
{
    NSURL *_url;
}
@end

@implementation IndividualAccountContenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.navigationController.navigationBar);
    self.title= _titleString;
    self.view.backgroundColor = BGCOLOR;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height)];
    //[webView setOpaque:NO];//opaque是不透明的意思
    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    webView.delegate = self;
    [webView setUserInteractionEnabled:YES];//是否支持交互
    [self.view addSubview:webView];
    if ([_titleString isEqualToString:@"翼币"]) {
        NSLog(@"翼币");
        _url = [NSURL URLWithString:@"https://www.baidu.com"];
    }else if ([_titleString isEqualToString:@"现金"]){
        NSLog(@"现金");
        _url = [NSURL URLWithString:@"https://www.sina.com"];
    }else if ([_titleString isEqualToString:@"积分"]){
        NSLog(@"积分");
        _url = [NSURL URLWithString:@"https://lol.qq.com"];
    }else if ([_titleString isEqualToString:@"银行卡"]){
        NSLog(@"银行卡");
        _url = [NSURL URLWithString:@"https://www.panda.tv"];
    }else if ([_titleString isEqualToString:@"支付密码"]){
        NSLog(@"支付密码");
        _url = [NSURL URLWithString:@"https://t.qq.com/huhudeweibe"];
    }
    
    [webView loadRequest:[NSURLRequest requestWithURL:_url]];
    // Do any additional setup after loading the view.
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
