//
//  HTTPURL.m
//  HeartFuture
//
//  Created by 李雪虎 on 16/7/7.
//  Copyright © 2016年 光之翼. All rights reserved.
//

#import "HTTPURL.h"
#import "MMProgressHUD.h"
#define authorization @"/oauth/token"
@implementation HTTPURL

+(void)postRequest:(NSString *)url
        parameters:(id)parameter
           success:(void (^)(NSURLSessionDataTask *  task, id   responseObject))ltSuccess
            filure:(void (^)(NSURLSessionDataTask *  task, id   error))ltFailure
           showHUD:(BOOL)hud
         sucessMsg:(NSString *)success
        failureMsg:(NSString *)failure
{
    
    NSLog(@"%@~~~%@",url,parameter);
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];

    if(hud){
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
        [MMProgressHUD showWithTitle:@"提示" status:@"玩命加载中..."];
    }

    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ltSuccess(task,responseObject);
        if (hud) {
            [MMProgressHUD dismissWithSuccess:success title:@"" afterDelay:1];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ltFailure(task,error);
        if (hud) {
            NSLog(@"error.userInfo --- %@",error);
            
            [MMProgressHUD dismissWithError:failure title:@"抱歉" afterDelay:1];
        }
        if ([VE_CODE length]>0 && [SECRET length]> 0){
            // 授权
            [HTTPURL authorizationsuccess:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                [USER_D setObject:responseObject[@"value"] forKey:@"token"];
                [USER_D synchronize];
                
            } Success:^(NSURLSessionDataTask *task, id responseObject) {
                
            }];
        }
        
    }];
    
}


//psot请求 带 请求头
+(void)post:(NSString *)urlStr withParameters:(NSDictionary *)Parameter withBlock:(void(^)(NSDictionary *dic))block false:(void (^)(NSURLSessionDataTask *  task, id   error))ltFailure
{
    
    NSString * vc = [NSString stringWithFormat:@"%@:%@",VE_CODE,SECRET];
    NSString * str = [UICommonView base64Encode:vc];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];    //授权
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Basic %@",str] forHTTPHeaderField:@"Authorization"];
    
    [manager POST:urlStr parameters:Parameter
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"response ----  %@",responseObject);
             block(responseObject);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             ltFailure(task,error);
             NSLog(@"%@",error);
         }];

}



#pragma mark - 创建请求者
-(AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
       // manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
 //   manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    return manager;
}
//josn解析
-(NSDictionary *)dicleeJosnwith:(NSData *)data
{

    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"josn dic%@",weatherDic);
    return weatherDic;
}

//数据编译成字符串(data转换String)
-(NSString *)nsstringwith:(NSData *)data
{
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}
//字符串分割  symbolStr:(分隔符号)
-(NSArray *)strArraywiht:(NSString *)str wiht:(NSString *)symbolStr
{
    NSArray *array = [str componentsSeparatedByString:symbolStr];
    return array;
}
//图片转换数据  image:(需要转换的图片)
-(NSData *)imgData:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    return data;
}
//发送post请求时参数中有中文需要编码
-(NSString *)urlStrwith:(NSString *)strUrl
{
    NSString *url = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}
//字符串拼接
-(NSString *)String:(NSString *)firstString withSpell:(NSString *)secondString
{
    NSString *string = [NSString stringWithFormat:@"%@%@",firstString,secondString];
    return string;
}

//授权请求
+(void)authorizationsuccess:(void (^)(NSURLSessionDataTask *  task, id   responseObject))ltSuccess Success:(void (^)(NSURLSessionDataTask *  task, id responseObject))flase
{
    
    NSString * vc = [NSString stringWithFormat:@"%@:%@",VE_CODE,SECRET];
    NSString * str = [UICommonView base64Encode:vc];
    NSLog(@"base64%@",str);
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];    //授权
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Basic %@",str] forHTTPHeaderField:@"Authorization"];
    NSLog(@"%@",LINK_BASE_URL(authorization));
    NSLog(@"%@",@{@"client_id":VE_CODE,@"client_secret":SECRET,@"grant_type":@"client_credentials"});
    [manager POST:LINK_BASE_URL(authorization) parameters:@{@"client_id":VE_CODE,@"client_secret":SECRET,@"grant_type":@"client_credentials"}
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             ltSuccess(task,responseObject);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
             NSLog(@"error=%@",error);
             flase(task,error);
             
         }];
    
}

@end
