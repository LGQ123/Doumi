//
//  DMMeXinModel.h
//  douMiApp
//
//  Created by edz on 2017/1/16.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "DMBaseModel.h"


@class DMMeXinCreditInfoModel;
@class DMMeXinRealNameModel;
@class DMMeXinBankInfoModel;

@interface DMMeXinModel : DMBaseModel

@property (nonatomic, strong) DMMeXinCreditInfoModel *creditInfo;

@end


// 授信资料对象
@interface DMMeXinCreditInfoModel : NSObject

@property (nonatomic, strong) NSString *userId; // 会员ID
@property (nonatomic, strong) NSString *overdueStatus; // 目前是否逾期 （1:逾期，0：未逾期）
@property (nonatomic, strong) NSString *creditStatus; // 授信状态;（0:未认证;2：已认证;3：拒绝）
@property (nonatomic, strong) NSString *creditAmount; // 授信额度
@property (nonatomic, strong) NSString *borrowAmount; // 已用额度
@property (nonatomic, strong) NSString *leftAmount; // 剩余额度

@end


// 实名认证
@interface DMMeXinRealNameModel : DMBaseModel

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *realName; // 姓名
@property (nonatomic, strong) NSString *idCard; // 身份证号

@end


@interface DMMeXinBankInfoModel : DMBaseModel

@property (nonatomic, strong) NSString *bankId; // 银行卡id
@property (nonatomic, strong) NSString *bank; // 所属银行
@property (nonatomic, strong) NSString *bankCard; // 银行卡号
@property (nonatomic, strong) NSString *bankInfo; // 银行卡图标

@end



