//
//  PayTypeMode.h
//  douMiApp
//
//  Created by ydz on 2017/1/14.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AccountInfo,BankInfo,CreditInfo,PodsInfo;
@interface PayTypeMode : NSObject
@property (copy, nonatomic)NSString *resmsg;
@property (copy, nonatomic)NSString *rescode;
@property (strong, nonatomic) AccountInfo *accountInfo;//余额
@property (strong, nonatomic) BankInfo *bankInfo;//银行卡
@property (strong, nonatomic) CreditInfo *creditInfo;//蜜信
@property (strong, nonatomic) PodsInfo *podsInfo;//蜜豆荚

@end

@interface AccountInfo : NSObject

@property (copy, nonatomic) NSString *status;//是否可用
@property (copy, nonatomic) NSString *payType;//类型
@property (assign, nonatomic) NSInteger usalbeAmount;

@end
@interface BankInfo : NSObject
@property (copy, nonatomic) NSString *status;//是否可用
@property (copy, nonatomic) NSString *payType;//类型
@property (copy, nonatomic) NSString *bankName;
@property (copy, nonatomic) NSString *bankCard;
@property (assign, nonatomic) NSInteger bankId;
@property (copy, nonatomic) NSString *bindId;
@end
@interface CreditInfo : NSObject
@property (copy, nonatomic) NSString *status;//是否可用
@property (copy, nonatomic) NSString *payType;//类型
@property (copy, nonatomic) NSString *overdueStatus;//是否逾期
@property (assign, nonatomic) NSInteger creditAmount;

@end
@interface PodsInfo : NSObject
@property (copy, nonatomic) NSString *status;//是否可用
@property (copy, nonatomic) NSString *payType;//类型
@property (assign, nonatomic) NSInteger redeemAmount;
@end
