//
//  MeetCell.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/4.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "MeetCell.h"

@implementation MeetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(SubmitedMeetList *)model{
    
    self.meetTitle.text =model.title;
    self.meetTime.text = model.meeting_time_str;
    self.meetOwner.text = model.sponsorName;
    if (self.isSubmetedList) {
        if ([model.status intValue] == 0) {
            [self setStatusText:@"待审核" color:[UIColor blackColor]];
        }else if([model.status intValue] == 1){
            [self setStatusText:@"已通过" color:[UIColor greenColor]];
        }else{
            [self setStatusText:@"已拒绝" color:[UIColor redColor]];
        }
    }else{
        if ([model.status intValue] == 0) {
            [self setStatusText:@"查看" color:[UIColor blackColor]];

        }else if ([model.status intValue] == 1){
            [self setStatusText:@"已通过" color:[UIColor greenColor]];

        }else{
            [self setStatusText:@"已拒绝" color:[UIColor redColor]];

        }
    }

    self.publishTime.text = model.create_time_str;

}

-(void)setStatusText:(NSString *)title color:(UIColor *)color{
    self.meetStatus.text = title;
    self.meetStatus.textColor = color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
