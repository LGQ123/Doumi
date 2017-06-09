//
//  ZYKMD5.h
//  加密算法
//
//  Created by 赵英奎 on 14-4-26.
//  Copyright (c) 2014年 张诚. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ZYKMD5 : NSObject
//16位MD5加密方式
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString isUppercase:(BOOL)isUppercase;
//32位MD5加密方式
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString isUppercase:(BOOL)isUppercase;
//sha1加密方式
+ (NSString *)getSha1String:(NSString *)srcString;
//sha256加密方式
+ (NSString *)getSha256String:(NSString *)srcString;
//sha384加密方式
+ (NSString *)getSha384String:(NSString *)srcString;
//sha512加密方式
+ (NSString*) getSha512String:(NSString*)srcString;

/**字符串加密 */
+(NSString *)doEncryptStr:(NSString *)originalStr;
/**字符串解密 */
+(NSString*)doDecEncryptStr:(NSString *)encryptStr;
/**十六进制解密 */
+(NSString *)doEncryptHex:(NSString *)originalStr;
/**十六进制加密 */
+(NSString*)doDecEncryptHex:(NSString *)encryptStr;

/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;

//支付通rsa加密
+ (NSString *)RSAEncrypotoTheData:(NSString *)plainText;

@end
