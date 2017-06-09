//
//  DMPayForGeneralViewController.h
//  douMiApp
//
//  Created by edz on 2016/12/26.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNViewController.h"
#import "DMRewardRootViewController.h"


typedef enum {

    DMPayForTypeReward, // 打赏
    DMPayForTypeMeDouJiaRollIn, // 转入蜜豆荚
    DMPayForTypeMeDouJiaRollOut // 转出蜜豆荚
    
}DMPayForType; // 支付类型

@interface DMPayForGeneralViewController : DMRewardRootViewController

@property (nonatomic, assign) DMPayForType type;

/* 加载支付通用页面(打赏)
 * balance : 余额
 * title : 支付信息(标题)
 * rewardMoney : 打赏金额
 * veId : 打赏券Id（是否使用打赏券进行的打赏，若不适用则为空）
 * anchorId : 主播id，即发表动态的人
 * dynId : 动态id
 * channel : 动态类型（0:动态，1:话题动态）
 * rewardText : 打赏评论
 * ticketAmount: 打赏券金额（是否使用打赏券进行的打赏，若不适用则为空）
 */
- (instancetype)initWithBalance:(NSString *)balance andTitle:(NSString *)title andRewardMoney:(NSString *)rewardMoney andVeId:(NSString *)veId andAnchorId:(NSString *)anchorId andDynId:(NSString *)dynId andChannel:(NSString *)channel andRewardText:(NSString *)rewardText andTicketAmount:(NSString *)ticketAmount;


/* 加载支付通用页面(购买蜜豆荚)
 * topTitle: 支付信息(标题)
 * money: 转入蜜豆荚金额
 * balance: 余额
 */
- (instancetype)initWithTitle:(NSString *)topTitle andMoney:(NSString *)money andBalance:(NSString *)balance;

@end
