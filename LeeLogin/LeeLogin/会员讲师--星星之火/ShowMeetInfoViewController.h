//
//  ShowMeetInfoViewController.h
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/4.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitedMeetList.h"
@interface ShowMeetInfoViewController : UIViewController

@property (nonatomic,strong) NSString * titleString;

@property (nonatomic) BOOL isCheck;

@property (nonatomic,strong) SubmitedMeetList * model ;

@end
