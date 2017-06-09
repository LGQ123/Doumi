//
//  BusinessLogic.h
//  UNIQ
//
//  Created by  on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  kCity_Name  @"name"
#define  kCity_Id  @"id"
@interface BusinessLogic : NSObject

#pragma mark 手机号验证
+ (BOOL)isValidateMobile:(NSString *)mobileNum;

#pragma mark 邮箱验证
+(BOOL)isValidateEmail:(NSString *)email;

#pragma mark 密码验证 (6~20位)
+(BOOL)isValidatePassword:(NSString *)password;

#pragma mark 身份证号
+ (BOOL)isValidateIdentityCard: (NSString *)identityCard;

#pragma mark 护照号
+ (BOOL)isValidatePassport: (NSString *)identityCard;


/**
 *  设置是否绑定手机
 *
 *  @param type BOOL值
 */
+ (void)setMobileBandingStatus:(BOOL)type;

/**
 *  设置是否绑定微信
 *
 *  @param type BOOL值
 */
+ (void)setWechatBangdingStatus:(BOOL)type;


/**
 *  设置登录状态
 *
 *  @param type BOOL值
 */
+ (void)setLoginState:(BOOL)type;

/**   设置微信登陆状态 */
+ (void)setWXLoginState:(BOOL)type;

/**
 *  获取当前微信登录状态
 */
+ (BOOL)isWXLogin;

/**
 *  获取当前登录状态
 */
+ (BOOL)isLogin;

/**
 *  存储token
 */
+ (void)setToken:(NSString *)token;

//7ad4ce75d9cf15af716031ec2e28ef13

/**
 *  获取token
 */
+ (NSString *)getToken;

/**
 *  存储deviceToken
 */
+ (void)setDeviceToken:(NSString *)deviceToken;

//7ad4ce75d9cf15af716031ec2e28ef13

/**
 *  获取deviceToken
 */
+ (NSString *)deviceToken;

/**
 *  存储userName
 */
+ (void)setUserName:(NSString *)userName;

/**
 * 获取userName
 */
+ (NSString *)getUserName;
/**
 *  存储密码
 */
+ (void)setPassword:(NSString *)password;

/**
 *  获取密码
 */
+ (NSString *)getPassword;

/**
 *  存储密码
 */
+ (void)setUA:(NSString *)UA;


/**
 * 用存储UUID
 */
+ (void)setUUID:(NSString *)uuid;

/**
 * 用生成UUID
 */
+ (NSString *)uuid;

/**
 * 存储手机号
 */
+ (void)setPhoneNumber:(NSString *)phoneNumber;

/**
 * 获取手机号
 */

+ (NSString *)getPhoneNumber;
/**
 * 存储性别
 */
+ (void)setSex:(NSString *)Sex;

/**
 * 获取性别
 */

+ (NSString *)getSex;

/**
 * 存储专家认证状态
 */
+ (void)setExpert:(NSString *)State;

/**
 * 获取专家认证状态
 */

+ (NSString *)getExpert;

/**
 * 存储融资认证状态
 */
+ (void)setCompany:(NSString *)State;

/**
 * 获取融资认证状态
 */

+ (NSString *)getCompany;

/**
 * 存储投资人认证状态
 */
+ (void)setInvest:(NSString *)State;

/**
 * 获取投资人认证状态
 */

+ (NSString *)getInvest;

/**
 * 路演录音
 */
+ (void)setRecord:(NSString *)State;

/**
 * 路演录音
 */

+ (NSString *)getRecord;


/**
 * 返回一对一学院城市
 */

+ (NSString *)getCityName;

/**
 * 返回一对一学院城市ID
 */

+ (NSString *)getCityId;


/**
 * Sig
 */
+ (void)setUserSig:(NSString *)userSig;

/**
 * Sig
 */

+ (NSString *)getUserSig;

/**
 * Sig
 */
+ (void)setUserLiveBy:(NSString *)liveBy;

/**
 * Sig
 */

+ (NSString *)getLiveBy;

/**
 *  存储绑定手机号
 */
+ (void)setPhoneNo:(NSString *)phoneno;

/**
 *  获取绑定手机号
 */
+ (NSString *)getPhoneNo;

/**
 *  存储tabbar Selected
 */
+ (void)setTabbarSelected:(NSString *)selectedID;

/**
 *  存储tabbar Selected
 */
+ (NSString *)selectedID;

/**
 *  存储 YY账号
 */
+ (void)setYYAccound:(NSString *)YYAccound;

/**
 *  获取YY账号
 */
+ (NSString *)YYAccound;

/**
 *  存储 YY密码
 */
+ (void)setYYPaw:(NSString *)YYPaw;

/**
 *  获取YY密码
 */
+ (NSString *)YYPaw;

/**
 *  存储UGC
 */
+ (void)setUGC:(NSString *)ugc;

/**
 *  获取UGC
 */
+ (NSString *)UGC;

/**
 *  存储app权限
 */
+ (void)setPower:(NSString *)power;
/**
 *  获取app权限
 */
+ (NSString *)power;

/**
 *  存储app打开次数
 */
+ (void)setOpenNum:(NSString *)openNum;
/**
 *  获取app打开次数
 */
+ (NSString *)openNum;

/**
 *  存储是否允许引导评价
 */
+ (void)setIsAllow:(NSString *)isAllow;
/**
 *  获取是否允许引导评价
 */
+ (NSString *)isAllow;

/**
 *  存储是否第一次评价
 */
+ (void)setIsFirst:(NSString *)isFirst;
/**
 *  获取是否第一次评价
 */
+ (NSString *)isFirst;




@end
