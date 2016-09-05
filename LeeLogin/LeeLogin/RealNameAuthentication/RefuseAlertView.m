//
//  Refuse AlertView.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/2.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "RefuseAlertView.h"

@implementation RefuseAlertView

- (IBAction)cdcard:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)photo:(UIButton *)sender {
    sender.selected = !sender.selected;

}

- (IBAction)name:(UIButton *)sender {
    
    sender.selected = !sender.selected;

}
- (IBAction)sure:(UIButton *)sender {
    
    NSMutableString * reasonStr = [[NSMutableString alloc]init];
    if (self.idCardNumFalse.selected == YES) {
         [reasonStr appendString:@"身份证号码不正确 "];
    }
    if (self.idCardPhotoFalse.selected == YES){
        [reasonStr appendString:@"身份证照片不清晰 "];
    }
    if (self.idCardNameFalse.selected == YES){
        [reasonStr appendString:@"会员姓名不正确 "];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refuseReason" object:nil userInfo:@{@"reason":reasonStr}];
    
    self.block();
    [self removeFromSuperview];

}

@end
