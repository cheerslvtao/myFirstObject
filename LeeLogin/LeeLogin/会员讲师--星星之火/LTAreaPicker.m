//
//  LTAreaPicker.m
//  PickViewDemo
//
//  Created by 吕涛 on 16/8/5.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "LTAreaPicker.h"

@implementation LTAreaPicker


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:247/255.0 alpha:1];
    
        [self initDataArr];
        [self createUI];
        statesRow = 0;
        cityRow = 0;
        areaRow = 0;
    }
    return self;
}

-(void)createUI{
    for (int i=0; i < 2; i++){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==0) {
            btn.frame = CGRectMake(10, 0, 60, 40);
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(cancelSelect) forControlEvents:UIControlEventTouchUpInside];
        }else{
            btn.frame = CGRectMake(self.bounds.size.width - 70, 0, 60, 40);
            [btn setTitle:@"确定" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(sureSelect) forControlEvents:UIControlEventTouchUpInside];
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    
    self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height - 40)];
    self.pickView.backgroundColor =[UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource =self;
    
    [self addSubview:self.pickView];

}
-(void)cancelSelect{
    self.returnBlock(@"");
}
-(void)sureSelect{
    NSLog(@"SURE");
    NSString * str = [NSString stringWithFormat:@"%@-%@-%@",self.statesArr[statesRow],self.cityArr[statesRow][cityRow],self.areaArr[statesRow][cityRow][areaRow]];
    self.returnBlock(str);
}

#pragma mark = = UIPickerViewDataSource
//共有几组
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
//每组有多少项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.statesArr.count;
        
    }else if (component == 1){
        NSLog(@"%d",statesRow);
        return [self.cityArr[statesRow] count];
    }
    return [self.areaArr[statesRow][cityRow] count];
    
}

#pragma mark = =  UIPickerViewDelegate
//每组的宽
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.bounds.size.width/3;
}
//每组的高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 40;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if (component == 0) {
        return self.statesArr[row];
    }else if (component == 1){
        return self.cityArr[statesRow][row];
    }
    return self.areaArr[statesRow][cityRow][row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        //当拖动省列表时  刷新市、区的列表  使他们置为第一行
        statesRow = (int)row;
        cityRow = 0;
        areaRow = 0;
        [pickerView reloadComponent:2];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }else if(component == 1){
        //当拖动市列表时  刷新区的列表  使他们置为第一行
        cityRow = (int)row;
        areaRow = 0;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }else if (component == 2){
        areaRow = (int)row;
    }
    

    NSLog(@"states %d   city %d    area  %d",statesRow,cityRow,areaRow);
}



-(void)initDataArr{

    self.dataArr = [[NSMutableArray alloc]init];
    self.statesArr =[[NSMutableArray alloc]init];
    self.cityArr = [[NSMutableArray alloc]init];
    self.areaArr = [[NSMutableArray alloc]init];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    self.dataArr = (NSMutableArray *)[[NSArray alloc] initWithContentsOfFile:plistPath];
    
    for (int i = 0; i<self.dataArr.count; i++) {
        NSDictionary * dic = self.dataArr[i];
        NSString * states =[[dic allKeys] firstObject];
//        NSLog(@" states -- %@",[[dic allKeys] firstObject]);
        [self.statesArr addObject:states];//省
        
        NSDictionary * subDic = [dic objectForKey:[[dic allKeys] firstObject]];
        NSMutableArray * subCityArr = [[NSMutableArray alloc]init];
        NSMutableArray * topAreaArr = [[NSMutableArray alloc]init];
        
        for (int j = 0; j<subDic.count; j++) {
            NSDictionary * subDic2 = [subDic objectForKey:[NSString stringWithFormat:@"%d",j]];
            NSString * key = [[subDic2 allKeys] firstObject];
            [subCityArr addObject:key];
//            NSLog(@" city == %@",key); //市
            
            NSMutableArray * areaArr = [[NSMutableArray alloc]init];
            NSArray * arr = [subDic2 objectForKey:key];
            for (NSString * str in arr) {
                [areaArr addObject:str]; //区
//                NSLog(@"area .. %@",str);
            }
            [topAreaArr addObject:areaArr];
            
        }
        [self.areaArr addObject:topAreaArr];
        [self.cityArr addObject:subCityArr];
    }
}

//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) {
//
//}// attributed title is favored if both methods are implemented
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
//
//};

@end
