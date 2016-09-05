//
//  MyAuthenticatioinCell.h
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/2.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealNameCheckModel.h"
@interface MyAuthenticatioinCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *CDcard;
@property (weak, nonatomic) IBOutlet UILabel *stauts;

@property (weak, nonatomic) IBOutlet UILabel *memberNum;

@property (nonatomic,strong) RealNameCheckModel * model ;
@end
