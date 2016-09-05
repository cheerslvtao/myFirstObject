//
//  AllModifyVC.h
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/2.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "LeeNavigationTitleBaseVC.h"
//定义一个协议
@protocol AllModifyVCDelegate <NSObject>

- (void)refreshList;
@end
//===========================//
@interface AllModifyVC : LeeNavigationTitleBaseVC
//声明一个代理
@property id <AllModifyVCDelegate>delegate;
@property (nonatomic,copy)NSString *titleString;
@property (nonatomic,copy)NSString *textString;
@end
