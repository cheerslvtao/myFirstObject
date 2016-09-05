




//
//  ModifyPictureVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/2.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "ModifyPictureVC.h"
#import "MMProgressHUD.h"//风火轮
#define ChangePortrait @"/userAccount/changePortrait"//修改头像
@interface ModifyPictureVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImage *HeadImage;
    int first;
}
@property (nonatomic,strong)NSData *bigData;
@end

@implementation ModifyPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
     NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[USER_D objectForKey:@"head_url"]]];
    if (data ==nil) {
        HeadImage = [UIImage imageNamed:@"photo"];
    }else{
         HeadImage = [UIImage imageWithData:data];
    }
   
    self.title = @"修改头像";
    first = 0;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_width-50, 24, 40, 40);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BGCOLOR;
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    _herdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _herdButton.frame = CGRectMake((SCREEN_width/3)/2, 100, SCREEN_width/3*2, SCREEN_width/3*2);
    [_herdButton setImage:HeadImage forState:UIControlStateNormal];
    [_herdButton addTarget:self action:@selector(herdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_herdButton];
    // Do any additional setup after loading the view.
}
#pragma mark -- 按钮事件
- (void)buttonClick:(UIButton *)button{
    NSLog(@"完成");
    if (first ==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //1。创建管理者对象
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        if (HeadImage ==nil){
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[USER_D objectForKey:@"head_url"]]];
            _bigData = data;
        }else{
            NSData *data = UIImageJPEGRepresentation(HeadImage, 1.0f);
            _bigData = data;
        }
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
        [MMProgressHUD showWithTitle:@"提示" status:@"玩命上传..."];
        [manager POST:LINK_BASE_URL(ChangePortrait) parameters:@{@"access_token":ACCESS_TOKEN} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:_bigData name:@"imageData" fileName:@"123" mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [USER_D setObject:responseObject[@"data"] forKey:@"head_url"];
            [MMProgressHUD dismissWithSuccess:@"上传成功" title:@"恭喜" afterDelay:1];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [MMProgressHUD dismissWithError:@"上传失败" title:@"抱歉" afterDelay:1];
        }];
    }
}
- (void)herdButtonClick
{
    first = 1;
    NSLog(@"换头像");
    //弹框
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self pikePhoto:UIImagePickerControllerSourceTypeCamera];
        }else{
            NSLog(@"没有找到相关设备");
        }
        NSLog(@"相机");
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"相册");
        [self pikePhoto:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        first = 0;
    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"换头像");
}
//调用相机
#pragma mark -- 调用相机
-(void)pikePhoto:(UIImagePickerControllerSourceType)sourceType {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    [_herdButton.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //[obj removeFromSuperview];
    }];
    HeadImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_herdButton setImage:HeadImage forState:UIControlStateNormal];

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
