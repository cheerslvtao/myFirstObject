//
//  CDCardCell.h
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/2.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitedMeetList.h"
@protocol SelectPhoto <NSObject>

-(UIImage *)selctedPhotoFromLibrary;

@end

@interface CDCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImg;
@property (weak, nonatomic) IBOutlet UIButton *UploadPhoto;

@property (nonatomic,weak) id<SelectPhoto> delegate;


@property (nonatomic,strong) SubmitedMeetList * model ;
@end
