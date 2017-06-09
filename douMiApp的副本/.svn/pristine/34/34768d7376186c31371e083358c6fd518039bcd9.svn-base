//
//  DMPayForPasswordViewController.m
//  douMiApp
//
//  Created by edz on 2016/12/27.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DMPayForPasswordViewController.h"
#import "DMPayForGeneralModel.h"
#import "ForgetLoginController.h"
#import "IQKeyboardManager.h"


#define fieldWH (SCREEN_WIDTH-130)/6
#define fieldMargin 10

@interface DMPayForPasswordViewController ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableArray *fieldArray;
@property (nonatomic, strong) UITextField *topTextField;

@end

@implementation DMPayForPasswordViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _fieldArray = [NSMutableArray array];
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO; // 隐藏键盘工具栏

    if (_topTextField) {
        [_topTextField becomeFirstResponder];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES; // 显示键盘工具栏
}


- (void)loadView {
    [super loadView];
    
    //使用NSNotificationCenter 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardStateWillChanged:) name:UIKeyboardWillShowNotification object:nil];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    UIButton *bgButton = [[UIButton alloc] init];
    bgButton.backgroundColor = [UIColor clearColor];
    [bgButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgButton];
    [bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_equalTo(_bgView.mas_top).offset(-10);
    }];

    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, 11, 22, 20)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:backBtn];
    
    UILabel *titleLab = [self getLabelWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 12, 100, 18) andText:@"支付密码" andTextColor:RGBA(41, 41, 41, 1) andFont:DMFont(16)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:titleLab];
    
    UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, 2)];
    topLine.backgroundColor = [UIColor blackColor];
    [_bgView addSubview:topLine];
    
    [self setPayForField];
    
    UIButton *pwBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-81, 93+fieldWH+20, 41, 12)];
    pwBtn.backgroundColor = [UIColor clearColor];
    pwBtn.titleLabel.font = DMFont(10);
    [pwBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    [pwBtn setTitleColor:RGBA(40, 40, 40, 1) forState:UIControlStateNormal];
    [pwBtn addTarget:self action:@selector(findPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:pwBtn];
    
    _errorLab = [self getLabelWithFrame:CGRectMake(40, pwBtn.mj_y, SCREEN_WIDTH-135, 12) andText:@"" andTextColor:RGBA(255, 42, 80, 1) andFont:DMFont(10)];
    [_bgView addSubview:_errorLab];
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, _bgView.mj_h-0.5, SCREEN_WIDTH, 0.5)];
    bottomLine.backgroundColor = RGBA(60, 60, 60, 1);
    [_bgView addSubview:bottomLine];
}


- (void)setPayForField {
    _topTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, 230)];
    _topTextField.hidden = YES;
    _topTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_topTextField addTarget:self action:@selector(txchange:) forControlEvents:UIControlEventEditingChanged];
    [_bgView addSubview:_topTextField];
    
    //进入界面，topTX成为第一响应
    [_topTextField becomeFirstResponder];
    
    for (int i = 0; i < 6; i ++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40+(fieldWH+fieldMargin-0.5)*i, 93, fieldWH, fieldWH)];
        textField.layer.borderColor = RGBA(60, 60, 60, 1).CGColor;
        textField.layer.borderWidth = 0.5;
        textField.enabled = NO;
        textField.textAlignment = NSTextAlignmentCenter;//居中
//        textField.secureTextEntry = YES;//设置密码模式
        [_bgView addSubview:textField];
        
        [_fieldArray dm_addObject:textField];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"backback" object:nil];
}


- (void)back{
    if (_topTextField) {
        [_topTextField becomeFirstResponder];
    }
}


#pragma mark 文本框内容改变
- (void)txchange:(UITextField *)tx{
    NSString *password = tx.text;
    for (int i = 0; i < _fieldArray.count; i++) {
        UITextField *pwdtx = [_fieldArray objectAtIndex:i];
        if (i < password.length) {
//            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
//            pwdtx.text = pwd;
            pwdtx.text = @"◆";
        } else {
            pwdtx.text = @"";
        }
    }
    
    if (password.length == _fieldArray.count) {
        [self requestWithPassword:password];
    }
}


- (void)requestWithPassword:(NSString *)password {
    NSLog(@"**************************");
}


- (void)backButtonClick {
    [_topTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)findPasswordBtnClick {
    ForgetLoginController *forgetLogin = [[ForgetLoginController alloc] initWithNibName:@"ForgetLoginController" bundle:nil];
    forgetLogin.type = @"30";
    forgetLogin.phone = [BusinessLogic getPhoneNo];
    [self presentViewController:forgetLogin animated:YES completion:nil];
}


- (void)keyboardStateWillChanged:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    _bgView.mj_y = SCREEN_HEIGHT-kbSize.height-_bgView.mj_h;
}


- (UILabel *)getLabelWithFrame:(CGRect)rect andText:(NSString *)text andTextColor:(UIColor *)textColor andFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
