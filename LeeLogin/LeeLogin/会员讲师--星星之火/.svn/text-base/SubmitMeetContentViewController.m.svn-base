//
//  SubmitMeetContentViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/4.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "SubmitMeetContentViewController.h"
#import "MeetSubmitCell.h"
#import "CDCardCell.h"
#import "SubmitPhotoCell.h"
#import "LTAreaPicker.h"
#import "LTDatePicker.h"
#import <objc/runtime.h>
#import "AFNetworking.h"
#import "MMProgressHUD.h"
#define MEET_SUBMIT LINK_BASE_URL(@"/userMeeting/addMeeting") //星星之火 ———— 会议提交

@interface SubmitMeetContentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSData * _topPicData;//会前照片
    NSData * _midPicData; //会中照片
    NSData * _bottomPicData; //会后照片
    NSArray * imageArr; //图片数组
    NSInteger _selecCellTag;
    int flag[3];
    UITextView * summaryTextView;//总结会议
    float currentOffset ;//当前tableView偏移量
    
    CGFloat keyboardHeight; //键盘高度
    CGFloat durationTime; //键盘弹起时间
    

}
@property (nonatomic,strong) UITableView * submitTableView;

@property (nonatomic,strong) NSArray * titleArr; //标题数组

@property (nonatomic,strong) NSArray * imgLogoArr; //右边小图标

@property (nonatomic,strong)NSMutableArray * textFiledArr; //存放textfield.text

@property (nonatomic,strong)NSArray * placeholdArr;//占位文字数组

@end

@implementation SubmitMeetContentViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置返回按钮
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];
    
    //使用NSNotificationCenter 键盘出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 键盘隐藏时
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGCOLOR;
    self.title = @"会提提交";
    
    self.textFiledArr = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"", nil]; //用于存放textfield的内容

    [self createRightCompeteButton];
    [self.view addSubview:self.submitTableView];

    
}

#pragma mark == 导航右边按钮
-(void)createRightCompeteButton{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 35);
    [btn setTitle:@"完 成" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark == 提交会议信息
-(void)submit{

    for (int i = 0; i<7; i++) {

        if ([self.textFiledArr[i] length]==0) {
            [self showAlert:@"请完善信息"];
            return;
        }
    }
    
    BOOL textFirst = [self isPureInt:self.textFiledArr[3]];
    BOOL textSecond = [self isPureInt:self.textFiledArr[4]];
    if (!textSecond || !textFirst){
        //如果有一个不是纯数字
        [self showAlert:@"请输入纯数字主办人、讲师VE号"];
        return;
    }
    
    NSArray * arr = [self.textFiledArr[6] componentsSeparatedByString:@";"];
    BOOL textThird;
    if (arr.count>0) {
        for (int i =0; i<arr.count; i++) {
            textThird = [self isPureInt:arr[i]];
            if (!textThird) {
                [self showAlert:@"参会人员请输入纯数字VE号,用英文';'号隔开"];
                return;
            }
        }
    }
    
    

    if (!_topPicData || !_midPicData|| !_bottomPicData || summaryTextView.text.length==0) {

        [self showAlert:@"请完善信息"];
        return;
    }
    
    if (summaryTextView.text.length>500){
        UIAlertController * alert = [UICommonView showOneAlertWithTitle:@"提示" message:@"会议总结应在500字以下" preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" sureBlock:^{
            return ;
        }];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    NSDictionary * dic = @{
                           @"access_token":ACCESS_TOKEN,
                           @"teachVeCode":self.textFiledArr[4],
                           @"title":self.textFiledArr[0],
                           @"sponsor":self.textFiledArr[3],
                           @"address":[NSString stringWithFormat:@"%@:%@",self.textFiledArr[1],self.textFiledArr[2]],
                           @"join_user":self.textFiledArr[6],
                           @"meeting_time":self.textFiledArr[5],
                           @"summary":summaryTextView.text
                               };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSArray * imageArray = [[NSArray alloc]initWithObjects:[UIImage imageWithData:_topPicData],[UIImage imageWithData:_midPicData],[UIImage imageWithData:_bottomPicData], nil];
    NSArray * imageTitle = [[NSArray alloc]initWithObjects:@"pic_start",@"pic_center",@"pic_end", nil]; //图片名字
    NSArray * imageDataArr = [[NSArray alloc]initWithObjects:_topPicData,_midPicData,_bottomPicData, nil]; // 图片data

    __weak typeof(self) weakSelf = self;
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:@"提示" status:@"提交中..."];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"key %@   obj:  %@",key,obj);
    }];

    [manager POST:MEET_SUBMIT parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
        [formData appendPartWithFileData:imageDataArr[2] name:imageTitle[2] fileName:imageTitle[2] mimeType:type[2]];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"progress --- %@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success: %@", responseObject);
        
        [MMProgressHUD dismissWithSuccess:responseObject[@"msg"] title:@"提示" afterDelay:1];
        if([responseObject[@"code"] integerValue]==001){
            double delayInSeconds = 1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error == %@",error);
        [MMProgressHUD dismissWithError:@"提交失败，请检查填写信息是否正确、网络是否正常" title:@"抱歉" afterDelay:1];

    }];
    
    

}

