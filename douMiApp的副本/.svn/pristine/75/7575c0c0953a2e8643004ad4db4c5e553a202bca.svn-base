//
//  BusinessLogic.m
//  UNIQ
//
//  Created by on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BusinessLogic.h"

@implementation BusinessLogic


/**
 *  设置是否绑定手机
 *
 *  @param type BOOL值
 */
+ (void)setMobileBandingStatus:(BOOL)type{

    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:type] forKey:@"mobileBandingStatus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  设置是否绑定微信
 *
 *  @param type BOOL值
 */
+ (void)setWechatBangdingStatus:(BOOL)type{

    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:type] forKey:@"wechatBangdingStatus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**   设置登录状态  @param type BOOL值  */
+ (void)setLoginState:(BOOL)type
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:type] forKey:@"login"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**   设置微信登陆状态 */
+ (void)setWXLoginState:(BOOL)type
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:type] forKey:@"wxlogin"];

    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  获取当前微信登录状态
 */
+ (BOOL)isWXLogin{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"wxlogin"] boolValue];

}

/**   获取当前登录状态 */
+ (BOOL)isLogin
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] boolValue];
}

/**  存储token值 */
+ (void)setToken:(NSString*)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/** 获取token  */
+ (NSString *)getToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}


/**
 *  存储deviceToken
 */
+ (void)setDeviceToken:(NSString *)deviceToken {
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"deviceToken"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//7ad4ce75d9cf15af716031ec2e28ef13

/**
 *  获取deviceToken
 */
+ (NSString *)deviceToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
}


/**  存储userName */
+ (void)setUserName:(NSString *)userName
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**   获取userName  */
+ (NSString *)getUserName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}

