//
//  DMMeDouJiaModel.h
//  douMiApp
//
//  Created by edz on 2017/1/11.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMBaseModel.h"


@class DMMeDouRollInOutModel;
@class DMMeDouJiaDetailModel;
@class DMMeDouJiaListMapModel;
@interface DMMeDouJiaModel : DMBaseModel

@property (nonatomic, strong) NSString *earningsYesterday; // 昨日收益
@property (nonatomic, strong) NSString *newerSubscription; // 蜜豆荚余额
@property (nonatomic, strong) NSString *accumulatedEarnings; // 累计收益
@property (nonatomic, strong) NSArray *listMap; // 折线图数据 DMMeDouJiaListMapModel

@end


@interface DMMeDouJiaListMapModel : NSObject

@property (nonatomic, strong) NSString *interest; // 利率
@property (nonatomic, strong) NSString *interestDate; // 日期

@end


#pragma mark 蜜豆荚转入转出
@interface DMMeDouRollInOutModel : DMBaseModel

@property (nonatomic, strong) NSString *startCalcInterestDate; // 开始计息日期
@property (nonatomic, strong) NSString *interestArrivalDate; // 利息反馈日期

@end


#pragma mark 蜜豆荚明细列表
@interface DMMeDouJiaListModel : DMBaseModel

@property (nonatomic, strong) NSArray *results; // DMMeDouJiaDetailModel
@property (nonatomic, strong) NSString *totalRecord;
@property (nonatomic, strong) NSString *totalPage;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *pageNo;

@end


@interface DMMeDouJiaDetailModel : NSObject

@property (nonatomic, strong) NSString *mId; // 用户id
@property (nonatomic, strong) NSString *income; // 收入
@property (nonatomic, strong) NSString *balance; // 余额
@property (nonatomic, strong) NSString *outlay; // 支出
@property (nonatomic, strong) NSString *type; // 类型
@property (nonatomic, strong) NSString *subTime; // 转入支出时间
@property (nonatomic, strong) NSString *subProduceTime; // 产生收益时间
@property (nonatomic, strong) NSString *subEarningsTime; // 收益到账时间
@property (nonatomic, strong) NSString *remark; // 备注(标题)

@end








