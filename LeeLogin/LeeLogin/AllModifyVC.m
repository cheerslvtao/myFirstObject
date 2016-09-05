



//
//  AllModifyVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/2.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "AllModifyVC.h"
#import "PersonalInformationVC.h"
#define TJVE @"/userAccount/getNameByVeCode"//获取推荐人姓名
@interface AllModifyVC ()<UITextFieldDelegate>
{
    UITextField *_textField;
    NSString *buttonTiter;
    NSArray *_chooseArr;
    UIButton * lastButton;
    NSString *_TVEStr;
    int ISphone;//校验手机号码是否正确
}
@end

@implementation AllModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    //导航完成按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_width-50, 24, 40, 40);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BGCOLOR;
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    if ([_titleString isEqualToString:@"邮箱"]){
        [button setTitle:@"发送验证" forState:UIControlStateNormal];
        button.frame = CGRectMake(SCREEN_width-90, 24, 80, 80);
        UILabel *label = [LeeAllView allLabelWith:CGRectMake(10, 160, SCREEN_width-30, 90) withTextColor:TEXTCOLOR];
        label.text = @"注:请输入您绑定的邮箱账号,发送验证邮件,进入邮箱内确认连接完成绑定。";
        label.numberOfLines = 0;
        [self.view addSubview:label];
        [self textfieldView];//输入框
    }else{
        if ([_titleString isEqualToString:@"企业员工"]||[_titleString isEqualToString:@"婚姻状况"]||[_titleString isEqualToString:@"有无子女"]||[_titleString isEqualToString:@"政治面貌"]||[_titleString isEqualToString:@"养老保险"]||[_titleString isEqualToString:@"人寿保险"]){
            if ([_titleString isEqualToString:@"企业员工"]){
                _chooseArr = @[@"是",@"否"];
            }else if ([_titleString isEqualToString:@"有无子女"]||[_titleString isEqualToString:@"养老保险"]||[_titleString isEqualToString:@"人寿保险"]){
                _chooseArr = @[@"有",@"无"];
            }else if ([_titleString isEqualToString:@"政治面貌"]){
                _chooseArr = @[@"团员",@"党员",@"积极分子",@"群众"];
            }else if ([_titleString isEqualToString:@"婚姻状况"]){
                _chooseArr = @[@"已婚",@"未婚"];
            }
            [self chooseView];//选择按钮
        }else{
            [self textfieldView];//输入框
        }
        [button setTitle:@"完成" forState:UIControlStateNormal];
        button.frame = CGRectMake(SCREEN_width-50, 24, 40, 40);
    }
    // Do any additional setup after loading the view.
}
#pragma mark -- 完成按钮
- (void)buttonClick
{
    if ([_titleString isEqualToString:@"企业员工"]||[_titleString isEqualToString:@"婚姻状况"]||[_titleString isEqualToString:@"有无子女"]||[_titleString isEqualToString:@"政治面貌"]||[_titleString isEqualToString:@"养老保险"]||[_titleString isEqualToString:@"人寿保险"]){
        _textString = buttonTiter;
        if (_textString==nil) {
            [self promptViewmessage:@"尚未选择,请选择" sureBlock:^{
                return ;
            }];
        }else{
            [USER_D setObject:_textString forKey:_titleString];
            [USER_D synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if ([_textField.text isEqualToString:@""]) {
            [self promptViewmessage:@"输入为空,请重新输入" sureBlock:^{
                return ;
            }];
        }else{
            if ([_titleString isEqualToString:@"推荐人"])
            {
                [self requstVE];//获取推荐人
            }else{
                if ([_titleString isEqualToString:@"联系方式"])
                {
                    
                    if (_textField.text.length == 11)
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
                        BOOL isMatch1 = [pred1 evaluateWithObject:_textField.text];
                        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                        BOOL isMatch2 = [pred2 evaluateWithObject:_textField.text];
                        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                        BOOL isMatch3 = [pred3 evaluateWithObject:_textField.text];
                        
                        if (isMatch1 || isMatch2 || isMatch3) {
                            
                        }else{
                            [self promptViewmessage:@"请输入正确的手机号" sureBlock:^{
                                _textField.text = @"";
                            }];
                        }
                    }else{
                        ISphone=2;
                        [self promptViewmessage:@"请输入11位的手机号" sureBlock:^{
                            _textField.text = @"";
                        }];
                    }
                }
                [self.delegate refreshList];//回调刷新
                NSLog(@"%@",_textField.text);
                NSLog(@"%@",_titleString);
                _textString = _textField.text;
                [USER_D setObject:_textString forKey:_titleString];
                [USER_D synchronize];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    _textString = [NSString stringWithFormat:@"%@",textField.text];
    NSLog(@"%@",_textString);
    
}
//推荐人请求
-(void)requstVE
{
    //匹配推荐人姓名
    __weak AllModifyVC *allModifyVC = self;
    [ HTTPURL postRequest:LINK_BASE_URL(TJVE) parameters:@{@"ve_code":_textField.text} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        /*
         *如果推荐人等级不够 不能做为别人的推荐人
         */
        NSString *veStr = responseObject[@"data"];
        if ([veStr isEqualToString:@"-1"])
        {
            [allModifyVC promptViewmessage:@"推荐人账号未实名认证，请重新填写" sureBlock:^{
                _textField.text = @"";
            }];
        }else{
            if ([responseObject[@"code"] isEqualToString:@"001"]) {

                _TVEStr = _textField.text;
                _textField.text = responseObject[@"data"];
                _textString = _textField.text;
                [USER_D setObject:_TVEStr forKey:@"recVeCode"];
                [USER_D setObject:_textString forKey:_titleString];
                [USER_D synchronize];
                NSString *str = [NSString stringWithFormat:@"推荐人:%@",_textString];
                UIAlertController * alert = [UICommonView showTwoAlertWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" cancelTitle:@"取消" sureBlock:^{
                    [allModifyVC.navigationController popViewControllerAnimated:YES];
                } cancelBlock:^{
                    _textField.text = @"";
                }];
                [allModifyVC presentViewController:alert animated:YES completion:nil];
            }else{
                [allModifyVC promptViewmessage:responseObject[@"msg"] sureBlock:^{
                    _textField.text = @"";
                }];
            }
        }
    } filure:^(NSURLSessionDataTask *task, id error) {
        [allModifyVC promptViewmessage:@"获取推荐人失败" sureBlock:^{
            
        }];
    }showHUD:NO sucessMsg:@"" failureMsg:@""];
}
//提示框
-(void)promptViewmessage:(NSString *)message sureBlock:(void(^)())sureBlock
{
    UIAlertController * alert= [UICommonView showOneAlertWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确实" sureBlock:^{
        sureBlock();
    }];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark -- 输入视图
-(void)textfieldView
{
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10,100,SCREEN_width-20,50 )];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    if ([_titleString isEqualToString:@"推荐人"]) {
        _textField.placeholder = @"请输入VE号,普通会员不能作为推荐人";
    }
    _textField.font = THIRTEEN;//字体大小
    _textField.delegate = self;
    [self.view addSubview:_textField];
}
#pragma mark -- 选择视图
-(void)chooseView{
    for (int i=0; i<_chooseArr.count; i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:_chooseArr[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(10, 100+(i*60), SCREEN_width-20, 50);
        button.tag = i+10;
        //按钮编辑
        [button.layer setMasksToBounds:YES];
        //边框宽度
        [button.layer setBorderWidth:1.0];
        //边框圆角半径
        [button.layer setCornerRadius:10.0];
        //边框颜色
        button.layer.borderColor=[UIColor grayColor].CGColor;
        button.titleLabel.font = THIRTEEN;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chooseButttonClicke:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
#pragma mark -- 按钮点击事件
//是否按钮事件
-(void)chooseButttonClicke:(UIButton *)button{
    lastButton.backgroundColor = [UIColor whiteColor];
    button.backgroundColor = COLOR(27, 124, 204, 1);
    buttonTiter = button.titleLabel.text;
    NSLog(@"%@",buttonTiter);
    lastButton =button;
    
}
#pragma mark -- 键盘下去
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
