//
//  DMcommentView.m
//  douMiApp
//
//  Created by ydz on 2016/12/1.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DMcommentView.h"
#import "YZInputView.h"

@interface DMcommentView()

/**
 *  占位文字View: 为什么使用UITextView，这样直接让占位文字View = 当前textView,文字就会重叠显示
 */
@property (nonatomic, strong) UILabel *placeholderView;

@end

@implementation DMcommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(14, 31,SCREEN_WIDTH-60 , 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineView];
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderView.textColor = placeholderColor;
}

- (void)setPlStr:(NSString *)plStr {
    _plStr = plStr;
    self.placeholderView.text = plStr;
    
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.placeholderView.font = font;
    self.inputView.font = font;
    
}

- (UITextField *)inputView {
    if (!_inputView) {
        _inputView = [[UITextField alloc] initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH-60, 30)];
        
        _inputView.textColor = [UIColor whiteColor];
        _inputView.backgroundColor = [UIColor clearColor];
        _inputView.textAlignment = NSTextAlignmentLeft;
        _inputView.font = [UIFont systemFontOfSize:12];
        [self addSubview:_inputView];
        
    }
    return _inputView;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake(SCREEN_WIDTH-40, 0, 40, 40);
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_sendBtn];
    }
    return _sendBtn;
}

//- (UILabel *)placeholderView {
//    if (!_placeholderView) {
//        _placeholderView = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH-60, 40)];
//        _placeholderView.textColor = [UIColor lightGrayColor];
//        _placeholderView.backgroundColor = [UIColor clearColor];
//        _placeholderView.textAlignment = NSTextAlignmentLeft;
//        
//        [self addSubview:_placeholderView];
//        
//    }
//    return _placeholderView;
//}



@end
