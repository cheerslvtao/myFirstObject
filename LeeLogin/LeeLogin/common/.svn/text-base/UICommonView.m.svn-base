//
//  UICommonView.m
//  LeeLogin
//
//  Created by 吕涛 on 16/8/9.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "UICommonView.h"

@implementation UICommonView
//提示框(一个按钮的)
+(UIAlertController *)showTwoAlertWithTitle:(NSString *)title
                                 message:( NSString *)message
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                               sureTitle:(NSString *)sureTitle
                             cancelTitle:(NSString *)cancelTitle
                               sureBlock:(void(^)())sureBlock
                             cancelBlock:(void(^)())cancelBlock
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    [alert addAction:[UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sureBlock();
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelBlock();
    }]];
    return alert;
}
//提示框(一个按钮的)
+(UIAlertController *)showOneAlertWithTitle:(NSString *)title
                                 message:( NSString *)message
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                               sureTitle:(NSString *)sureTitle
                               sureBlock:(void(^)())sureBlock
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    [alert addAction:[UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sureBlock();
    }]];
    return alert;
}


+(NSString *)base64Encode:(NSString *)str{
    
    NSData *nsdata = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    return base64Encoded;
}

+ (NSString *)md5:(NSString*)str
{
    const char *cStr = [str UTF8String];
    
    unsigned char result[32];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
    
    NSString * backStr = [NSString stringWithFormat:
                 
                 @"%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x",
                 
                 result[0],result[1],result[2],result[3],
                 
                 result[4],result[5],result[6],result[7],
                 
                 result[8],result[9],result[10],result[11],
                 
                 result[12],result[13],result[14],result[15]
                 
                 ];
    
    return backStr;
}
@end
