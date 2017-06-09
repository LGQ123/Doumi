//
//  PopupCodeview.h
//  douMiApp
//
//  Created by ydz on 2016/12/27.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol popupCodeDelegate <NSObject>
@optional
- (void)codeDelegate;
- (void)confirmDelegate;

@end

@interface PopupCodeview : UIView

@property (copy, nonatomic)NSString *phone;
@property (strong, nonatomic) UILabel *errorLable;
@property (nonatomic, strong) UITextField *phoneText;
@property (weak, nonatomic) id<popupCodeDelegate>delegate;
@property (nonatomic, strong) UIButton *confirmBtn;

- (void)startAnimationFunction;
- (void)CloseAnimationFunction;
- (void)countDown;
@end
