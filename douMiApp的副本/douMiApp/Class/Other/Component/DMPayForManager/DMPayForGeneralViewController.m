//
//  DMPayForGeneralViewController.m
//  douMiApp
//
//  Created by edz on 2016/12/26.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DMPayForGeneralViewController.h"
#import "DMPayForPasswordViewController.h"
#import "DMRewardPayForViewController.h"
#import "DMMeDouJiaPayForViewController.h"

@interface DMPayForGeneralViewController ()

@property (nonatomic, strong) NSString *balance;
@property (nonatomic, strong) NSString *topTitle;
@property (nonatomic, strong) NSString *veId;
@property (nonatomic, strong) NSString *anchorId;
@property (nonatomic, strong) NSString *dynId;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *rewardText;
@property (nonatomic, strong) NSString *ticketAmount;
@property (nonatomic, strong) NSString *rewardMoney;

@end

@implementation DMPayForGeneralViewController

- (instancetype)initWithTitle:(NSString *)topTitle andMoney:(NSString *)money andBalance:(NSString *)balance {
    self = [super init];
    if (self) {
        _topTitle = topTitle;
        _rewardMoney = money;
        _balance = balance;
    }
    return self;
}

- (instancetype)initWithBalance:(NSString *)balance andTitle:(NSString *)title andRewardMoney:(NSString *)rewardMoney andVeId:(NSString *)veId andAnchorId:(NSString *)anchorId andDynId:(NSString *)dynId andChannel:(NSString *)channel andRewardText:(NSString *)rewardText andTicketAmount:(NSString *)ticketAmount {
    self = [super init];
    if (self) {
        _balance = balance;
        _topTitle = title;
        _veId = veId;
        _anchorId = anchorId;
        _dynId = dynId;
        _channel = channel;
        _rewardText = rewardText;
        _ticketAmount = ticketAmount;
        _rewardMoney = rewardMoney;
    }
    return self;
}


- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 300));
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIButton *bgButton = [[UIButton alloc] init];
    bgButton.backgroundColor = [UIColor clearColor];
    [bgButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgButton];
    [bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_equalTo(bgView.mas_top).offset(-10);
    }];
    
    UIButton *closeBtn = [[UIButton alloc] init];
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [closeBtn addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.top.mas_equalTo(12);
        make.right.mas_equalTo(bgView.mas_right).offset(-13);
    }];
    
    UIImageView *topLine = [[UIImageView alloc] init];
    topLine.backgroundColor = [UIColor blackColor];
    [bgView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 2));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(closeBtn.mas_bottom).offset(12);
    }];
    
    
    UILabel *titleLab = [self getLabelWithTitle:_topTitle andTitleColor:RGBA(41, 41, 41, 1) andFont:DMFont(16)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(52);
        make.right.mas_equalTo(bgView.mas_right).offset(-52);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(topLine.mas_top);
    }];
    
    // 实际支付金额
    NSString *actualMoney = [NSString stringWithFormat:@"%.2f", [_rewardMoney floatValue]];
    if (!isEmpty(_ticketAmount)) { // 用打赏券
        if ([_rewardMoney floatValue]-[_ticketAmount floatValue] > 0) {
            actualMoney = [NSString stringWithFormat:@"%.2f", [_rewardMoney floatValue]-[_ticketAmount floatValue]];
        } else {
            actualMoney = @"0.00";
        }
    }
    
    UIView *itemView = [self loadItemViewWithBalance:_balance andActualMoney:actualMoney];
    [bgView addSubview:itemView];
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 61));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(topLine.mas_bottom);
    }];
    
    UILabel *moneyLab = [self getLabelWithTitle:actualMoney andTitleColor:RGBA(8, 145, 232, 1) andFont:DMFontBold(16)];
    moneyLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:moneyLab];
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 18));
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.top.mas_equalTo(itemView.mas_bottom).offset(27);
    }];
    
    UIImageView *seperateImage = [[UIImageView alloc] init];
    seperateImage.image = [UIImage imageNamed:@"ZFLine"];
    [bgView addSubview:seperateImage];
    [seperateImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(101, 3));
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.top.mas_equalTo(moneyLab.mas_bottom).offset(10);
    }];
    
    UILabel *payLab = [self getLabelWithTitle:@"实际支付" andTitleColor:RGBA(40, 40, 40, 1) andFont:DMFont(12)];
    payLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:payLab];
    [payLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 15));
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.top.mas_equalTo(seperateImage.mas_bottom).offset(10);
    }];
    
    UIButton *sureBtn = [[UIButton alloc] init];
    sureBtn.titleLabel.font = DMFont(12);
    if ([_balance floatValue] < [moneyLab.text floatValue]) { // 余额不足
        sureBtn.backgroundColor = [UIColor grayColor];
        sureBtn.userInteractionEnabled = NO;
    } else {
        sureBtn.backgroundColor = RGBA(60, 60, 60, 1);
        sureBtn.userInteractionEnabled = YES;
    }
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(42);
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.top.mas_equalTo(payLab.mas_bottom).offset(27);
        make.height.mas_equalTo(41);
    }];
  
}


