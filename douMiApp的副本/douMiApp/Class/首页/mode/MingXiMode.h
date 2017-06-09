//
//  MingXiMode.h
//  douMiApp
//
//  Created by ydz on 2017/1/18.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RepaymentInfo,RepaymentDetails;

@interface MingXiMode : NSObject

@property (copy, nonatomic) NSString *rescode;
@property (copy, nonatomic) NSString *resmsg;
@property (strong, nonatomic) RepaymentInfo *repaymentInfo;

@end
@interface RepaymentInfo : NSObject

@property (assign, nonatomic) NSInteger bId;
@property (copy, nonatomic) NSString* status;
@property (assign, nonatomic) NSInteger overdueAmount;
@property (assign, nonatomic) NSInteger overdueDays;
@property (assign, nonatomic) NSInteger overdueFine;
@property (strong, nonatomic) NSArray <RepaymentDetails *>*repaymentDetails;
@end

@interface RepaymentDetails : NSObject

@property (assign, nonatomic) NSInteger Id;
@property (assign, nonatomic) NSInteger principal;
@property (assign, nonatomic) NSInteger interest;
@property (assign, nonatomic) NSInteger principalInterest;
@property (assign, nonatomic) NSInteger status;
@property (assign, nonatomic) NSInteger monthManage;
@property (copy, nonatomic) NSString *currentPeriod;
@property (copy, nonatomic) NSString *refundDate;


@end
