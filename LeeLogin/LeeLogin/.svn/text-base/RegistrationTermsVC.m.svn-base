
//
//  RegistrationTermsVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/27.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "RegistrationTermsVC.h"

@interface RegistrationTermsVC ()

@end

@implementation RegistrationTermsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册条款
   
    self.title = @"注册条款";
    self.view.backgroundColor = COLOR(244, 245, 247, 1);
    [self addView];
    // Do any additional setup after loading the view.
}
- (void)addView
{
    

    UILabel *titelLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, SCREEN_width, 30)];
    titelLable.text = @"心未来互联网平台注册服务条款";
    titelLable.textAlignment = NSTextAlignmentCenter;
    titelLable.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:titelLable];
    UIButton *button = [LeeAllView BigButton:CGRectMake(15, SCREEN_height-70, SCREEN_width-30, 50) withTitel:@"我知道了,返回继续注册"];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_width, SCREEN_height-220)];
    web.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:LINK_BASE_URL(@"/regClause")];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:web];
    
}
- (void)buttonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"返回");
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