/**   存储密码 */
+ (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**  获取密码  */
+ (NSString *)getPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

/**
 *  存储密码
*/
+ (void)setUA:(NSString *)UA
{
    [[NSUserDefaults standardUserDefaults] setObject:UA forKey:@"User-Agent"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setPhoneNumber:(NSString *)phoneNumber
{
    [[NSUserDefaults standardUserDefaults] setObject:phoneNumber forKey:@"phoneNumber"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getPhoneNumber
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
}

+ (void)setUUID:(NSString *)uuid
{
    [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"User-Agent"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)uuid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"User-Agent"];
}

+ (void)setUserSig:(NSString *)userSig
{
    [[NSUserDefaults standardUserDefaults] setObject:userSig forKey:@"User-Sig"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUserSig {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"User-Sig"];
}

+ (void)setUserLiveBy:(NSString *)liveBy
{
    [[NSUserDefaults standardUserDefaults] setObject:liveBy forKey:@"User-liveBy"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getLiveBy {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"User-liveBy"];
}

/**
 * 存储手机号
 */
+ (void)setSex:(NSString *)Sex
{
    [[NSUserDefaults standardUserDefaults] setObject:Sex forKey:@"Sex"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

/**
 * 获取手
 */

+ (NSString *)getSex
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Sex"];
}

/**
 * 存储认证状态
 */
+ (void)setExpert:(NSString *)State
{
    [[NSUserDefaults standardUserDefaults] setObject:State forKey:@"Expert-State"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 * 获取认证状态
 */

+ (NSString *)getExpert
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Expert-State"];
}

/**
 * 存储认证状态
 */
+ (void)setCompany:(NSString *)State
{
    [[NSUserDefaults standardUserDefaults] setObject:State forKey:@"Company-State"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 * 获取认证状态
 */

+ (NSString *)getCompany
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Company-State"];
}

/**
 * 存储认证状态
 */
+ (void)setInvest:(NSString *)State
{
    [[NSUserDefaults standardUserDefaults] setObject:State forKey:@"Invest-State"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 * 获取认证状态
 */

+ (NSString *)getInvest
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Invest-State"];
}


+(void)setRecord:(NSString *)State
{
    [[NSUserDefaults standardUserDefaults] setObject:State forKey:@"Record-State"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getRecord
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Record-State"];
}


/**
 * 返回一对一学院城市
 */

+ (NSString *)getCityName{

    return [[NSUserDefaults standardUserDefaults] objectForKey:kCity_Name]==nil?@"":[[NSUserDefaults standardUserDefaults] objectForKey:kCity_Name];
}

/**
 * 返回一对一学院城市ID
 */

+ (NSString *)getCityId{

    return [[NSUserDefaults standardUserDefaults] objectForKey:kCity_Id]==nil?@"":[[NSUserDefaults standardUserDefaults] objectForKey:kCity_Id];

}

/**
 *  存储绑定手机号
 */
+ (void)setPhoneNo:(NSString *)phoneno {
    [[NSUserDefaults standardUserDefaults] setObject:phoneno forKey:@"phoneno"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取绑定手机号
 */
+ (NSString *)getPhoneNo {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneno"];
}


/**
 *  存储tabbar Selected
 */
+ (void)setTabbarSelected:(NSString *)selectedID {
    [[NSUserDefaults standardUserDefaults] setObject:selectedID forKey:@"selectedID"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

/**
 *  存储tabbar Selected
 */
+ (NSString *)selectedID {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedID"];
}


/**
 *  存储 YY账号
 */
+ (void)setYYAccound:(NSString *)YYAccound {
    [[NSUserDefaults standardUserDefaults] setObject:YYAccound forKey:@"YYAccound"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取YY账号
 */
+ (NSString *)YYAccound {
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"YYAccound"];
}

/**
 *  存储 YY密码
 */
+ (void)setYYPaw:(NSString *)YYPaw {
    [[NSUserDefaults standardUserDefaults] setObject:YYPaw forKey:@"YYPaw"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

/**
 *  获取YY密码
 */
+ (NSString *)YYPaw {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"YYPaw"];
}

/**
 *  存储UGC
 */
+ (void)setUGC:(NSString *)ugc {
    
    [[NSUserDefaults standardUserDefaults] setObject:ugc forKey:@"ugc"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取UGC
 */
+ (NSString *)UGC {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ugc"];
}

/**
 *  存储app权限
 */
+ (void)setPower:(NSString *)power {
    [[NSUserDefaults standardUserDefaults] setObject:power forKey:@"power"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
/**
 *  获取app权限
 */
+ (NSString *)power {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"power"];
}


/**
 *  存储app打开次数
 */
+ (void)setOpenNum:(NSString *)openNum {
    [[NSUserDefaults standardUserDefaults] setObject:openNum forKey:@"openNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  获取app打开次数
 */
+ (NSString *)openNum {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"openNum"];
}

/**
 *  存储是否允许引导评价
 */
+ (void)setIsAllow:(NSString *)isAllow {
    [[NSUserDefaults standardUserDefaults] setObject:isAllow forKey:@"isAllow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  获取是否允许引导评价
 */
+ (NSString *)isAllow {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"isAllow"];
}

/**
 *  存储是否第一次评价
 */
+ (void)setIsFirst:(NSString *)isFirst {
    [[NSUserDefaults standardUserDefaults] setObject:isFirst forKey:@"isFirst"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  获取是否第一次评价
 */
+ (NSString *)isFirst {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"];
}

#pragma mark 电话号码验证
+ (BOOL)isValidateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|7[0-9])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    
    NSString * phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|(7[0[059]|6｜7｜8])|8[0-9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileNum];
}

#pragma mark 邮箱验证
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark 密码验证
+(BOOL)isValidatePassword:(NSString *)password
{
    if(password != nil || password.length != 0)
    {
        //设置密码位数
        if (password.length >= 8 && password.length <= 12) {
            return YES;
        }else
        {
            return NO;
        }
        
    }else
    {
        return NO;
    }
}

//身份证号
+ (BOOL)isValidateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

#pragma mark 护照号
+ (BOOL)isValidatePassport: (NSString *)passport
{
    BOOL flag;
    if (passport.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"(P\\d{7})|(G\\d{8})";
    NSPredicate * passportTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [passportTest evaluateWithObject:passport];
}


//uuid
//+(NSString *)uuid
//{
//    CFUUIDRef puuid = CFUUIDCreate( nil );
//    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
//    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
//    CFRelease(puuid);
//    CFRelease(uuidString);
//    return result;
//}


@end






