//
//  RegisteredVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/27.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "RegisteredVC.h"
#import "LeeAllView.h"
#import "HomePageViewController.h"//首页
#import "RegistrationTermsVC.h"//注册条款
#import "RegistrationPromptVC.h"//注册提示
#define REGISTERED @"/userAccount/reg"//注册
#define LOGIN @"/userAccount/login"//登录
#define TJVE @"/userAccount/getNameByVeCode"//获取推荐人姓名
@interface RegisteredVC ()<UITextFieldDelegate,sendvaluedelegate>
{
    UITextField*_editingTextField;//
    CGFloat keyboardHeight;
    CGFloat durationTime;
    UIScrollView *scrollView;
    BOOL lastButton;//注册条例
    NSMutableArray *_tagArray;
    int ISphone;//校验手机号码是否正确
}
@property (nonatomic,copy)NSString *promptStr;//注册成功失败以及原因的提示
@end

@implementation RegisteredVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册界面
    self.navigationController.navigationBarHidden =NO;
    self.title = @"会员注册";
    _tagArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = BGCOLOR;
    [self loadingView];//加载视图
    
    // Do any additional setup after loading the view.
}
//加载视图
#pragma mark --加载视图
-(void)loadingView
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height)];
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    scrollView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:247/255.0 alpha:1];
    scrollView.contentSize = CGSizeMake(SCREEN_width, 620);
    [self.view addSubview:scrollView];
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //给view添加一个手势监测；
    [scrollView addGestureRecognizer:singleRecognizer];
    LeeAllView *leeAllView = [LeeAllView new];
    NSArray *array = @[@"  推荐人VE",@"  推荐人",@"  昵称",@"  电话",@"  密码",@"  确认密码"];
    for (int i=0; i<array.count; i++) {
        
      UIView *view = [leeAllView registeredViewWithFrame:CGRectMake(15, 25+(65*i), SCREEN_width-30, 50)];
        leeAllView.titerLabel.text = array[i];
        leeAllView.textField.tag = view.frame.origin.y;
        leeAllView.textField.delegate = self;
        if (i==6) {
            leeAllView.textField.frame = CGRectMake(100, 0,view.frame.size.width-181, view.frame.size.height);
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width-90, 0, 90, view.frame.size.height)];
            [view addSubview:imgView];
            
        }
        if (i==4||i==5) {
            leeAllView.textField.secureTextEntry = YES;
            leeAllView.textField.placeholder = @"请输入6~16位密码";
        }
        NSString *tagStr = [NSString stringWithFormat:@"%ld",(long)leeAllView.textField.tag];
        [_tagArray addObject:tagStr];
         [scrollView addSubview:view];
    }
    //对勾按钮
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    but.frame = CGRectMake(30,430, 30, 30);
    [scrollView addSubview:but];
    UILabel *yesLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 430, 40, 30)];
    yesLabel.text = @"同意";
    yesLabel.font = THIRTEEN;
    [scrollView addSubview:yesLabel];
    //注册条款按钮
    UIButton *termsBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [termsBut addTarget:self action:@selector(termsButClicled) forControlEvents:UIControlEventTouchUpInside];
    [termsBut setTitleColor:[UIColor colorWithRed:0/255.0 green:133/255.0 blue:220/255.0 alpha:1] forState:UIControlStateNormal];
    [termsBut setTitle:@"注册条款" forState:UIControlStateNormal];
    termsBut.titleLabel.font = THIRTEEN;//设置字体大小
    termsBut.frame = CGRectMake(110,430, 120, 30);
    [scrollView addSubview:termsBut];
    //登录按钮
    UIButton *loginBut = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBut.frame = CGRectMake(15, 480, SCREEN_width-30, 50);
    [loginBut addTarget:self action:@selector(loginButClicled) forControlEvents:UIControlEventTouchUpInside];
    loginBut.titleLabel.font = THIRTEEN;
    [loginBut setTitle:@"登  录" forState:UIControlStateNormal];
    loginBut.backgroundColor = COLOR(62, 94, 149, 1);
    //按钮编辑
    [loginBut.layer setMasksToBounds:YES];
    //边框圆角半径
    [loginBut.layer setCornerRadius:10.0];
    [scrollView addSubview:loginBut];
    
}
#pragma mark--登录按钮事件(填写推荐人的注册请求)
- (void)loginButClicled
{
    UITextField *recText =[self.view viewWithTag:[[_tagArray objectAtIndex:0]intValue]];//推荐人VE
    //UITextField *recname =[self.view viewWithTag:[[_tagArray objectAtIndex:1]intValue]];//推荐人VE姓名
    UITextField *nickNameText =[self.view viewWithTag:[[_tagArray objectAtIndex:2]intValue]];//昵称
    UITextField *phoneText =[self.view viewWithTag:[[_tagArray objectAtIndex:3]intValue]];//手机号
    UITextField *pwdText =[self.view viewWithTag:[[_tagArray objectAtIndex:4]intValue]];//密码
    UITextField *confirmText =[self.view viewWithTag:[[_tagArray objectAtIndex:5]intValue]];//确认密码
    /*
     *判断手机号是否正确  1  代表正确
     *
     */
    if (ISphone==1){  
    /*
     *判断是否同意注册条款 1 代表同意
     */
    if (lastButton==1){
        /*
         *判断是否为空 如果为空提示
         */
        if ([nickNameText.text isEqualToString:@""]||[phoneText.text isEqualToString:@""]||[pwdText.text isEqualToString:@""]||[confirmText.text isEqualToString:@""]){
            [self promptViewmessage:@"资料填写不完善 请完善资料" sureBlock:^{
                
            }];
        }else{
            /*
             *判断是否填写推荐人 如果没有跳转提示
             */
            if ([recText.text isEqualToString:@""]){
                //如果推荐人为空跳转提示
                RegistrationPromptVC *PromptVC = [RegistrationPromptVC new];
                PromptVC.delegate =self;
                [self.navigationController pushViewController:PromptVC animated:YES];
                
            }else{
            //请求
           __weak typeof(self)  regist = self;
                /*
                 *发送注册请求
                 */
                //注册请求
                [HTTPURL postRequest:LINK_BASE_URL(REGISTERED) parameters:@{@"rec":recText.text,@"pwd":pwdText.text,@"IP":IP,@"nick_name":nickNameText.text,@"phone":phoneText.text} success:^(NSURLSessionDataTask *task, id responseObject)
                 {
                    NSLog(@"%@",responseObject);
                    NSLog(@"%@",responseObject[@"success"]);
                    NSLog(@"%@",responseObject[@"msg"]);
                     _promptStr = responseObject[@"msg"];
                    /*
                     *如果正确  success = 1 代表正确
                     */
                    if ([[responseObject[@"success"] stringValue]isEqualToString:@"1"]){
                        _promptStr = responseObject[@"msg"];
                        [USER_D setObject:responseObject[@"data"][@"ve_code"] forKey:@"ve_code"];
                        NSString *ve_code = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"ve_code"]];
                        /*
                         *需要内部做登录 获得secret驿码 进行授权请求
                         */
                        //发送登录请求获得secret驿码
                        [HTTPURL postRequest:LINK_BASE_URL(LOGIN) parameters:@{@"ve_code":ve_code,@"pwd":pwdText.text,@"IP":IP} success:^(NSURLSessionDataTask *task, id responseObject) {
                            NSLog(@"~~~~~~~%@",responseObject);
                            NSLog(@"%@",responseObject[@"msg"]);
                            [USER_D setObject:responseObject[@"data"][@"secret"] forKey:@"secret"];//驿码
                            /*
                             *获得驿码成功 code = 012 代表正确,发送授权请求
                             */
                            //跳转页面
                            if ([responseObject[@"code"] isEqualToString:@"012"]){
                                NSLog(@"%d",[responseObject[@"code"]intValue]);
                                /*
                                 *发送授权请求  将token保存本地
                                 */
                                [HTTPURL authorizationsuccess:^(NSURLSessionDataTask *task, id responseObject) {
                                    NSLog(@"%@",responseObject);
                                    [USER_D setObject:responseObject[@"value"] forKey:@"token"];
                                    [USER_D synchronize];
                                    [USER_D setBool:lastButton forKey:@"remember"];
                                    NSString *str = [NSString stringWithFormat:@"VE号:%@",ve_code];
                                    /*
                                     *成功 弹出VE号
                                     */
                                    UIAlertController * alert = [UICommonView showOneAlertWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" sureBlock:^{
                                        HomePageViewController *vc = [HomePageViewController new];
                                        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
                                        UIWindow *window =[[UIApplication  sharedApplication].delegate window];
                                        window.rootViewController = nvc;
                                    }];
                                    [regist presentViewController:alert animated:YES completion:nil];
                                } Success:^(NSURLSessionDataTask *task, id responseObject) {
                                    
                                }];//授权
                                
                            }else{
                                UIAlertController * alert = [UICommonView showOneAlertWithTitle:@"提示" message:responseObject[@"msg"] preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" sureBlock:^{
                                    
                                }];
                                [regist presentViewController:alert animated:YES completion:nil];
                            }
                        } filure:^(NSURLSessionDataTask *task, id error) {
                        } showHUD:NO sucessMsg:@"" failureMsg:@""];
                    }else{
                        //code 不等于1  代表错误
                        [regist promptViewmessage:_promptStr sureBlock:^{
                            
                        }];
                    }

                } filure:^(NSURLSessionDataTask *task, id error) {

                } showHUD:YES sucessMsg:@"" failureMsg:@"注册失败"];
                
                [USER_D setObject:recText.text forKey:@"referees"];//推荐人
                [USER_D setObject:phoneText.text forKey:@"phone"];//手机号
                [USER_D setObject:pwdText.text forKey:@"password"];//密码
                [USER_D setObject:nickNameText.text forKey:@"nickName"];//昵称
            }
        }
    }else{
        //提示
        [self promptViewmessage:@"请同意注册条款" sureBlock:^{
            
        }];
    }
    }else{
        [self promptViewmessage:@"请输入正确的手机号" sureBlock:^{
            phoneText.text = @"";
        }];
    }
}
//注册条款
#pragma mark --注册条款
-(void)termsButClicled
{
    RegistrationTermsVC *TermsVC = [RegistrationTermsVC new];
    [self.navigationController pushViewController:TermsVC animated:YES];
    NSLog(@"注册条款");
}
//发送注册请求
#pragma mark --注册请求(没有填写VE人的注册请求)
- (void)refresh
{
    UITextField *recText =[self.view viewWithTag:[[_tagArray objectAtIndex:0]intValue]];//推荐人
    UITextField *nickNameText =[self.view viewWithTag:[[_tagArray objectAtIndex:2]intValue]];//昵称
    UITextField *phoneText =[self.view viewWithTag:[[_tagArray objectAtIndex:3]intValue]];//手机号
    UITextField *pwdText =[self.view viewWithTag:[[_tagArray objectAtIndex:4]intValue]];//密码
    [USER_D setObject:pwdText.text forKey:@"password"];
    __weak RegisteredVC *regist = self;
    NSLog(@"%@%@%@",nickNameText.text,phoneText.text,pwdText.text);
    //注册请求
    [HTTPURL postRequest:LINK_BASE_URL(REGISTERED) parameters:@{@"pwd":pwdText.text,@"IP":IP,@"nick_name":nickNameText.text,@"phone":phoneText.text} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSLog(@"%@",responseObject[@"msg"]);
        _promptStr = responseObject[@"msg"];
        if ([[responseObject[@"success"] stringValue] isEqualToString:@"1"])//注册成功
        {
            _promptStr = responseObject[@"msg"];
            [USER_D setObject:responseObject[@"data"][@"ve_code"] forKey:@"ve_code"];//VE号存本地
            NSString *ve_code = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"ve_code"]];//获取VE号
            //登录请求获得secret驿码(发送登录请求)
            [HTTPURL postRequest:LINK_BASE_URL(LOGIN) parameters:@{@"ve_code":ve_code,@"pwd":pwdText.text,@"IP":IP} success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"~~~~~~~%@",responseObject);
                NSLog(@"%@",responseObject[@"msg"]);
                NSString *secret = responseObject[@"data"][@"secret"];
                [USER_D setObject:responseObject[@"data"][@"ve_code"] forKey:@"ve_code"];//ve号
                [USER_D setObject:secret forKey:@"secret"];
                [USER_D synchronize];
                //跳转页面
                    NSLog(@"%d",[responseObject[@"code"]intValue]);
                    //发送授权请求
                    [HTTPURL authorizationsuccess:^(NSURLSessionDataTask *task, id responseObject) {
                        NSLog(@"%@",responseObject);
                        [USER_D setObject:responseObject[@"value"] forKey:@"token"];
                        [USER_D synchronize];
                            HomePageViewController *vc = [HomePageViewController new];
                            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
                            UIWindow *window =[[UIApplication  sharedApplication].delegate window];
                            window.rootViewController = nvc;
                    } Success:^(NSURLSessionDataTask *task, id responseObject) {
                        //授权失败
                        NSLog(@"%@",responseObject);
                    }];
                
                
            } filure:^(NSURLSessionDataTask *task, id error) {
                [regist promptViewmessage:@"网络失败" sureBlock:^{
                }];
            } showHUD:NO sucessMsg:@"" failureMsg:@""];

        }else{
            [regist promptViewmessage:_promptStr sureBlock:^{
                
            }];
            NSLog(@"!!!!!!!!!!请求成功");
        }
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"%@",error);
        //注册失败
    }showHUD:YES sucessMsg:_promptStr failureMsg:@"注册失败"];
    [USER_D setObject:recText.text forKey:@"推荐人"];//推荐人
    [USER_D setObject:phoneText.text forKey:@"联系方式"];//手机号
    [USER_D setObject:pwdText.text forKey:@"password"];//密码
    [USER_D setObject:nickNameText.text forKey:@"昵称"];//昵称
}
//同意条款按钮
#pragma mark --同意条款按钮事件
-(void)rightButton:(UIButton *)button
{
    if (lastButton==0) {
        [button setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateNormal];
    }else{
    [button setImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    }
    lastButton = !lastButton;
    NSLog(@"对勾按钮");
}
#pragma mark--键盘代理方法
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //使用NSNotificationCenter 键盘出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 键盘隐藏时
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark == 处理键盘覆盖问题  textfiled代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _editingTextField=textField;
    /*
     *推荐人姓名 不能进行编辑
     */
    if (textField ==[self.view viewWithTag:[[_tagArray objectAtIndex:1]intValue]])
    {
        [textField setEnabled:NO];
    }
    NSLog(@"%ld", (long)textField.tag);
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"");
    /*
     *判断匹配推荐人姓名
     */
    if (textField == [self.view viewWithTag:[[_tagArray objectAtIndex:0]intValue]])
    {
        //匹配推荐人姓名
        RegisteredVC *registered = self;
       [ HTTPURL postRequest:LINK_BASE_URL(TJVE) parameters:@{@"ve_code":textField.text} success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"%@",responseObject);
           /*
            *如果推荐人等级不够 不能做为别人的推荐人
            */
            UITextView *TJRtext = [self.view viewWithTag:[[_tagArray objectAtIndex:1]intValue]];
           NSString *veStr = responseObject[@"data"];
           NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
           if ([code isEqualToString:@"001"]) {
               if ([veStr isEqualToString:@"-1"]) {
                   TJRtext.text = @"";
               }else{
                   TJRtext.text = veStr;
               }
           }else{
               [registered promptViewmessage:responseObject[@"msg"] sureBlock:^{
                   TJRtext.text = @"";
                   textField.text = @"";
               }];
           }
        } filure:^(NSURLSessionDataTask *task, id error) {
            [registered promptViewmessage:@"获取推荐人失败" sureBlock:^{
                
            }];
        }showHUD:NO sucessMsg:@"" failureMsg:@""];
    }
    
    /*
     *判断是否有特殊符号
     */

    if (textField == [self.view viewWithTag:[[_tagArray objectAtIndex:4]intValue]])
    {
        if (textField.text.length>=6&&textField.text.length<=16)
        {
            if ([self checkUsername]) {
                
            }else
            {
                [self promptViewmessage:@"密码不能包含特殊符号,请重新输入" sureBlock:^{
                    textField.text=@"";
                }];
            }
        }else{
            [self promptViewmessage:@"密码为6~16位" sureBlock:^{
                textField.text=@"";
            }];
        }
        
    }
    /*
     *判断确认密码是否于密码相同
     */

    //判断确认密码是否于密码相同
    if (textField == [self.view viewWithTag:[[_tagArray objectAtIndex:5]intValue]]) {
        UITextField *newPWD =[self.view viewWithTag:[[_tagArray objectAtIndex:4]intValue]];
        if ([textField.text isEqualToString:newPWD.text]) {
            if (textField.text.length>+6||textField.text.length<+16) {
                if ([self checkUsername]==YES) {
                    
                }else{
                    [self promptViewmessage:@"密码不能包含特殊符号,请重新输入" sureBlock:^{
                        textField.text=@"";
                    }];
                }
            }else{
                [self promptViewmessage:@"密码为6~16位" sureBlock:^{
                   textField.text = @"";
                }];
            }
            //提示框
            NSLog(@"%@====%@",textField.text,newPWD.text);
            
        }else{
            [self promptViewmessage:@"确认密码不相同,请重新输入" sureBlock:^{
                textField.text = @"";
            }];
        }
    }
    
    //键盘覆盖
    [UIView animateWithDuration:durationTime animations:^{
        scrollView.frame = CGRectMake(scrollView.frame.origin.x, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    }];
    /*
     *校验手机号
     *
     */
    if (textField == [self.view viewWithTag:[[_tagArray objectAtIndex:3]integerValue]])
    {
        if (textField.text.length == 11)
        {
            ISphone =1;
            /**
             * 移动号段正则表达式
             */
            NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
            /**
             * 联通号段正则表达式
             */
            NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
            /**
             * 电信号段正则表达式
             */
            NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
            BOOL isMatch1 = [pred1 evaluateWithObject:textField.text];
            NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
            BOOL isMatch2 = [pred2 evaluateWithObject:textField.text];
            NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
            BOOL isMatch3 = [pred3 evaluateWithObject:textField.text];
            
            if (isMatch1 || isMatch2 || isMatch3) {
                
            }else{
                [self promptViewmessage:@"请输入正确的手机号" sureBlock:^{
                    textField.text = @"";
                }];
            }
        }else{
            ISphone=2;
            [self promptViewmessage:@"请输入11位的手机号" sureBlock:^{
                textField.text = @"";
            }];
        }
    }
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即为键盘尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到键盘的高度
    durationTime = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]; //得到键盘动画时间
    NSLog(@"time : %f",durationTime);
    NSLog(@"++height:%f",kbSize.height);
    keyboardHeight = kbSize.height;
    if (SCREEN_height - keyboardHeight-64 <= _editingTextField.tag) {
        CGFloat y = _editingTextField.tag - (SCREEN_height - keyboardHeight-120);
        [UIView animateWithDuration:durationTime animations:^{
            scrollView.frame = CGRectMake(scrollView.frame.origin.x, -y, scrollView.frame.size.width, scrollView.frame.size.height);
        }];
    }
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即为键盘尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"--height:%f",kbSize.height);
    keyboardHeight = kbSize.height;
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
//提示框
-(void)promptViewmessage:(NSString *)message sureBlock:(void(^)())sureBlock
{
    UIAlertController * alert= [UICommonView showOneAlertWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确实" sureBlock:^{
        sureBlock();
    }];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark == 收起键盘
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    NSLog(@"点击了");
    [self.view endEditing:YES];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//正则表达式
- (BOOL)checkUsername {
    UITextField *pwdText =[self.view viewWithTag:[[_tagArray objectAtIndex:4]intValue]];//密码

    NSString * regex = @"^[A-Za-z0-9]{6,16}$";
    //正则表达式
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //Cocoa框架中的NSPredicate用于查询，原理和用法都类似于SQL中的where，作用相当于数据库的过滤取
    BOOL isMatch = [pred evaluateWithObject:pwdText.text];
    //判读userNameField的值是否吻合
    return isMatch;
}

- (void)backButClicled{
    __weak typeof(self) weakself = self;
    [self.view endEditing:YES];
    UIAlertController * alert = [UICommonView showTwoAlertWithTitle:@"提示" message:@"您确定要放弃吗？" preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" cancelTitle:@"继续注册" sureBlock:^{
        [weakself.navigationController popViewControllerAnimated:YES];
    } cancelBlock:^{
        
    }];
    [self presentViewController:alert animated:YES completion:nil];
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
