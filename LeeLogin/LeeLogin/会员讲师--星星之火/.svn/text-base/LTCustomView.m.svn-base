//
//  LTCustomView.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/5.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "LTCustomView.h"

@implementation LTCustomView

+(UIView *)showTimePickerView:(id)target action:(SEL)action{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_height-150, SCREEN_width, 150)];
    view.backgroundColor = BGCOLOR;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确 定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.frame = CGRectMake(SCREEN_width-70, 0, 55, 30);
    [btn addTarget:target action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    
    UIDatePicker * picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 30, SCREEN_width, 120)];
    picker.datePickerMode = UIDatePickerModeDateAndTime;
    picker.backgroundColor = [UIColor whiteColor];
    
    
    [view addSubview:picker];
    return view;
}


+(UIView *)showAreaView{
    UIPickerView * pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_height-80, SCREEN_width, 80)];
    
    pickView.backgroundColor = [UIColor redColor];
    
    return pickView;
}

@end
