//
//  WebViewController.h
//  LeeLogin
//
//  Created by 吕涛 on 16/8/15.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "LeeNavigationTitleBaseVC.h"

@interface WebViewController : UIViewController

@property (nonatomic,strong) NSString * urlString;

@property (nonatomic,strong) NSString * titleString;

@property (nonatomic) BOOL hasRightItem;

@end
