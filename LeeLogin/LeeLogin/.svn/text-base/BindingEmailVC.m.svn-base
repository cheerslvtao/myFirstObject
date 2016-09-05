



//
//  BindingEmailVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/29.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "BindingEmailVC.h"
#define sendBindEmial @"/userAccount/sendBindEmial"
#define bindEmail @"/userAccount/bindEmail"
@interface BindingEmailVC ()<UITextFieldDelegate>

@end

@implementation BindingEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定邮箱";
    //导航完成按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_width-50, 24, 40, 40);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BGCOLOR;
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
        [button setTitle:@"发送验证" forState:UIControlStateNormal];
        button.frame = CGRectMake(SCREEN_width-90, 24, 80, 80);
        UILabel *label = [LeeAllView allLabelWith:CGRectMake(10, 220, SCREEN_width-30, 90) withTextColor:TEXTCOLOR];
        label.text = @"注:请输入您绑定的邮箱账号,发送验证邮件,进入邮箱内确认连接完成绑定。";
        label.numberOfLines = 0;
        [self.view addSubview:label];
    [self textfieldView];
    // Do any additional setup after loading the view.
}
#pragma mark --按钮事件
//发送验证按钮
-(void)buttonClick
{
     UITextField *firstText = [self.view viewWithTag:10];
    if ([firstText.text isEqualToString:@""]) {
        [self promptViewmessage:@"请完善信息" sureBlock:^{
            
        }];
    }else{
        if ([self isValidateEmail:firstText.text]) {
            __weak BindingEmailVC *bindingEmailVC = self;
            [HTTPURL postRequest:LINK_BASE_URL(sendBindEmial) parameters:@{@"email":firstText.text,@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                NSString *str = responseObject[@"msg"];
                [bindingEmailVC promptViewmessage:str sureBlock:^{
                    
                }];
            } filure:^(NSURLSessionDataTask *task, id error) {
                
            } showHUD:YES sucessMsg:@"" failureMsg:@""];
        }else{
            [self promptViewmessage:@"请输入正确的邮箱号" sureBlock:^{
                firstText.text = @"";
            }];
        }
    }
}
-(void)BangbuttonClick{
    //绑定按钮
    UITextField *firstText = [self.view viewWithTag:10];
    UITextField *secondText = [self.view viewWithTag:11];
    __weak BindingEmailVC *bindingEmailVC = self;
    if ([firstText.text isEqualToString:@""]||[secondText.text isEqualToString:@""]) {
        [self promptViewmessage:@"邮箱或验证码为空,请填写完整" sureBlock:^{
            
        }];
    }else{
        [HTTPURL postRequest:LINK_BASE_URL(bindEmail) parameters:@{@"bindCode":secondText.text,@"email":firstText.text,@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *str = @"";
            if ([responseObject[@"code"] isEqualToString:@"001"]) {
                str = responseObject[@"msg"];
                [USER_D setObject:firstText.text forKey:@"邮箱"];
                [USER_D synchronize];
                [bindingEmailVC.navigationController popViewControllerAnimated:YES];
            }else{
                str = responseObject[@"msg"];
            }
            [bindingEmailVC promptViewmessage:str sureBlock:^{
                
            }];
        } filure:^(NSURLSessionDataTask *task, id error) {
            
        } showHUD:YES sucessMsg:@"" failureMsg:@""];
    }
}
#pragma mark -- 输入视图
-(void)textfieldView{
        UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(10,100,SCREEN_width-20,50 )];
        textField.backgroundColor = [UIColor whiteColor];
        textField.tag = 10;
       textField.placeholder = @"请输入邮箱";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.font = THIRTEEN;//字体大小
        textField.delegate = self;
        [self.view addSubview:textField];
    LeeAllView *leeAllView = [LeeAllView new];
    UIView *view = [leeAllView registeredViewWithFrame:CGRectMake(10, 170, SCREEN_width-20, 50)];
   leeAllView.titerLabel.text = @"  验证码";
    leeAllView.textField.tag = 11;
    leeAllView.textField.delegate = self;
    [self.view addSubview:view];
    UIButton *button = [LeeAllView BigButton:CGRectMake(15, 310, SCREEN_width-30, 50) withTitel:@" 绑 定 邮 箱 "];
    [button addTarget:self action:@selector(BangbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark --邮箱格式
//邮箱格式
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark -- 键盘下去
#pragma mark --textField代理方法
//提示框
-(void)promptViewmessage:(NSString *)message sureBlock:(void(^)())sureBlock{
    UIAlertController * alert= [UICommonView showOneAlertWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确实" sureBlock:^{
        sureBlock();
    }];
    [self presentViewController:alert animated:YES completion:nil];
}



-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
