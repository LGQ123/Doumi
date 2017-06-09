//
//  BackInforMode.h
//  douMiApp
//
//  Created by ydz on 2016/12/27.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class bankInfo,bankDetail;
@interface BackInforMode : NSObject

@property (copy, nonatomic) NSString *bankCard;
@property (copy, nonatomic) NSString *documentType;
@property (copy, nonatomic) NSString *idCard;
@property (copy, nonatomic) NSString *realName;
@property (copy, nonatomic) NSString *rescode;
@property (copy, nonatomic) NSString *resmsg;
@property (strong, nonatomic) NSArray<bankInfo *>*bankInfo;
@end

@interface bankInfo : NSObject
@property (copy, nonatomic) NSString *alias;
@property (strong, nonatomic)bankDetail *bankDetail;

@end

@interface bankDetail : NSObject
@property (copy, nonatomic) NSString *ceiling;
@property (copy, nonatomic) NSString *dailyCashWithdrawals;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *singleCharge;
@property (copy, nonatomic) NSString *singleLift;
@property (copy, nonatomic) NSString *url;

@end
