



//
//  IndividualitySignatureCell.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/3.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "IndividualitySignatureCell.h"

@implementation IndividualitySignatureCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _titelLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 80)];
        _titelLabel.font = THIRTEEN;
        [self addSubview:_titelLabel];
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, SCREEN_width-120,80)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:17];
        _contentLabel.textColor = TEXTCOLOR;
        [self addSubview:_contentLabel];
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
