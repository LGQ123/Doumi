//
//  DMPayForManager.h
//  douMiApp
//
//  Created by edz on 2016/12/26.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMPayForManager : NSObject

- (id)initWithTarget:(UIViewController *)target;

/* 加载支付通用页面(打赏)
 * balance : 余额
 * title : 支付信息(标题)
 * rewardMoney : 打赏金额
 * veId : 打赏券Id（是否使用打赏券进行的打赏，若未使用则为空）
 * anchorId : 主播id，即发表动态的人
 * dynId : 动态id
 * channel : 动态类型（0:动态，1:话题动态）
 * rewardText: 打赏评论
 * ticketAmount: 打赏券金额（是否使用打赏券进行的打赏，若未使用则为空）
 */
- (void)loadPayForViewWithBalance:(NSString *)balance andTitle:(NSString *)title andRewardMoney:(NSString *)rewardMoney andVeId:(NSString *)veId andAnchorId:(NSString *)anchorId andDynId:(NSString *)dynId andChannel:(NSString *)channel andRewardText:(NSString *)rewardText andTicketAmount:(NSString *)ticketAmount;


/* 加载支付通用页面(购买蜜豆荚)
 * topTitle:标题
 */
- (void)loadPayForGeneralViewWithToptitle:(NSString *)topTitle;

@end