// balance: 余额 actualMoney:实际金额
- (UIView *)loadItemViewWithBalance:(NSString *)balance andActualMoney:(NSString *)actualMoney {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 31, 31)];
    iconImage.image = [UIImage imageNamed:@"钱币"];
    [view addSubview:iconImage];
    
    UILabel *title = [self getLabelWithTitle:@"余额" andTitleColor:RGBA(41, 41, 41, 1) andFont:DMFontBold(12)];
    title.frame = CGRectMake(60, 14, 200, 14);
    [view addSubview:title];
    if (_type == DMPayForTypeMeDouJiaRollOut) {
        title.text = @"蜜豆荚";
    }
    
    UILabel *numLab = [self getLabelWithTitle:[NSString stringWithFormat:@"%@元", _balance] andTitleColor:RGBA(139, 139, 139, 1) andFont:DMFont(12)];
    numLab.frame = CGRectMake(title.mj_x, title.mj_y+title.mj_h+5, title.mj_w, title.mj_h);
    [view addSubview:numLab];
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(15, iconImage.mj_y+iconImage.mj_h+14, SCREEN_WIDTH-15, 0.5)];
    bottomLine.backgroundColor = RGBA(139, 139, 139, 1);
    [view addSubview:bottomLine];
    
    UIImageView *checkImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-33, 23, 20, 14)];
    checkImage.image = [UIImage imageNamed:@"蓝对号"];
    [view addSubview:checkImage];
    
    if ([balance floatValue] < [actualMoney floatValue]) { // 余额不足
        title.textColor = [UIColor grayColor];
        checkImage.hidden = YES;
    } else {
        title.textColor = RGBA(41, 41, 41, 1);
        checkImage.hidden = NO;
    }
    
    return view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)sureButtonClick {
    if (_type == DMPayForTypeReward) { // 打赏
        
        DMRewardPayForViewController *controller = [[DMRewardPayForViewController alloc] initWithTitle:_rewardMoney andVeId:_veId andAnchorId:_anchorId andDynId:_dynId andChannel:_channel andRewardText:_rewardText];
        controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:controller animated:YES completion:nil];
   
    } else if (_type == DMPayForTypeMeDouJiaRollIn) { // 转入蜜豆荚
       
        DMMeDouJiaPayForViewController *controller = [[DMMeDouJiaPayForViewController alloc] initWithMoney:_rewardMoney];
        controller.type = DMPayForRollTypeIn;
        controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:controller animated:YES completion:nil];
    
    } else if (_type == DMPayForTypeMeDouJiaRollOut) { // 转出蜜豆荚
       
        DMMeDouJiaPayForViewController *controller = [[DMMeDouJiaPayForViewController alloc] initWithMoney:_rewardMoney];
        controller.type = DMPayForRollTypeOut;
        controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:controller animated:YES completion:nil];
    
    }
}


- (void)closeButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}


- (UILabel *)getLabelWithTitle:(NSString *)title andTitleColor:(UIColor *)color andFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.text = title;
    label.textColor = color;
    label.font = font;
    return label;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