-(void)showAlert:(NSString *)message{
    UIAlertController * alert = [UICommonView showOneAlertWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" sureBlock:^{
        
    }];

    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark == 初始化 tableView
-(UITableView *)submitTableView{
    if (!_submitTableView) {
        _submitTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height-64) style:UITableViewStylePlain];
        _submitTableView.delegate =self;
        _submitTableView.dataSource = self;
        _submitTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _submitTableView.estimatedRowHeight = 50;
        _submitTableView.rowHeight = UITableViewAutomaticDimension;
        [_submitTableView registerNib:[UINib nibWithNibName:@"CDCardCell" bundle:nil] forCellReuseIdentifier:@"CDCardCell"];
        [_submitTableView registerNib:[UINib nibWithNibName:@"MeetSubmitCell" bundle:nil] forCellReuseIdentifier:@"MeetSubmitCell"];
        [_submitTableView registerNib:[UINib nibWithNibName:@"SubmitPhotoCell" bundle:nil] forCellReuseIdentifier:@"SubmitPhotoCell"];
        _submitTableView.tableFooterView = [self customFooter];
    }
    return _submitTableView;
}

#pragma mark == 表尾
-(UIView *)customFooter{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 220)];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_width/3, 30)];
    label.text = [self.titleArr lastObject];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    summaryTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 50, SCREEN_width-20, 170)];
    summaryTextView.text = @"您对本次会议的总结感想，限500字以内";
    summaryTextView.textColor = [UIColor grayColor];
    summaryTextView.delegate =self;
    [view addSubview:summaryTextView];
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count-1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<7) {
        MeetSubmitCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeetSubmitCell" forIndexPath:indexPath];
        cell.textFiledCell.delegate = self;
        cell.titleLabel.text = self.titleArr[indexPath.row]; //标题
        UIImage * img = nil;
        if (indexPath.row == 1) {
            img = [UIImage imageNamed:@"icon_zss"];
        }else if(indexPath.row == 5){
            img = [UIImage imageNamed:@"icon_hysj"];
        }else if (indexPath.row == 6){
            img = [UIImage imageNamed:@"icon_adduser"];
        }
        
        if (indexPath.row == 4){
            [self.textFiledArr replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%@",VE_CODE]]; //替换数组中的数据
        }
        cell.rightLogo.image = img;
        cell.textFiledCell.placeholder = self.placeholdArr[indexPath.row ];//textfiled 占位字符
        cell.textFiledCell.tag = 78592+indexPath.row;
        cell.textFiledCell.text = self.textFiledArr[indexPath.row];
        [cell.textFiledCell addTarget:self action:@selector(addTextToArr:) forControlEvents:UIControlEventAllEvents];
        return cell;
    }

    if (flag[indexPath.row-7] == 1) {
        CDCardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CDCardCell" forIndexPath:indexPath];
        if (indexPath.row == 7) {
            cell.titleLabel.text = @"会前照片";
            cell.photoImg.image = [UIImage imageWithData:_topPicData];

        }else if(indexPath.row == 8){
            cell.titleLabel.text = @"会中照片";
            cell.photoImg.image = [UIImage imageWithData:_midPicData];

        }else if (indexPath.row == 9){
            cell.titleLabel.text = @"会后照片";
            cell.photoImg.image = [UIImage imageWithData:_bottomPicData];
        }
        cell.tag = 78592+indexPath.row;
        cell.UploadPhoto.tag = cell.tag+100;
        [cell.UploadPhoto addTarget:self action:@selector(selectPhotoSubmit:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    SubmitPhotoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SubmitPhotoCell" forIndexPath:indexPath];
    
    cell.tag = 7859+indexPath.row;
    cell.UploadButton.tag = cell.tag+100;
    
    [cell.UploadButton addTarget:self action:@selector(selectPhotoSubmit:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;

}
-(void)addTextToArr:(UITextField *)field{
    NSInteger row = field.tag - 78592;
    [self.textFiledArr replaceObjectAtIndex:row withObject:field.text]; //替换数组中的数据

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark == 点击图片选择头像
-(void)selectPhotoSubmit:(UIButton *)btn{
    
    _selecCellTag = btn.tag - 100;
    
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

#pragma mark == 掉系统相册 代理方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info -- ---- -- %@",info);
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (_selecCellTag == 7859+7 || _selecCellTag == 78592+7) {
        flag[0] = 1;

        _topPicData = UIImageJPEGRepresentation(image, 0.1);
    }else if(_selecCellTag == 7859+8 || _selecCellTag == 78592+8){
        flag[1] = 1;

        _midPicData = UIImageJPEGRepresentation(image, 0.1);
    }else{
        
        flag[2] = 1;
        
        _bottomPicData =UIImageJPEGRepresentation(image, 0.1);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.submitTableView reloadData];
}



#pragma mark == 初始化数组
-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [[NSArray alloc]initWithObjects:@"会议名称",@"会议地区",@"会议地点",@"主办人",@"讲师",@"会议时间",@"参会人员",@"会前照片",@"会中照片",@"会后照片",@"会议总结", nil];
    }
    return _titleArr;
}

-(NSArray *)placeholdArr{
    if (!_placeholdArr) {
        _placeholdArr = [[NSArray alloc]initWithObjects:@"会议的主题名称",@"选择省市区",@"",@"主办人VE号",@"讲师VE号",@"时间",@"请输入VE号(使用英文';'隔开)",@"会前照片",@"会中照片",@"会后照片",@"会议总结", nil];
    }
    return _placeholdArr;
}

#pragma mark  == textfileddelegate 键盘收起
//textfiled 防范
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //if selelct states or select time , self.view endEding , let keyboard down .
    if ([textField.placeholder isEqualToString:@"选择省市区"]) {
        [self.view endEditing:YES];
        [self.view addSubview:[self showAreaPicker:textField]];
        
        return NO;
    }
    if ([textField.placeholder isEqualToString:@"时间"]) {
        [self.view endEditing:YES];
        [self.view addSubview:[self showDatePicker:textField]];
       
        return NO;
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField.placeholder isEqualToString:@"主办人VE号"]&& textField.text.length>0) {
        if (![self isPureInt:textField.text] && textField.text.length>0)
        {
            [self showAlert:@"请输入纯数字VE号"];
        }
    }

    
    if ([textField.placeholder isEqualToString:@"讲师VE号"]) {
        if (![self isPureInt:textField.text] && textField.text.length>0) {
            [self showAlert:@"请输入纯数字VE号"];
        }
    }

    
    if ([textField.placeholder isEqualToString:@"请输入VE号(使用英文';'隔开)"]) {
        if(textField.text.length>0){
            NSString * string = textField.text;
            
            NSMutableArray * arr = (NSMutableArray *)[string componentsSeparatedByString:@";"];
            //判断是否有非数字字符
            for (int i =0 ;i<arr.count; i++ ) {
                if (![self isPureInt:arr[i]]) {
                    [self showAlert:@"请输入纯数字VE号,用英文';'号隔开"];
                }
            }
        }
    }
    
}

#pragma mark == 判断是否是数字
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


#pragma mark == init AreaPicker
-(UIView *)showAreaPicker:(UITextField *)textField{
    NSInteger row = textField.tag - 78592;

    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height)];
    bgView.tag = 34654;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewDismiss)];
    [bgView addGestureRecognizer:tap];
    LTAreaPicker * pick = [[LTAreaPicker alloc]initWithFrame:CGRectMake(0, SCREEN_height-200, SCREEN_width, 200)];
    void (^myblock)(NSString *) = ^(NSString * areaStr){
        textField.text = areaStr;
        [self.textFiledArr replaceObjectAtIndex:row withObject:textField.text];
        [bgView removeFromSuperview];
    };
    pick.returnBlock = myblock;
    [bgView addSubview:pick];
    return bgView;
}

