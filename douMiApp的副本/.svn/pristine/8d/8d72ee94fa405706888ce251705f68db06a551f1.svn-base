//
//  PopupCodeview.m
//  douMiApp
//
//  Created by ydz on 2016/12/27.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "PopupCodeview.h"
#import "Masonry.h"
@interface PopupCodeview ()
@property (nonatomic, strong) UITapGestureRecognizer *ges;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UIButton *codeBtn;

@property (nonatomic, assign) CGSize kbSize;

@property (nonatomic, assign) int timeout;

@end


@implementation PopupCodeview

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
        [self.phoneText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return self;

}

- (void)textFieldDidChange:(UITextField *)textField
{
        if (textField.text.length >6) {
            textField.text = [textField.text substringToIndex:6];
        }
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


- (void)creadtionSub {
     UIView *sub = self.backView;
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [sub addSubview:self.backBtn];
    
    self.titleLable = [[UILabel alloc] init];
    self.titleLable.textColor =RGBA(41, 41, 41, 1);
    self.titleLable.font = [UIFont systemFontOfSize:16];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    [sub addSubview:self.titleLable];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBA(60, 60, 60, 1);
    [sub addSubview:lineView];
    
    self.codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.codeBtn setBackgroundColor:RGBA(160, 160, 160, 1)];
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.codeBtn addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
    [sub addSubview:self.codeBtn];

    
    
    self.phoneText = [[UITextField alloc] init];
    self.phoneText.font = [UIFont systemFontOfSize:12];
    self.phoneText.textColor = RGBA(60, 60, 60, 1);
    self.phoneText.textAlignment = NSTextAlignmentLeft;
    self.phoneText.layer.borderColor=[RGBA(160, 160, 160, 1) CGColor];
    self.phoneText.layer.borderWidth = 1;
    self.phoneText.keyboardType = UIKeyboardTypePhonePad;
    [sub addSubview:self.phoneText];
    
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmBtn setBackgroundColor:RGBA(60, 60, 60, 1)];
    self.confirmBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [sub addSubview:self.confirmBtn];
    
    self.errorLable = [[UILabel alloc] init];
    self.errorLable.textAlignment = NSTextAlignmentLeft;
    self.errorLable.textColor = RGBA(255, 40, 80, 1);
    self.errorLable.font = [UIFont systemFontOfSize:10];
    self.errorLable.hidden = YES;
    [sub addSubview:self.errorLable];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(10);
        make.left.equalTo(sub.mas_left).offset(10);
        make.width.equalTo(@22);
        make.height.equalTo(@20);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(13);
        make.centerX.equalTo(sub.mas_centerX);
        make.width.equalTo(@(SCREEN_WIDTH-100));
        make.height.equalTo(@17);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(40);
        make.left.equalTo(sub);
        make.right.equalTo(sub);
        make.height.equalTo(@1);
    }];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(80);
        make.right.equalTo(sub.mas_right).offset(-43);
        make.width.equalTo(@(60));
        make.height.equalTo(@(40));
        
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(80);
        make.left.equalTo(sub.mas_left).offset(43);
        make.right.equalTo(self.codeBtn.mas_left).offset(-10);
        make.height.equalTo(@40);
        
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(140);
        make.left.equalTo(sub.mas_left).offset(42);
        make.right.equalTo(sub.mas_right).offset(-42);
        make.height.equalTo(@40);
        
    }];
    
    [self.errorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(190);
        make.left.equalTo(sub.mas_left).offset(42);
        make.right.equalTo(sub.mas_right).offset(-42);
        make.height.equalTo(@11);
    }];
    
}

- (void)startAnimationFunction{
    UIView *AnView = self.backView;
    self.hidden = NO;
    CGRect rect = AnView.frame;
    self.titleLable.text = [NSString stringWithFormat:@"已向您的手机%@发送验证码",self.phone];
    [self.phoneText becomeFirstResponder];
    _timeout = 59;
    [self countDown];
    rect.origin.y = SCREEN_HEIGHT-220-_kbSize.height;
    [self.window bringSubviewToFront:self];
    [UIView animateWithDuration:0.4f animations:^{
        
        AnView.frame = rect;
    }];
    
    
    
}
- (void)CloseAnimationFunction{
    
    UIView *AnView = self.backView;
    [self.codeBtn setTitle:@"验证" forState:UIControlStateNormal];
    [self.phoneText resignFirstResponder];
    _timeout = 0;
    CGRect rect = AnView.frame;
    rect.origin.y = SCREEN_HEIGHT;
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



- (void)backClick:(UIButton *)sender {
    [self CloseAnimationFunction];
}

- (void)codeClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(codeDelegate)]) {
        [self.delegate codeDelegate];
    }
}
- (void)confirmClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(confirmDelegate)]) {
        [self.delegate confirmDelegate];
    }
}

- (void)GestureCloseSelectViewAnimation:(UIGestureRecognizer *)ges{
    
    [self CloseAnimationFunction];
}

- (void)dealloc{
    
    self.ges = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)countDown {
    _codeBtn.enabled = NO;
    [self.codeBtn setBackgroundColor:RGBA(160, 160, 160, 1)];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if(_timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_codeBtn setTitle:@"验证" forState:UIControlStateNormal];
                //                _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                _codeBtn.enabled = YES;
                [self.codeBtn setBackgroundColor:RGBA(60, 60, 60, 1)];
                
            });
        } else {
            int seconds = _timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_codeBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                sender.titleLabel.font = [UIFont systemFontOfSize:12];
                _codeBtn.enabled = NO;
            });
            
            _timeout--;
        }
    });
    dispatch_resume(timer);
    
    
}

@end
