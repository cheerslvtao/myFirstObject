//
//  HomePageTableViewCell.m
//  HomePage
//
//  Created by 光之翼 on 16/7/4.
//  Copyright © 2016年 光之翼. All rights reserved.
//

#import "HomePageTableViewCell.h"

@implementation HomePageTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _smallimgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, (SCREEN_width/4)/9*11, SCREEN_width/4)];
        [self addSubview:_smallimgView];
        _detailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_width/4+40, 15, SCREEN_width/2, 30)];
        _detailsLabel.font = [UIFont systemFontOfSize:17];
       // _detailsLabel.text = @"愤怒小鸟游戏安装";
        _detailsLabel.adjustsFontSizeToFitWidth =YES;
        _detailsLabel.numberOfLines = 0;
        [self addSubview:_detailsLabel];
        _coinSmallimgView= [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width/4+40, 60,20, 20)];
        _coinSmallimgView.image = [UIImage imageNamed:@"list_ytb"];
        [self addSubview:_coinSmallimgView];
        _moneyLabel =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_width/4+65, 60, 60, 20)];
        _moneyLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_moneyLabel];
        
        _arrowImgView= [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width-25, (SCREEN_width/4-15)/2, 15, 25)];
        _arrowImgView.image = [UIImage imageNamed:@"arrow_right"];
        [self addSubview:_arrowImgView];
        UILabel *blckLable = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_width/4+20, SCREEN_width/4+9, SCREEN_width, 1)];
        blckLable.backgroundColor = BGCOLOR;
        [self addSubview:blckLable];
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
