
//
//  RegistrationPromptVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/27.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "RegistrationPromptVC.h"

@interface RegistrationPromptVC ()

@end

@implementation RegistrationPromptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(244, 245, 247, 1);
    //注册提示
    self.title = @"注册提示";
    [self addView];
    // Do any additional setup after loading the view.
}
- (void)addView
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width/2-50, 125, 100, 90)];
    imgView.image = [UIImage imageNamed:@"icon_ts"];
    [self.view addSubview:imgView];
    UILabel *titelLabel = [LeeAllView allLabelWith:CGRectMake(25, 255, SCREEN_width-50, 30) withTextColor:COLOR(0, 0, 0, 1)];
    titelLabel.adjustsFontSizeToFitWidth =YES;
    titelLabel.text = @"您未填写推荐人VE号,是否确认注册?";
    titelLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titelLabel];
    UILabel *contenLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 290, SCREEN_width-40, 100)];
    contenLabel.text = @"注: 如不填写推荐人VE,一周后您的账号将会被删除,推荐人VE可在个人信息处填写。";
    contenLabel.numberOfLines=0;
    contenLabel.textColor = COLOR(144, 145, 146, 1);
    [self.view addSubview:contenLabel];
    
    UIButton *button = [LeeAllView BigButton:CGRectMake(15, 400, SCREEN_width-30, 50) withTitel:@"我知道了,继续注册"];
    [button addTarget:self action:@selector(buttonClcik) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (void)buttonClcik
{
    [self .delegate refresh];
    [self.navigationController popViewControllerAnimated:YES];
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
