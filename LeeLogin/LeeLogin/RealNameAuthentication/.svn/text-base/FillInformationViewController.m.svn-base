//
//  FillInformationViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/1.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "FillInformationViewController.h"
#import "CDCardCell.h"
#import "UICommonView.h"
#import "SubmitPhotoCell.h"
#import "MMProgressHUD.h"
#define AUTHENTICATION_SUBMIT LINK_URL(@"/userAccount/saveUserAuth") //用户发起实名认证提交

@interface FillInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITextField * _nameField;
    UITextField * _IDcardField;
    NSData * _frontPicData;//身份证正面照片
    NSData * _backPicData; //身份证背面照片
    NSInteger _selecCellIndex;
    int flag[2];

}

@property (nonatomic,strong) UITableView * fillInfoTable;

@end

@implementation FillInformationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"提交认证";
    self.view.backgroundColor = BGCOLOR;
    
    //设置返回按钮  不放在ViewWillappear里面 这是最后一个页面了
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];


    [self.view addSubview:self.fillInfoTable];
    [self createSubmitButton];
}


#pragma mark == 提交审核按钮 & 点击事件
-(void)createSubmitButton{
    UIButton * btn = [LeeAllView BigButton:CGRectMake(10, SCREEN_height-64, SCREEN_width-20, 40) withTitel:@"提交审核"];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(submitInfo) forControlEvents:UIControlEventTouchUpInside];
}

-(void)submitInfo{
    //认证
    
    if(!_frontPicData || !_backPicData || _IDcardField.text.length==0 || _nameField.text.length == 0){
        UIAlertController * alert = [UICommonView showOneAlertWithTitle:@"温馨提示" message:@"请完善信息" preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定"  sureBlock:^{
            NSLog(@"确定");
        }];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSDictionary * parameters = @{@"sccess_token":ACCESS_TOKEN,
                                  @"id_card":_IDcardField.text,
                                  @"real_name":_nameField.text,
                                  };
    /*
     @"frontPic":_frontPicData,
     @"backPic":_backPicData
     */
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSArray * imageArray = [[NSArray alloc]initWithObjects:[UIImage imageWithData:_frontPicData],[UIImage imageWithData:_backPicData], nil];
    NSArray * imageTitle = [[NSArray alloc]initWithObjects:@"frontPic",@"backPic", nil]; //图片名字
    NSArray * imageDataArr = [[NSArray alloc]initWithObjects:_frontPicData,_backPicData, nil]; // 图片data
    
    __weak typeof(self) weakSelf = self;
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:@"提示" status:@"提交中..."];
    
    NSLog(@"parameters ==  %@",parameters);
    
    [manager POST:AUTHENTICATION_SUBMIT parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSMutableArray * type = [[NSMutableArray alloc]init];
        for (int i = 0; i<imageArray.count; i++) {
            UIImage * img = [UIImage imageWithData:imageDataArr[i]];
            
            if ( UIImagePNGRepresentation(img) ) {
                [type addObject:@"image/png"];
            }else{
                [type addObject:@"image/jpeg"];
            }
        }
        
        [formData appendPartWithFileData:imageDataArr[0] name:imageTitle[0] fileName:imageTitle[0] mimeType:type[0]];
        [formData appendPartWithFileData:imageDataArr[1] name:imageTitle[1] fileName:imageTitle[1] mimeType:type[1]];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"progress --- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success: %@", responseObject);
        
        NSString * msg = responseObject[@"msg"];
        if ([responseObject[@"code"] intValue] == 001) {
            [MMProgressHUD dismissWithSuccess:msg title:@"恭喜" afterDelay:1];
            double delayInSeconds = 1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
            [weakSelf postNotification];//发通知

        }else{
            [MMProgressHUD dismissWithError:msg title:@"提示"];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error == %@",error);
        [MMProgressHUD dismissWithError:@"提交失败，请重新提交" title:@"抱歉" afterDelay:1];
        
    }];

}

#pragma mark == 发送通知
-(void)postNotification{
    NSNotification * notification = [NSNotification notificationWithName:@"statusChanged" object:nil userInfo:@{@"status":@"Authenticationing",@"sectionNum":@1}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
#pragma mark == 初始化tableView
-(UITableView * )fillInfoTable{
    if (!_fillInfoTable) {
        _fillInfoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height-64-84) style:UITableViewStylePlain];
        _fillInfoTable.delegate= self;
        _fillInfoTable.dataSource =self;
        _fillInfoTable.showsVerticalScrollIndicator = NO;
        _fillInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _fillInfoTable.estimatedRowHeight = 200;
        _fillInfoTable.rowHeight = UITableViewAutomaticDimension;
        
        _fillInfoTable.tableHeaderView = [self headerView]; //表头
        [_fillInfoTable registerNib:[UINib nibWithNibName:@"CDCardCell" bundle:nil] forCellReuseIdentifier:@"CDCardCell"];
        [_fillInfoTable registerNib:[UINib nibWithNibName:@"SubmitPhotoCell" bundle:nil] forCellReuseIdentifier:@"SubmitPhotoCell"];
    }
    return _fillInfoTable;
}

