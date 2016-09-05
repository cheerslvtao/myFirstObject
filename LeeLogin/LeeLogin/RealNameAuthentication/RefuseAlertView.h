//
//  Refuse AlertView.h
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/2.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefuseAlertView : UIView

@property (nonatomic,copy) void(^block)();

@property (weak, nonatomic) IBOutlet UIButton *idCardNumFalse;
@property (weak, nonatomic) IBOutlet UIButton *idCardPhotoFalse;

@property (weak, nonatomic) IBOutlet UIButton *idCardNameFalse;
@end
