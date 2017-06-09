//
//  YTicketViewController.h
//  douMiApp
//
//  Created by ydz on 2017/1/16.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTicketMode,VoucherExchangeList;

@protocol YTicketViewDelegate <NSObject>

- (void)returnVoucher:(VoucherExchangeList *)mode;

@end

@interface YTicketViewController : UIViewController

@property (strong, nonatomic)YTicketMode *mode;

@property (weak, nonatomic) id<YTicketViewDelegate>delegate;

@end
