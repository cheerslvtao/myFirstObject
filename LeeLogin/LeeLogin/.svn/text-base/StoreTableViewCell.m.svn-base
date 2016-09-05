


//
//  StoreTableViewCell.m
//  AroundMall
//
//  Created by 光之翼 on 16/7/1.
//  Copyright © 2016年 光之翼. All rights reserved.
//

#import "StoreTableViewCell.h"

@implementation StoreTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _mallLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 150, 20)];
        _mallLabel.textColor = [UIColor blackColor];
        [self addSubview:_mallLabel];
        _storeLabel= [[UILabel alloc]initWithFrame:CGRectMake(15, 50, 150, 20)];
        _storeLabel.font = [UIFont systemFontOfSize:18];
        _storeLabel.textColor = COLOR(146, 147, 148, 1);
        [self addSubview:_storeLabel];
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_width-145, 20, 130, 20)];
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        _phoneLabel.textColor =COLOR(101, 162, 218, 1);
        [self addSubview:_phoneLabel];
        
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
