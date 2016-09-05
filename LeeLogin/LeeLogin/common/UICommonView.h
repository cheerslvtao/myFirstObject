//
//  UICommonView.h
//  LeeLogin
//
//  Created by 吕涛 on 16/8/9.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface UICommonView : NSObject
//提示框(两个按钮的)
+(UIAlertController *)showTwoAlertWithTitle:(NSString *)title
                                 message:( NSString *)message
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                               sureTitle:(NSString *)sureTitle
                             cancelTitle:(NSString *)cancelTitle
                               sureBlock:(void(^)())sureBlock
                             cancelBlock:(void(^)())cancelBlock;

//提示框(一个按钮的)
+(UIAlertController *)showOneAlertWithTitle:(NSString *)title
                                 message:( NSString *)message
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                               sureTitle:(NSString *)sureTitle
                               sureBlock:(void(^)())sureBlock;
+(NSString *)base64Encode:(NSString *)str;//Bsde64加密
+ (NSString *)md5:(NSString*)str;//MD5加密

@end
