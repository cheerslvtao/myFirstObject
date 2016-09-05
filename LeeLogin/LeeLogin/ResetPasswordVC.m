
//
//  ResetPasswordVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/28.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "ResetPasswordVC.h"
#import "LoginVC.h"//登录
#define resetPWD @"/userAccount/changePwdByToken"
@interface ResetPasswordVC ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *lastTextField;
@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //重置密码
    self.title = @"重置密码";
    self.view.backgroundColor = BGCOLOR;
    [self addView];//添加视图
    // Do any additional setup after loading the view.
}
#pragma mark --添加视图
- (void)addView
{
    NSArray *array = @[@"  VE号",@"邮箱验证码",@"  新密码",@" 确认新密码"];
    LeeAllView *leeAllView = [LeeAllView new];
    for (int i=0; i<array.count; i++){
        UIView *view = [leeAllView registeredViewWithFrame:CGRectMake(15, 85+(65*i), SCREEN_width-30, 50)];
        leeAllView.tag = 50+i;
        leeAllView.titerLabel.text = array[i];
        leeAllView.textField.tag = i+10;
        leeAllView.textField.delegate = self;
        if (i==3||i==2) {
            leeAllView.textField.secureTextEntry = YES;
            leeAllView.textField.placeholder = @"请输入6~16位密码";
        }
        [self.view addSubview:view];
    }
    //发送重置邮件按钮
    UIButton *button = [LeeAllView BigButton:CGRectMake(15, 340, SCREEN_width-30, 50) withTitel:@"重置密码"];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
#pragma mark --发送重置密码
- (void)buttonClick{
    NSLog(@"发送重置密码");
    UITextField *newPWD = [self.view viewWithTag:12];
    UITextField *PWDtext = [self.view viewWithTag:13];
    NSLog(@"%@",PWDtext.text);
    NSLog(@"%@",newPWD.text);
    if ([newPWD.text isEqualToString:PWDtext.text]){
        NSLog(@"密码相同");
        [self httpRquest];//发送请求
    }else{
        [self promptViewmessage:@"密码不相同 请从新输入" sureBlock:^{
            PWDtext.text = @"";
        }];
    }
}
#pragma mark--网络请求
-(void)httpRquest
{
    //发送重置密码
    UITextField *newPWD = [self.view viewWithTag:12];
    UITextField *PWDtext = [self.view viewWithTag:13];
    UITextField *veText = [self.view viewWithTag:10];
    UITextField *validationText = [self.view viewWithTag:11];
    ResetPasswordVC *resetPasswordVC = self;
    [HTTPURL postRequest:LINK_BASE_URL(resetPWD) parameters:@{@"ve_code":veText,@"token":validationText.text,@"new_pwd":newPWD.text,@"cofirm_pwd":PWDtext.text} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *string = responseObject[@"msg"];
        if ([[responseObject[@"success"] stringValue]isEqualToString:@"1"]){
            //提示框
            [resetPasswordVC promptViewmessage:string sureBlock:^{
                //跳转登录页面
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }else{
            //提示框
            [resetPasswordVC promptViewmessage:string sureBlock:^{
                
            }];
        }
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"%@",error);
        [resetPasswordVC promptViewmessage:@"网络失败" sureBlock:^{
        }];
    } showHUD:NO sucessMsg:@"" failureMsg:@"修改失败"];
}
#pragma mark--提示框
-(void)promptViewmessage:(NSString *)message sureBlock:(void(^)())sureBlock{
    UIAlertController * alert= [UICommonView showOneAlertWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确实" sureBlock:^{
        sureBlock();
    }];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark --textField代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.lastTextField = textField;
    UITextField *newPWD = [self.view viewWithTag:12];//xin
    UITextField *pwdtext = [self.view viewWithTag:13];
    if ([newPWD.text isEqualToString:@""]) {
        return;
    }else{
        if (newPWD.text.length>=6&&newPWD.text.length<=16){
            if ([self checkUsername]){
            }else{
                [self promptViewmessage:@"密码不能包含特殊符号,请重新输入" sureBlock:^{
                    textField.text=@"";
                }];
            }
        }else{
            [self promptViewmessage:@"密码为6~16位" sureBlock:^{
                textField.text=@"";
            }];
        }
        if (textField==pwdtext){
            if ([newPWD.text isEqualToString: pwdtext.text]) {
                
            }else{
                [self promptViewmessage:@"两次输入密码不相同,请重新输入" sureBlock:^{
                    
                }];
            }
        }
    }
}
//正则表达式
- (BOOL)checkUsername  {
    UITextField *pwdtext = [self.view viewWithTag:12];//密码
    NSString * regex = @"^[A-Za-z0-9]{6,16}$";
    //正则表达式
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //Cocoa框架中的NSPredicate用于查询，原理和用法都类似于SQL中的where，作用相当于数据库的过滤取
    BOOL isMatch = [pred evaluateWithObject:pwdtext.text];
    //判读userNameField的值是否吻合
    return isMatch;
}
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
