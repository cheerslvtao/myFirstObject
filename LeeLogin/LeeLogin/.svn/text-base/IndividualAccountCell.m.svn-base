//
//  IndividualAccountCell.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/1.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "IndividualAccountCell.h"

@implementation IndividualAccountCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _titelImg= [[UIImageView alloc]initWithFrame:CGRectMake(20, 20,20, 20)];
        _titelImg.image = [UIImage imageNamed:@"list_ytb"];
        [self addSubview:_titelImg];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 100, 20)];
        [self addSubview:_titleLabel];
        UIImageView * arrowImgView= [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width-25,17.5, 15, 25)];
        arrowImgView.image = [UIImage imageNamed:@"arrow_right"];
        [self addSubview:arrowImgView];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
