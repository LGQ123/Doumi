//
//  DMPayForManager.m
//  douMiApp
//
//  Created by edz on 2016/12/26.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DMPayForManager.h"
#import "DMPayForGeneralViewController.h"


@interface DMPayForManager ()

@property (nonatomic, weak) UIViewController *target;

@end

@implementation DMPayForManager


- (id)initWithTarget:(UIViewController *)target {
    self = [super init];
    if (self) {
        self.target = target;
    }
    return self;
}

- (void)loadPayForViewWithBalance:(NSString *)balance andTitle:(NSString *)title andRewardMoney:(NSString *)rewardMoney andVeId:(NSString *)veId andAnchorId:(NSString *)anchorId andDynId:(NSString *)dynId andChannel:(NSString *)channel andRewardText:(NSString *)rewardText andTicketAmount:(NSString *)ticketAmount{
    DMPayForGeneralViewController *controller = [[DMPayForGeneralViewController alloc] initWithBalance:balance andTitle:title andRewardMoney:rewardMoney  andVeId:veId andAnchorId:anchorId andDynId:dynId andChannel:channel andRewardText:rewardText andTicketAmount:ticketAmount];
    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    controller.type = DMPayForTypeReward; // 打赏
//    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.target presentViewController:controller animated:YES completion:nil];
}


- (void)loadPayForGeneralViewWithToptitle:(NSString *)topTitle {
//    DMPayForGeneralViewController *controller = [[DMPayForGeneralViewController alloc] initWithTitle:topTitle andMoney:<#(NSString *)#> andBalance:<#(NSString *)#>];
//    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    controller.type = DMPayForTypeMeDouJia;
//    [self.target presentViewController:controller animated:YES completion:nil];
}


@end
