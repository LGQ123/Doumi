//
//  NetworkRequest.h
//  tourongzhuanjia
//
//  Created by 移动微世界 on 15/12/24.
//  Copyright © 2015年 JWZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequest : NSObject
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;



/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

+ (void)post1:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

+ (void)post2:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

+ (void)post3:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

+(NSString*)dictionaryToJson:(NSDictionary *)dic;
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//encode编码
+(NSString *)encodeToPercentEscapeString: (NSString *) input;

+(NSString *)decodeFromPercentEscapeString: (NSString *) input;

//参数排序
+ (NSString *)sequenceValve:(NSDictionary *)dic;

/**
 *  时间戳
 */

+ (NSString *)timestampForDate;

@end
