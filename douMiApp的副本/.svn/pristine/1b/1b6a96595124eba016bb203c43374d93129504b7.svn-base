//
//  PaymentView.h
//  douMiApp
//
//  Created by ydz on 2017/1/14.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayTypeMode,UnifyMode;
@protocol paymentDelegate <NSObject>
@optional
- (void)selectPayment:(NSString *)typePay;//选择支付方式
- (void)paymentAffirmDelegate;//确认
@end

@interface PaymentView : UIView

@property (strong, nonatomic) UILabel *titleLable;//title
@property (strong, nonatomic) UILabel *moneyLable;//实际支付
@property (strong, nonatomic) UILabel *errorLable;//错误提示
@property (strong, nonatomic) PayTypeMode *mode;
@property (weak, nonatomic) id<paymentDelegate>delegate;
- (void)startAnimationFunction;//弹出
- (void)CloseAnimationFunction;//收起
@end

@interface UnifyMode : NSObject//为了转换后台的数据
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subTitle;
@property (assign, nonatomic) NSInteger type;
@property (copy, nonatomic) NSString *status;
@end
