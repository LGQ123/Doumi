//
//  PopupPawView.m
//  douMiApp
//
//  Created by ydz on 2016/12/30.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "PopupPawView.h"
#import "PasswordEnterView.h"
#import "PasswordTextField.h"
#import "Masonry.h"
@interface PopupPawView ()
@property (nonatomic,strong)PasswordTextField *textFieldOne;
@property (nonatomic, strong) UITapGestureRecognizer *ges;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *foundPawBtn;
@property (nonatomic, assign) CGSize kbSize;
@end

@implementation PopupPawView


- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [window addSubview:self];
        UIView *blackView1 = [UIView new];
        blackView1.backgroundColor = RGB16(0x000000);
        blackView1.alpha = 0.6f;
        blackView1.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubview:blackView1];
        self.ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestureCloseSelectViewAnimation:)];
        [self.window bringSubviewToFront:self];
        [blackView1 addGestureRecognizer:self.ges];
        self.backView = [UIView new];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 220);
        //self.backView.center = CGPointMake(nc_ScreenWidth/2.0f, nc_ScreenHeight+130);
        [self addSubview:self.backView];
        [self creadtionSub];
        self.hidden = YES;
        [self registerForKeyboardNotifications];
        
    }
    
    return self;
    
    

}


- (void)creadtionSub {
    UIView *sub = self.backView;
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [sub addSubview:self.backBtn];
    
    
    self.errorLable = [[UILabel alloc] init];
    self.errorLable.textAlignment = NSTextAlignmentLeft;
    self.errorLable.textColor = RGBA(255, 40, 80, 1);
    self.errorLable.font = [UIFont systemFontOfSize:10];
    self.errorLable.hidden = YES;
    [sub addSubview:self.errorLable];
    
    self.titleLable = [[UILabel alloc] init];
    self.titleLable.textColor =RGBA(41, 41, 41, 1);
    self.titleLable.font = [UIFont systemFontOfSize:16];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.text = @"支付密码";
    [sub addSubview:self.titleLable];
    
    self.foundPawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.foundPawBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.foundPawBtn setTitleColor:RGBA(40, 40, 40, 1) forState:UIControlStateNormal];
    self.foundPawBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.foundPawBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.foundPawBtn addTarget:self action:@selector(foundPawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sub addSubview:self.foundPawBtn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBA(60, 60, 60, 1);
    [sub addSubview:lineView];
    
    
    PasswordEnterView *_enterView2 = [[PasswordEnterView alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH,40) count:6 isCiphertext:YES type:@"bai" textField:^(PasswordTextField *textField) {
        
        _textFieldOne = textField;
        
    }];
    
    _enterView2.textDetail = ^(NSString *textDetail){
       
        if (textDetail.length == 6) {
            NSLog(@"噜噜噜噜%@",_textFieldOne.text);
            if ([self.delegate respondsToSelector:@selector(popupPaw:)]) {
                [self.delegate popupPaw:textDetail];
            }
        }
    };
    _enterView2.backgroundColor = [UIColor whiteColor];
    [sub addSubview:_enterView2];
    
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(13);
        make.centerX.equalTo(sub.mas_centerX);
        make.width.equalTo(@(SCREEN_WIDTH-100));
        make.height.equalTo(@17);
    }];
    
    
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(10);
        make.left.equalTo(sub.mas_left).offset(10);
        make.width.equalTo(@22);
        make.height.equalTo(@20);
    }];
    
    
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(40);
        make.left.equalTo(sub);
        make.right.equalTo(sub);
        make.height.equalTo(@1);
    }];
    
    
    [self.errorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(160);
        make.left.equalTo(sub.mas_left).offset((SCREEN_WIDTH-290)/2);
        make.height.equalTo(@11);
        make.width.equalTo(@200);
    }];
    
    
    [self.foundPawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(sub.mas_top).offset(140);
        make.right.equalTo(sub.mas_right).offset(-(SCREEN_WIDTH-290)/2);
        make.height.equalTo(@50);
        make.width.equalTo(@41);
    }];
    
}




- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)startAnimationFunction{
    UIView *AnView = self.backView;
    [_textFieldOne becomeFirstResponder];
    self.hidden = NO;
    CGRect rect = AnView.frame;
    rect.origin.y = SCREEN_HEIGHT-220-_kbSize.height;
    [self.window bringSubviewToFront:self];
    [UIView animateWithDuration:0.4f animations:^{
        
        AnView.frame = rect;
    }];
    
    
    
}
- (void)CloseAnimationFunction{
    
    UIView *AnView = self.backView;
    CGRect rect = AnView.frame;
    rect.origin.y = SCREEN_HEIGHT;
    [_textFieldOne resignFirstResponder];
    [UIView animateWithDuration:0.4f animations:^{
        AnView.frame = rect;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}
//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    _kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    
    
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self CloseAnimationFunction];
}

- (void)GestureCloseSelectViewAnimation:(UIGestureRecognizer *)ges{
    
    [self CloseAnimationFunction];
}

- (void)dealloc{
    
    self.ges = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)backClick:(UIButton *)sender {
    [self CloseAnimationFunction];
}

- (void)foundPawBtnClick:(UIButton *)sender {
    [self CloseAnimationFunction];
    if ([self.delegate respondsToSelector:@selector(foundPawDelegate)]) {
        [self.delegate foundPawDelegate];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
