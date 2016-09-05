


//
//  ListGoodsTableViewCell.m
//  AroundMall
//
//  Created by 光之翼 on 16/7/4.
//  Copyright © 2016年 光之翼. All rights reserved.
//

#import "ListGoodsTableViewCell.h"
@implementation ListGoodsTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //图片
        _bigImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 110, 110)];
        
        _bigImgView.backgroundColor = [UIColor redColor];
        [self addSubview:_bigImgView];
        //名称
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, SCREEN_width-140, 45)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_nameLabel];
        //价格
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 100, 150, 20)]
        ;
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_priceLabel];
        NSArray *array = @[@"入门会员每月限购1个;",@"一星会员每月限购2个;"];
        for (int i=0; i<2; i++)
        {
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = COLOR(146, 147,148, 1);
            label.text = array[i];
            label.frame = CGRectMake(130, 60+(17*i), SCREEN_width-150, 17);
            [self addSubview:label];
        }

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
