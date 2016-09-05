

//
//  RetrievePasswordVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/28.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "RetrievePasswordVC.h"
#import "ResetPasswordVC.h"//重置密码
#define GetPwdEmail @"/userAccount/findBackPassword"

@interface RetrievePasswordVC ()<UITextFieldDelegate>

@end

@implementation RetrievePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.view.backgroundColor = BGCOLOR;
    [self addView];//添加视图
    // Do any additional setup after loading the view.
}
#pragma mark --添加View
- (void)addView
{
    NSArray *array = @[@"  注册邮箱"];
    LeeAllView *leeAllView = [LeeAllView new];
    for (int i=0; i<array.count; i++)
    {
        UIView *view = [leeAllView registeredViewWithFrame:CGRectMake(15, 100+(65*i), SCREEN_width-30, 50)];
        leeAllView.titerLabel.text = array[i];
        leeAllView.textField.tag = i+10;
        leeAllView.textField.delegate = self;
        [self.view addSubview:view];
    }
    //发送重置邮件按钮
    UIButton *button = [LeeAllView BigButton:CGRectMake(15, 200, SCREEN_width-30, 50) withTitel:@"发送重置邮件"];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
#pragma mark --发送邮件事件
- (void)buttonClick
{

    UITextField *emailText = [self.view viewWithTag:10];
    
    if ([emailText.text isEqualToString:@""]) {
        [self promptViewmessage:@"请完善信息" sureBlock:^{
            
        }];
    }else{
        if ([self isValidateEmail:emailText.text]){
       __weak RetrievePasswordVC *retrievePasswordVC = self;
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager POST:LINK_BASE_URL(GetPwdEmail) parameters:@{@"email":emailText.text} progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                //成功
                NSString *str = responseObject[@"msg"];
                if ([[responseObject[@"success"] stringValue]isEqualToString:@"1"]){
                    //提示框
                    [retrievePasswordVC promptViewmessage:str sureBlock:^{
                        //跳转
                        ResetPasswordVC *resetPassword = [ResetPasswordVC new];
                        [retrievePasswordVC.navigationController pushViewController:resetPassword animated:YES];
                    }];
                }else{
                    [retrievePasswordVC promptViewmessage:str sureBlock:^{
                        
                    }];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //提示框
                NSLog(@"%@",error);
                [retrievePasswordVC promptViewmessage:@"发送失败" sureBlock:^{
//                    ResetPasswordVC *resetPassword = [ResetPasswordVC new];
//                    [retrievePasswordVC.navigationController pushViewController:resetPassword animated:YES];
                }];
            }];
        }else{
            [self promptViewmessage:@"请输入正确的邮箱号" sureBlock:^{
                emailText.text = @"";
            }];
        }
    }
    
}
#pragma mark --textField代理方法
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==10) {
    }else{
        if ([self isValidateEmail:textField.text]) {
        }else{
            [self promptViewmessage:@"请输入正确的邮箱号" sureBlock:^{
                textField.text = @"";
            }];
        }
    }
}
//提示框
-(void)promptViewmessage:(NSString *)message sureBlock:(void(^)())sureBlock{
    UIAlertController * alert= [UICommonView showOneAlertWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确实" sureBlock:^{
        sureBlock();
    }];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark --邮箱格式
//邮箱格式
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//收起键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;{
    [self.view endEditing:YES];
}
-(void)httpRquest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:LINK_BASE_URL(GetPwdEmail) parameters:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
