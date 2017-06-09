//
//  DMRewardPayForViewController.h
//  douMiApp
//
//  Created by edz on 2017/1/5.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "DMPayForPasswordViewController.h"

@interface DMRewardPayForViewController : DMPayForPasswordViewController

/* 加载支付通用页面
 * title : 打赏金额
 * veId : 打赏券Id（是否使用打赏券进行的打赏，若未使用则为空）
 * anchorId : 主播id，即发表动态的人
 * dynId : 动态id
 * channel : 动态类型（0:动态，1:话题动态）
 * rewardText: 打赏评论
 */
- (instancetype)initWithTitle:(NSString *)title andVeId:(NSString *)veId andAnchorId:(NSString *)anchorId andDynId:(NSString *)dynId andChannel:(NSString *)channel andRewardText:(NSString *)rewardText;

@end
