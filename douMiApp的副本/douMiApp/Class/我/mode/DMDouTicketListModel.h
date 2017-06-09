//
//  DMDouTicketModel.h
//  douMiApp
//
//  Created by edz on 2016/12/30.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DMDouTicketModel;

@interface DMDouTicketListModel : NSObject

@property (nonatomic, strong) NSArray *mapList; // DMDouTicketModel
@property (nonatomic, strong) NSString *rescode;
@property (nonatomic, strong) NSString *resmsg;

@end



@interface DMDouTicketModel : NSObject

@property (nonatomic, strong) NSString *name; // 名称
@property (nonatomic, strong) NSString *beginTime; // 开始时间
@property (nonatomic, strong) NSString *endTime; // 结束时间
@property (nonatomic, strong) NSString *content; // 内容
@property (nonatomic, strong) NSString *businessAddress; // 内容
@property (nonatomic, strong) NSString *exchangeNum; // 兑换码
@property (nonatomic, strong) NSString *coverUrl; // 封面
@property (nonatomic, strong) NSString *status; // 状态：0：未使用 1：已使用  （已过期：现在时间比结束时间大）
@property (nonatomic, strong) NSString *type; // 豆券种类 1:商家券 2:充值券 3:打赏券 4: 特权券
@property (nonatomic, strong) NSString *amount; // 金额

@end
