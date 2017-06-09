//
//  DMRewardTicketModel.h
//  douMiApp
//
//  Created by edz on 2016/12/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DMRewardTicketModel;
@interface DMRewardTicketListModel : NSObject

@property (nonatomic, strong) NSArray *voucherExchangeList; // DMRewardTicketModel
@property (nonatomic, strong) NSString *rescode;
@property (nonatomic, strong) NSString *resmsg;

@end



@interface DMRewardTicketModel : NSObject

@property (nonatomic, strong) NSString *userId; // 用户
@property (nonatomic, strong) NSString *mvId; // 券id
@property (nonatomic, strong) NSString *name; // 名称
@property (nonatomic, strong) NSString *endTime; // 过期时间
@property (nonatomic, strong) NSString *amount; // 金额


@end
