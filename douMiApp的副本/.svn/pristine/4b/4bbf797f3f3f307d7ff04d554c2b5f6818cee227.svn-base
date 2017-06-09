//
//  PasswordEnterView.m
//  FJF
//
//  Created by fengjiefeng on 15/8/8.
//  Copyright (c) 2015年 fengjiefeng. All rights reserved.
//
#define FJFW_Screen        ([UIScreen mainScreen].bounds.size.width)
#define FJFH_Screen        ([UIScreen mainScreen].bounds.size.height)
#define FJFW_SelfView      (self.bounds.size.width)
#define FJFH_SelfView      (self.bounds.size.height)

#define TAG 500

#define RGBA(r, g, b, a)   [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]

#define RGB(r, g, b)        RGBA(r, g, b, 1.0)

#import "PasswordEnterView.h"

@interface PasswordEnterView ()<UITextFieldDelegate>
@property (nonatomic,strong)PasswordTextField *tfInViewCode;
@property (nonatomic,strong)UILabel *lblShow;
@property (nonatomic,copy)NSString *string;
@property (nonatomic,assign)NSInteger length;

@property (nonatomic,strong)NSMutableArray *arrCount;
@property (nonatomic,copy)ClickedHandler returnClick;

@property (nonatomic,assign)CGFloat tfWidth;
@property (nonatomic,assign)NSInteger intCount;
@property (nonatomic,assign)BOOL isCiphertext;

@end

@implementation PasswordEnterView

- (id)initWithFrame:(CGRect)frame count:(NSInteger)count isCiphertext:(BOOL)isCiphertext type:(NSString *)type textField:(ClickedHandler)textField
{
    self = [super initWithFrame:frame];
    if (self) {
        _returnClick = [textField copy];
        _intCount = count;
        _isCiphertext = isCiphertext;
        _arrCount = [NSMutableArray array];
        _tfWidth = self.frame.size.height;
        self.type = type;
        [self initTextFielView];
    }
    return self;
}
- (void)initTextFielView{
    
    for (NSInteger i=0; i<_intCount; i++) {
        [_arrCount addObject:@""];
    }
    _tfInViewCode= [[PasswordTextField alloc] initWithFrame:CGRectMake(0, 0, FJFW_SelfView, _tfWidth)];
    _tfInViewCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _tfInViewCode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tfInViewCode.textAlignment =NSTextAlignmentCenter;
    _tfInViewCode.keyboardType = UIKeyboardTypeNumberPad;
    _tfInViewCode.tintColor=[UIColor clearColor];
    
    if ([self.type isEqualToString:@"bai"]) {
        _tfInViewCode.textColor = [UIColor whiteColor];
    } else {
        _tfInViewCode.textColor = RGBA(247, 247, 247, 1);
    }
    _tfInViewCode.delegate = self;
    [self addSubview:_tfInViewCode];
    
    for (NSInteger i=0; i <_intCount; i ++) {
        _lblShow= [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-290)/2+i*_tfWidth+i*10,0,_tfWidth, _tfWidth)];
        _lblShow.tag = i+TAG;
        _lblShow.font = [UIFont systemFontOfSize:20];
        _lblShow.textColor =RGBA(60, 60, 60, 1);
        _lblShow.layer.borderWidth = 0.6;
        _lblShow.layer.borderColor = RGBA(160, 160, 160, 1).CGColor;
        if ([self.type isEqualToString:@"bai"]) {
            _lblShow.backgroundColor = [UIColor whiteColor];
        } else {
            _lblShow.backgroundColor = RGBA(247, 247, 247, 1);
        }
        
        _lblShow.textAlignment = NSTextAlignmentCenter;
        _lblShow.text = @"";
        [self addSubview:_lblShow];
    }
    if (_returnClick) {
        _returnClick(_tfInViewCode);
    }

}

#pragma mark - UITextFieldDelegate
//手机号定义为数字输入
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _string = string;
    if (_isCiphertext&&(![_string isEqual:@""])) {
        _string = @"◆";
    }
    NSInteger length = textField.text.length;
    if (length >= _intCount)
    {
        if ([_string isEqualToString:@""]) {
            [self performSelector:@selector(invitedCodeClick) withObject:nil afterDelay:0.01];
            return YES;
        }
        return  NO;
    }
    [self performSelector:@selector(invitedCodeClick) withObject:nil afterDelay:0.01];
    return YES;
}
- (void)invitedCodeClick
{
    _length=_tfInViewCode.text.length;
    NSLog(@"aaaaa%@",_tfInViewCode.text);
    if (_length> _intCount) {
        return;
    }
    if (_length == _intCount && ![_string isEqualToString:@""]) {
        if (_textDetail) {
            _textDetail(_tfInViewCode.text);
        }
    }
    
    if (_arrCount.count >0) {
        if ((_length>0)&&(_length<_intCount)) {
            for (NSInteger i=0; i<_intCount-1; i++) {
                if (_length==i+1) {
                    
                    if ([_string isEqual:@""]) {
                        [_arrCount replaceObjectAtIndex:_length withObject:_string];
                        [self showInVitedCodeArr:_arrCount];
                        return;
                    }
                    [_arrCount replaceObjectAtIndex:i withObject:_string];
                    [self showInVitedCodeArr:_arrCount];
                }
                
            }
        }
        else if(_length==_intCount){
            [_arrCount replaceObjectAtIndex:_intCount-1 withObject:_string];
            [self showInVitedCodeArr:_arrCount];
        }
        else if(_length==0){
            for (NSInteger i=0; i <_intCount; i++) {
                [_arrCount replaceObjectAtIndex:i withObject:@""];
            }
            [self showInVitedCodeArr:_arrCount];
        }
        else{
            
        }
    }
}

-(void)dealloc{
    _arrCount = nil;
}
-(void)showInVitedCodeArr:(NSMutableArray*)arr{
    for (NSInteger i=0; i<_intCount; i++) {
        ((UILabel *)[self viewWithTag:TAG+i]).text = _arrCount[i];
    }
}

@end
