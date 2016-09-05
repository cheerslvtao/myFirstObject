//
//  NvigationItemSingle.h
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/3.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^singleBlock)();

@protocol popViewControllerDelegate <NSObject>

@end

@interface NvigationItemSingle : NSObject

/*!
 *  导航条单例类
 */
+(NvigationItemSingle *)standSingle;

/*!
 *  当前视图控制
 */
@property (nonatomic,strong) UIViewController * currentController;

/*!
 *  设置返回
 */
-(void)setNavigationBackItem:(UIViewController *)vc ;


@end