#pragma mark == 表头
-(UIView *)headerView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 160)];
    view.backgroundColor = BGCOLOR;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registeFirstResponder)];
    [view addGestureRecognizer:tap];

    _nameField = [self customTextFieldWithFrame:CGRectMake(10, 20, SCREEN_width-20, 40) title:@" 姓名"];
    _IDcardField = [self customTextFieldWithFrame:CGRectMake(10, 70, SCREEN_width-20, 40) title:@" 身份证号"];
    _IDcardField.keyboardType = UIKeyboardTypeNamePhonePad;
    
    _IDcardField.delegate =self;
    _nameField.delegate = self;
    
    UILabel * alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, SCREEN_width-20, 40)];
    alertLabel.textColor = [UIColor grayColor];
    alertLabel.text = @" 身份证照支持jpg/png格式";
    
    [view addSubview:alertLabel];
    [view addSubview:_nameField];
    [view addSubview:_IDcardField];
    return view;
}

#pragma mark == datqasource & dalegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (flag[indexPath.row] == 1) {
        CDCardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CDCardCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.photoImg.image = [UIImage imageWithData:_frontPicData];
        }else{
            cell.titleLabel.text = @"身份证背面照片";
            cell.photoImg.image = [UIImage imageWithData:_backPicData];
        }
        cell.tag = 89892+indexPath.row;
        cell.UploadPhoto.tag = cell.tag+100;
        [cell.UploadPhoto addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    SubmitPhotoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SubmitPhotoCell" forIndexPath:indexPath];
    cell.tag = 8989+indexPath.row;
    cell.UploadButton.tag = cell.tag+100;
    if(indexPath.row == 0 ){
        cell.titleLabel.text = @"身份证正面照片";
    }else{
        cell.titleLabel.text = @"身份证背面照片";
    }
    [cell.UploadButton addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark == 点击图片选择头像
-(void)selectPhoto:(UIButton *)btn{
    
    _selecCellIndex = btn.tag - 100;
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self pikePhoto:UIImagePickerControllerSourceTypeCamera];
        }else{
            NSLog(@"没有找到相关设备");
        }
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pikePhoto:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)pikePhoto:(UIImagePickerControllerSourceType)sourceType {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}

#pragma mark ==代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (_selecCellIndex == 8989 || _selecCellIndex == 89892) {
        flag[0] = 1;
        _frontPicData = UIImagePNGRepresentation(image);
    }else{
        flag[1] = 1;
        _backPicData = UIImagePNGRepresentation(image);
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.fillInfoTable reloadData];
}



#pragma mark == 自定义textFiled
-(UITextField * )customTextFieldWithFrame:(CGRect)rect title:(NSString *)title{
    
    UITextField * field = [[UITextField  alloc]initWithFrame:rect];
    field.layer.borderWidth = 0.4;
    field.borderStyle = UITextBorderStyleRoundedRect;
    field.layer.cornerRadius = 5;
    field.adjustsFontSizeToFitWidth = YES;
    field.layer.borderColor = [UIColor grayColor].CGColor;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(3, 0, 80, rect.size.height)];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.layer.borderWidth = 0.2;
    label.backgroundColor = [UIColor colorWithRed:251/255.0 green:251/255.0 blue:252/255.0 alpha:1];
    label.adjustsFontSizeToFitWidth = YES;
    
    field.leftView = label;
    field.leftViewMode = UITextFieldViewModeAlways;
    return field;
}

#pragma mark ==textfield delegate && 收起键盘操作

-(void)registeFirstResponder{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:_IDcardField]) {
        NSLog(@"------");
        if (![self verifyIDCardNumber:textField.text]) {
            
            NSString * error = [NSString string];
            if (textField.text.length!=18) {
                error = @"请填写18位身份证号";
            }else{
                error = @"请输入正确身份证号";
            }

            UIAlertController * alert = [UICommonView showOneAlertWithTitle:@"提示" message:error preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" sureBlock:^{

            }];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}


#pragma mark  == 验证身份证
- (BOOL)verifyIDCardNumber:(NSString *)value
{
   value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
   if ([value length] != 18) {
           return NO;
       }
   NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
   NSString *leapMmdd = @"0229";
   NSString *year = @"(19|20)[0-9]{2}";
   NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
   NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
   NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
   NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
   NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
   NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];

   NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
   if (![regexTest evaluateWithObject:value]) {
           return NO;
       }
     int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
             + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
             + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
             + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
             + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
             + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
             + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
             + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
             + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
     NSInteger remainder = summary % 11;
     NSString *checkBit = @"";
     NSString *checkString = @"10X98765432";
     checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
     return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
 }



@end
