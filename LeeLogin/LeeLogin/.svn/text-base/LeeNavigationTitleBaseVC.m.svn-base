

//
//  LeeNavigationTitleBaseVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/27.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "LeeNavigationTitleBaseVC.h"

@interface LeeNavigationTitleBaseVC ()

@end

@implementation LeeNavigationTitleBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];//白色背景
    [self loadNavTitle];
    // Do any additional setup after loading the view.
}
- (void)loadNavTitle{

    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(0, 0, 19, 35);
    [_btn setImage:[UIImage imageNamed:@"head_arrow"] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(backButClicled) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:_btn];
    self.navigationItem.leftBarButtonItem = item;

    
}
- (void)backButClicled{
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
