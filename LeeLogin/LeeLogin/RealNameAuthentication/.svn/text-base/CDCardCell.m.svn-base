//
//  CDCardCell.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/2.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "CDCardCell.h"

@implementation CDCardCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.UploadPhoto.layer.cornerRadius = 10;
    self.UploadPhoto.layer.borderColor = COLOR(61, 93, 151, 1).CGColor;
    [self.UploadPhoto setTitleColor:COLOR(61,93, 151, 1) forState:UIControlStateNormal];
    self.UploadPhoto.layer.borderWidth = 1;

    if ([self respondsToSelector:@selector(selctedPhotoFromLibrary)]) {
        self.photoImg.image = [self.delegate selctedPhotoFromLibrary];
    }
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPhotoClearness:)];
    [self.photoImg addGestureRecognizer:tap];

}

-(void)showPhotoClearness:(UITapGestureRecognizer *)tap{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
