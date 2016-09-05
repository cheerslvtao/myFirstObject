


//
//  LoginVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/28.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "LoginVC.h"
#import "RegisteredVC.h"//注册
#import "RetrievePasswordVC.h"//找回密码
#import "HomePageViewController.h"//首页
#import "MMProgressHUD.h"
#define LOGIN @"/userAccount/login"//登录

@interface LoginVC ()<UITextFieldDelegate>
{
    BOOL lastButton;
    int code;
}
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    code =012;
    self.view.backgroundColor = BGCOLOR;
    //self.navigationItem.hidesBackButton = YES;
    self.btn.hidden=YES;
    self.title = @"请您登录";
    [self addView];//添加视图
    
    // Do any additional setup after loading the view.
}
#pragma mark --添加登录View
- (void)addView
{
    NSArray *array = @[@"VE号",@"密码"];
    LeeAllView *leeAllView = [LeeAllView new];
    for (int i=0; i<2; i++){
        UIView *view = [leeAllView registeredViewWithFrame:CGRectMake(15, 85+(65*i), SCREEN_width-30, 50)];
        leeAllView.titerLabel.text = array[i];
        leeAllView.titerLabel.textAlignment = NSTextAlignmentCenter;
        leeAllView.textField.tag = i+10;
        NSLog(@"%@",[USER_D objectForKey:@"hook"]);
        if ([[USER_D objectForKey:@"hook"]isEqualToString:@"on"]){
            if (i==0) {
                leeAllView.textField.text = [USER_D objectForKey:@"ve_code"];
            }else{
                leeAllView.textField.text = [USER_D objectForKey:@"password"];
                leeAllView.textField.secureTextEntry = YES;
            }
        }
        leeAllView.textField.delegate = self;
        [self.view addSubview:view];
    }
    //对勾按钮
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
     NSLog(@"%@",[USER_D objectForKey:@"hook"]);
    if ([[USER_D objectForKey:@"hook"]isEqualToString:@"on"]){
        [but setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateNormal];
        [USER_D setObject:@"on" forKey:@"hook"];
    }else{
        [but setImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
         [USER_D setObject:@"off" forKey:@"hook"];
    }
    but.frame = CGRectMake(30,225, 30, 30);
    [self.view addSubview:but];
    //记住密码标签
    UILabel *yesLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 225, 80, 30)];
    yesLabel.text = @"记住密码";
    yesLabel.font = THIRTEEN;
    [self.view addSubview:yesLabel];
    //忘记密码
    UIButton *forgetBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBut addTarget:self action:@selector(termsButClicled) forControlEvents:UIControlEventTouchUpInside];
    [forgetBut setTitleColor:[UIColor colorWithRed:0/255.0 green:133/255.0 blue:220/255.0 alpha:1] forState:UIControlStateNormal];
    [forgetBut setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetBut.titleLabel.font = THIRTEEN;//设置字体大小
    forgetBut.frame = CGRectMake(SCREEN_width-150,225, 120, 30);
    [self.view addSubview:forgetBut];
    //登录按钮
   UIButton *button = [LeeAllView BigButton:CGRectMake(15, 275, SCREEN_width-30, 50) withTitel:@"登  录"];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //注册
    UIButton *registeredBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [registeredBut addTarget:self action:@selector(registeredButClicled) forControlEvents:UIControlEventTouchUpInside];
    [registeredBut setTitleColor:[UIColor colorWithRed:0/255.0 green:133/255.0 blue:220/255.0 alpha:1] forState:UIControlStateNormal];
    [registeredBut setTitle:@"还不是会员? 马上注册" forState:UIControlStateNormal];
    registeredBut.titleLabel.font = THIRTEEN;//设置字体大小
    registeredBut.frame = CGRectMake(SCREEN_width/8,340, SCREEN_width/4*3, 30);
    [self.view addSubview:registeredBut];
}
#pragma mark --登录按钮事件
- (void)buttonClick{
    UITextField *veText =[self.view viewWithTag:10];
    UITextField *pwdText =[self.view viewWithTag:11];
    //判断是否为空
    if ([veText.text  isEqual: @""]||[pwdText.text isEqual: @""]){
        UIAlertController * alert = [UICommonView showOneAlertWithTitle:@"提示" message:@"VE号跟密码不能为空,请重输入" preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" sureBlock:^{
            
        }];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
    [self HTTPRequest];//发送请求
    }
}
- (void)rightButton:(UIButton *)button
{
    if (lastButton==0) {
        [button setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateNormal];
        [USER_D setObject:@"on" forKey:@"hook"];
    }else{
        [button setImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
        [USER_D setObject:@"off" forKey:@"hook"];
    }
    lastButton = !lastButton;
}
- (void)termsButClicled{
    RetrievePasswordVC *retrievePasswordVC = [RetrievePasswordVC new];
    [self.navigationController pushViewController:retrievePasswordVC animated:YES];
    NSLog(@"忘记密码");
}
- (void)registeredButClicled{
    RegisteredVC *registeredVC = [RegisteredVC new];
    [self.navigationController pushViewController:registeredVC animated:YES];
      NSLog(@"注册");
}
//登录网络请求
#pragma mark --登录网络请求
-(void)HTTPRequest{
  //  __weak LoginVC *liginVC = self;
    UITextField *VEText= [self.view viewWithTag:10];
    UITextField *pwd= [self.view viewWithTag:11];
    [USER_D setObject:pwd.text forKey:@"password"];//密码
    NSString *pwdStr =[UICommonView md5:pwd.text];//加密
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:@"提示" status:@"玩命加载中..."];
    [HTTPURL postRequest:LINK_BASE_URL(LOGIN) parameters:@{@"ve_code":VEText.text,@"pwd":pwd.text,@"IP":IP} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"~~~~~~~%@",responseObject);
        NSLog(@"%@",responseObject[@"msg"]);
        [USER_D setObject:responseObject[@"data"][@"ve_code"] forKey:@"ve_code"];//ve号
        [USER_D setObject:responseObject[@"data"][@"secret"] forKey:@"secret"];//驿码
        [USER_D synchronize];
        NSLog(@"%@",[USER_D objectForKey:@"secret"]);
        //跳转页面
            NSLog(@"%d",[responseObject[@"code"]intValue]);
        if ([VE_CODE length]>0 && [SECRET length]> 0){
            [HTTPURL authorizationsuccess:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                [USER_D setObject:responseObject[@"value"] forKey:@"token"];
                [USER_D synchronize];
                
                HomePageViewController *vc = [HomePageViewController new];
                UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
                UIWindow *window =[[UIApplication  sharedApplication].delegate window];
                window.rootViewController = nvc;
            } Success:^(NSURLSessionDataTask *task, id responseObject) {
                
            }];
        }
        [MMProgressHUD dismissWithSuccess:responseObject[@"msg"]];
    } filure:^(NSURLSessionDataTask *task, id error) {
    } showHUD:NO sucessMsg:@"" failureMsg:@""];
    
}
#pragma mark --收起键盘
//收起键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;{
    [self.view endEditing:YES];
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
