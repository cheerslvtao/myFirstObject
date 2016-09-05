
//
//  LeeAllView.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/27.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "LeeAllView.h"

@implementation LeeAllView
//注册填写View
-(UIView *)registeredViewWithFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithRed:232/250.0 green:232/250.0 blue:232/250.0 alpha:1];
    [view.layer setMasksToBounds:YES];//编辑
    [view.layer setBorderWidth:1.0];//边框宽度
    [view.layer setCornerRadius:10.0];//圆角度
    view.layer.borderColor=[UIColor grayColor].CGColor;//边框颜色
    _titerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, view.frame.size.height)];
    _titerLabel.textColor = [UIColor colorWithRed:142/255.0 green:150/255.0 blue:161/255.0 alpha:1];
    _titerLabel.backgroundColor = [UIColor colorWithRed:251/255.0 green:251/255.0 blue:252/255.0 alpha:1];
    _titerLabel.adjustsFontSizeToFitWidth =YES;
    _titerLabel.font = THIRTEEN;//字体大小
    [view addSubview:_titerLabel];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(101, 0, view.frame.size.width-101, view.frame.size.height)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.font = THIRTEEN;//字体大小
    [view addSubview:_textField];
    return view;
}
+ (UIScrollView *)BGScrollViewWith:(CGRect)frame//背景滑动视图
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:frame];
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    scrollView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:247/255.0 alpha:1];
    return scrollView;
}
+(UIButton *)BigButton:(CGRect)frame withTitel:(NSString *)string
{
    UIButton *loginBut = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBut.frame = frame;
    loginBut.titleLabel.font = THIRTEEN;
        loginBut.backgroundColor = COLOR(62, 94, 149, 1);
    //按钮编辑
    [loginBut setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [loginBut setTitle:string forState:UIControlStateNormal];
    [loginBut.layer setMasksToBounds:YES];
    //边框圆角半径
    [loginBut.layer setCornerRadius:5.0];
    return loginBut;
}
+ (UILabel *)allLabelWith:(CGRect)frame withTextColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = THIRTEEN;
    label.textColor = color;
    
    return label;
}

+(void)alertView
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入密码不相同,请重新输入" preferredStyle: UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        
    }]];
    
    //弹出提示框；
    //[self presentViewController:alert animated:true completion:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
