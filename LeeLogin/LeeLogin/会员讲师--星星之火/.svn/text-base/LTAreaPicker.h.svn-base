//
//  LTAreaPicker.h
//  PickViewDemo
//
//  Created by 吕涛 on 16/8/5.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import <UIKit/UIKit.h>
// 这个 block 返回选择的地址
typedef void(^returnTimeBlock)(NSString * time);

@interface LTAreaPicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    int statesRow;
    int cityRow;
    int areaRow;
}
@property (nonatomic,copy) returnTimeBlock returnBlock; //传递数据

@property (nonatomic,strong) UIPickerView * pickView ;

@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) NSMutableArray * statesArr;

@property (nonatomic,strong) NSMutableArray * cityArr;

@property (nonatomic,strong) NSMutableArray * areaArr;


@end
