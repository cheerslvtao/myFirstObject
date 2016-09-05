





//
//  ChangePasswordVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/2.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "ChangePasswordVC.h"
#define ChangePassword @"/userAccount/changeassword"
@interface ChangePasswordVC ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField *lastTextField;
@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    //导航完成按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_width-50, 24, 40, 40);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BGCOLOR;
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    //输入框
    NSArray *array = @[@"  原密码",@"  输入密码",@"  确认密码"];
    for (int i=0; i<3; i++)
    {
        LeeAllView *leeView = [[LeeAllView alloc]init];
      UIView *view = [leeView registeredViewWithFrame:CGRectMake(10, 100+(65*i), SCREEN_width-20, 50)];
        leeView.textField.secureTextEntry = YES;
        leeView.textField.tag = i+10;
        leeView.textField.placeholder = @"请输入6~16位密码";
        leeView.textField.delegate = self;
        leeView.titerLabel.text = array[i];
        [self.view addSubview:view];
    }
    // Do any additional setup after loading the view.
}
#pragma mark--按钮事件
-(void)buttonClick
{
     UITextField *oldPWD = [self.view viewWithTag:10];
    UITextField *newPWD = [self.view viewWithTag:12];
    UITextField *pwdtext = [self.view viewWithTag:11];
    if ([oldPWD.text isEqualToString:@""]||[newPWD.text isEqualToString:@""]||[pwdtext.text isEqualToString:@""]) {
        [self promptViewmessage:@"资料填写不完善 请完善资料" sureBlock:^{
            
        }];
    }else{
        if ([newPWD.text isEqualToString: pwdtext.text]){
            NSLog(@"完成");
            __weak typeof(self)changePwd = self;
            AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
            // manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager POST:LINK_BASE_URL(ChangePassword) parameters:@{@"old_pwd":oldPWD.text,@"new_pwd":newPWD.text,@"access_token":ACCESS_TOKEN} progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                NSString *str = [NSString stringWithFormat:@"%@",responseObject[@"msg"]];
                [changePwd promptViewmessage:str sureBlock:^{
                    if ([responseObject[@"code"]isEqualToString:@"001"]){
                        [USER_D setObject:newPWD.text forKey:@"password"];
                        [USER_D synchronize];
                        [changePwd.navigationController popViewControllerAnimated:YES];
                    }
                }];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
        }else{
            [self promptViewmessage:@"两次输入密码不相同,请重新输入" sureBlock:^{
            }];
        }
    }
}
#pragma mark--收起键盘
//收起键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;{
    [self.view endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.lastTextField = textField;
    UITextField *newPWD = [self.view viewWithTag:12];
    UITextField *pwdtext = [self.view viewWithTag:11];
    if ([newPWD.text isEqualToString:@""]||[pwdtext.text isEqualToString:@""]) {
        return;
    }else{
        if (textField.text.length>=6&&textField.text.length<=16)
        {
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
        if (textField==newPWD){
            if ([newPWD.text isEqualToString: pwdtext.text]) {
            }else{
                [self promptViewmessage:@"两次输入密码不相同,请重新输入" sureBlock:^{
                    
                }];
            }
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
//正则表达式
- (BOOL)checkUsername  {
    NSString * regex = @"^[A-Za-z0-9]{6,16}$";
    //正则表达式
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //Cocoa框架中的NSPredicate用于查询，原理和用法都类似于SQL中的where，作用相当于数据库的过滤取
    BOOL isMatch = [pred evaluateWithObject:self.lastTextField.text];
    //判读userNameField的值是否吻合
    return isMatch;
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
