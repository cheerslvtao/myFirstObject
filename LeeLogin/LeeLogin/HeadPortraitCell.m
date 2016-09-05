


//
//  HeadPortraitCell.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/2.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "HeadPortraitCell.h"

@implementation HeadPortraitCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width-80, 5, 70, 70)];
        _headImgView.layer.masksToBounds = 35;
        [_headImgView.layer setCornerRadius:35];
        [self.contentView addSubview:_headImgView];
        _titelLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 180, 20)];
        _titelLabel.font = THIRTEEN;
        [self addSubview:_titelLabel];
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