#pragma mark == init DatePicker
-(UIView *)showDatePicker:(UITextField *)textField{
    
    NSInteger row = textField.tag - 78592;

    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height)];
    bgView.tag = 34654;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewDismiss)];
    [bgView addGestureRecognizer:tap];
    
    LTDatePicker * dateView = [[LTDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_height-200, SCREEN_width, 200)];
    void (^myblock)(NSString *) = ^(NSString * dateStr){
        textField.text = dateStr;
        [self.textFiledArr replaceObjectAtIndex:row withObject:textField.text];

        [bgView removeFromSuperview];
    };
    [bgView addSubview:dateView];
    dateView.returnBlock = myblock;
    return  bgView;
}

// pickers  消失
-(void)bgViewDismiss{
    UIView * view = [self.view viewWithTag:34654];
    [view removeFromSuperview];
}

#pragma mark == textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView.text.length>500) {
        textView.textColor = [UIColor redColor];
    }else{
        textView.textColor = [UIColor grayColor];
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark == 处理键盘覆盖问题  textfiled代理方法

-(void)textViewDidBeginEditing:(UITextView *)textView{

    [UIView animateWithDuration:durationTime animations:^{
        self.view.frame = CGRectMake(0, -keyboardHeight, SCREEN_width, SCREEN_height);
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    [UIView animateWithDuration:durationTime animations:^{
        self.view.frame = CGRectMake(0, 0, SCREEN_width, SCREEN_height);
    }];

}

//实现当键盘出现的时候计算键盘的高度大小。
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即为键盘尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到键盘的高度
    durationTime = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]; //得到键盘动画时间
    keyboardHeight = kbSize.height;
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即为键盘尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    keyboardHeight = kbSize.height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
