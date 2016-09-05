//
//  MyAuthenticatioinCell.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/2.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "MyAuthenticatioinCell.h"

@implementation MyAuthenticatioinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(RealNameCheckModel *)model{
    
    self.memberNum.text =[NSString stringWithFormat:@"%@",model.ve_code];
    
    self.time.adjustsFontSizeToFitWidth = YES;
    self.time.text = [NSString stringWithFormat:@"%@",model.create_time];
    //[NSString stringWithFormat:@"%@",model.create_time];
    
    self.name.text = [NSString stringWithFormat:@"%@",model.real_name];
    self.CDcard.text = [NSString stringWithFormat:@"%@",model.idCard];
    
    self.stauts.text = @"待审核";
    self.stauts.textColor = [UIColor blackColor];
    
}


-(NSString * )time:(NSString *)timeStr{
    
    NSLog(@"%@",timeStr);
    NSString * str = [timeStr substringToIndex:(timeStr.length-3)];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    return confromTimespStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
