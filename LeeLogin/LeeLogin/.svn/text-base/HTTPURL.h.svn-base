//
//  HTTPURL.h
//  HeartFuture
//
//  Created by 李雪虎 on 16/7/7.
//  Copyright © 2016年 光之翼. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface HTTPURL : NSObject

+(void)postRequest:(NSString *)url
        parameters:(id)parameter
           success:(void (^)(NSURLSessionDataTask *  task, id   responseObject))ltSuccess
            filure:(void (^)(NSURLSessionDataTask *  task, id   error))ltFailure
           showHUD:(BOOL)hud
         sucessMsg:(NSString *)success
        failureMsg:(NSString *)failure;

-(NSString *)nsstringwith:(NSData *)data;//数据编译成字符串
-(NSArray *)strArraywiht:(NSString *)str wiht:(NSString *)symbolStr;//字符串分割
-(NSData *)imgData:(UIImage *)img;//图片转换为数据
-(NSString *)urlStrwith:(NSString *)strUrl;//发送post请求时参数中有中文需要编码
-(NSDictionary *)dicleeJosnwith:(NSData *)data;//JOSN解析
//字符串拼接
-(NSString *)String:(NSString *)firstString withSpell:(NSString *)secondString;
+(void)authorizationsuccess:(void (^)(NSURLSessionDataTask *  task, id   responseObject))ltSuccess Success:(void (^)(NSURLSessionDataTask *  task, id responseObject))flase;//授权请求
/**
 * 带请求体  post
 */
+(void)post:(NSString *)urlStr withParameters:(NSDictionary *)Parameter withBlock:(void(^)(NSDictionary *dic))block false:(void (^)(NSURLSessionDataTask *  task, id   error))ltFailure;//
@end
