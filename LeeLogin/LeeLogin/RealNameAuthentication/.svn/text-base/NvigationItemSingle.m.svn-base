//
//  NvigationItemSingle.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/3.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "NvigationItemSingle.h"

@implementation NvigationItemSingle

+(NvigationItemSingle *)standSingle{
    static NvigationItemSingle * single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (single == nil) {
            single = [[NvigationItemSingle alloc]init];
        }
    });
    return single;
}

-(void)setNavigationBackItem:(UIViewController *)vc {
    self.currentController = vc;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 19, 35);
    [btn setImage:[UIImage imageNamed:@"head_arrow"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backTopView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    vc.navigationItem.leftBarButtonItem = item;
    
}
-(void)backTopView{
    NSLog(@"..........");
    [self.currentController.navigationController popViewControllerAnimated:YES];
}

@end
