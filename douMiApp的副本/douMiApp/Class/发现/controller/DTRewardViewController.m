//
//  DTRewardViewController.m
//  douMiApp
//
//  Created by edz on 2016/12/26.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DTRewardViewController.h"
#import <Masonry/Masonry.h>
#import "MEHomeMode.h"
#import "DMPayForGeneralModel.h"
#import "DMPayForManager.h"
#import "SafetyMode.h"
#import "ForgetLoginController.h"
#import "DMRewardTicketListModel.h"
#import "ForgetPayController.h"


#define closeBtnWH 16
#define bgViewW 291
#define bgViewH 401

@interface DTRewardViewController ()

@property (nonatomic, strong) UILabel *defaultLabel;
@property (nonatomic, strong) UITextView *inputTextView;
@property (nonatomic, strong) UIButton *rewardBtn;
@property (nonatomic, strong) UITextField *numTextField;
@property (nonatomic, strong) UIButton *ticketBtn;
@property (nonatomic, strong) NSString *veId; // 打赏券
@property (nonatomic, strong) NSString *ticketAmount; // 打赏券金额
@property (nonatomic, strong) UILabel *ticketText; // 显示“打赏券”三个字的label
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableArray *rewardTextArr;
@property (nonatomic, strong) UIView *ticketView;
@property (nonatomic, strong) NSMutableArray *ticketArray; // 存放打赏券
@property (nonatomic, strong) NSString *fieldStr; // 打赏金额输入框内容

@property (nonatomic, strong) DMPayForManager *manager;

@end

@implementation DTRewardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    [MobClick beginLogPageView:@"打赏页"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"打赏页"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardStateWillChanged:) name:UIKeyboardWillHideNotification object:nil];

    
    _ticketArray = [NSMutableArray array];
    _rewardTextArr = [NSMutableArray arrayWithObjects:@"听说最近帅圈流行打赏~！",
                                                      @"自从打赏了以后，腰也不酸了，腿也不疼了，一口气上20楼",
                                                      @"听说打赏一个最好看的人可以获得好运",
                                                      @"静静打个赏，我就是静静",
                                                      @"这个赏的如何？元芳你怎么看",
                                                      @"打个赏，美滋滋",
                                                      @"打个赏，美腻腻",
                                                      @"别拦我，我要做打赏将军!",
                                                      @"日出江花红胜火，我不管我就打赏",
                                                      @"美好的一天始于打赏",nil];
    
    self.view.backgroundColor = RGBA(247, 247, 247, 1);
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-14-closeBtnWH, 36, closeBtnWH, closeBtnWH)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    [self loadContentView];
    
    if (!_manager) {
        _manager = [[DMPayForManager alloc] initWithTarget:self];
    }
}


// 监听键盘状态
- (void)keyboardStateWillChanged:(NSNotification*)aNotification {
    if ([aNotification.name isEqualToString:UIKeyboardWillHideNotification]) {
        if (!isEmpty(_fieldStr) && ![_fieldStr containsString:@"元"]) {
            _numTextField.text = [NSString stringWithFormat:@"%@元", _fieldStr];
        }
    }
}


// 加载打赏页面内容
- (void)loadContentView {
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = RGBA(255, 42, 80, 1);
    [self.view addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(bgViewW, bgViewH));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo((SCREEN_HEIGHT-bgViewH)/2.5);
    }];
    
    UIImageView *topBgImageView = [[UIImageView alloc] init];
    topBgImageView.backgroundColor = [UIColor clearColor];
    topBgImageView.image = [UIImage imageNamed:@"RedBao"];
    [_bgView addSubview:topBgImageView];
    [topBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(bgViewW, 170));
        make.left.top.mas_equalTo(0);
    }];
    
    UILabel *title = [self getLabelWithText:@"请输入打赏金额" andTextColor:RGBA(255, 255, 255, 1) andFont:DMFont(10)];
    title.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(72, 12));
        make.top.mas_equalTo(26);
        make.centerX.mas_equalTo(_bgView.mas_centerX);
    }];
    
    _numTextField = [[UITextField alloc] init];
    _numTextField.backgroundColor = [UIColor clearColor];
    _numTextField.delegate = self;
    _numTextField.keyboardType = UIKeyboardTypeDecimalPad;
    _numTextField.textAlignment = NSTextAlignmentCenter;
    _numTextField.textColor = RGBA(255, 180, 0, 1);
    _numTextField.font = DMFont(20);
    _numTextField.placeholder = @"￥ 00.00";
    [_numTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_bgView addSubview:_numTextField];
    [_numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(201, 41));
        make.top.mas_equalTo(60);
        make.centerX.mas_equalTo(_bgView.mas_centerX);
    }];
    
    UIImageView *textFieldImage = [[UIImageView alloc] init];
    textFieldImage.backgroundColor = [UIColor clearColor];
    textFieldImage.image = [UIImage imageNamed:@"1"];
    [_numTextField addSubview:textFieldImage];
    [textFieldImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(231, 65));
        make.centerX.mas_equalTo(_numTextField.mas_centerX);
        make.top.mas_equalTo(_numTextField.mas_top).offset(-12);
    }];
    
    
    _ticketText = [self getLabelWithText:@"打赏券" andTextColor:RGBA(139, 139, 139, 1) andFont:DMFont(10)];
    [_numTextField addSubview:_ticketText];
    _ticketText.hidden = YES;
    [_ticketText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 12));
        make.right.mas_equalTo(_numTextField.mas_right);
        make.centerY.mas_equalTo(_numTextField.mas_centerY);
    }];
    
    
    _ticketBtn = [[UIButton alloc] init];
    _ticketBtn.backgroundColor = [UIColor clearColor];
    _ticketBtn.titleLabel.font = DMFont(12);
    [_ticketBtn setTitle:@"用打赏券打赏" forState:UIControlStateNormal];
    [_ticketBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ticketBtn addTarget:self action:@selector(ticketButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_ticketBtn];
    [_ticketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 15));
        make.top.mas_equalTo(124);
        make.centerX.mas_equalTo(_bgView.mas_centerX);
    }];
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.backgroundColor = [UIColor clearColor];
    arrowImage.image = [UIImage imageNamed:@"白箭头"];
    [_bgView addSubview:arrowImage];
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 14));
        make.left.mas_equalTo(_ticketBtn.mas_right);
        make.top.mas_equalTo(_ticketBtn.mas_top).offset(1);
    }];
    
    _inputTextView = [[UITextView alloc] init];
    _inputTextView.backgroundColor = [UIColor clearColor];
    _inputTextView.delegate = self;
    _inputTextView.textColor = [UIColor whiteColor];
    _inputTextView.layer.borderWidth = 1;
    _inputTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    _inputTextView.layer.cornerRadius = 5;
    [_bgView addSubview:_inputTextView];
    [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(201, 101));
        make.centerX.mas_equalTo(_bgView.mas_centerX);
        make.top.mas_equalTo(204);
    }];
    
    int i = arc4random_uniform((int)_rewardTextArr.count-1);
    _defaultLabel = [self getLabelWithText:[_rewardTextArr dm_objectAtIndex:i] andTextColor:RGBA(255, 255, 255, 1) andFont:DMFont(12)];
    _defaultLabel.numberOfLines = 0;
    [_inputTextView addSubview:_defaultLabel];
    [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) { // 191 14
        make.right.lessThanOrEqualTo(_bgView.mas_right).offset(-46);
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(7);
    }];
    
    _rewardBtn = [[UIButton alloc] init];
    _rewardBtn.backgroundColor = RGBA(255, 180, 0, 1);
    _rewardBtn.layer.cornerRadius = 5;
    _rewardBtn.titleLabel.font = DMFont(12);
    [_rewardBtn setTitle:@"打赏" forState:UIControlStateNormal];
    [_rewardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rewardBtn addTarget:self action:@selector(rewardBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_rewardBtn];
    [_rewardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(201, 41));
        make.centerX.mas_equalTo(_bgView.mas_centerX);
        make.bottom.mas_equalTo(-36);
    }];
}


// 加载打赏券页面
- (void)loadRewardTicketView {
    if (!_ticketView) {
        _ticketView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgViewW, bgViewH)];
        _ticketView.backgroundColor = RGBA(255, 42, 80, 1);
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(45, 40, 210, 41)];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.titleLabel.font = DMFont(12);
        cancelBtn.layer.cornerRadius = 5;
        [cancelBtn setTitle:@"不使用打赏券" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:RGBA(255, 42, 80, 1) forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_ticketView addSubview:cancelBtn];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(45, cancelBtn.mj_y+cancelBtn.mj_h+10, 210, bgViewH-cancelBtn.mj_y-cancelBtn.mj_h-30)];
        scrollView.backgroundColor = [UIColor clearColor];
        [_ticketView addSubview:scrollView];
        
        //    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"6.6元打赏券", @"12.8元打赏券", @"20元打赏券", @"8.8元打赏券", @"8.8元打赏券", @"8.8元打赏券", nil];
        
        if (_ticketArray && _ticketArray.count > 0) {
            for (int i = 0; i < _ticketArray.count; i ++) {
                DMRewardTicketModel *model = [_ticketArray dm_objectAtIndex:i];
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 51*i, 210, 41)];
                button.tag = i;
                button.backgroundColor = [UIColor clearColor];
                button.layer.borderWidth = 1;
                button.layer.borderColor = [UIColor whiteColor].CGColor;
                button.layer.cornerRadius = 5;
                [button addTarget:self action:@selector(ticketSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:button];
                
                UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 95, 41)];
                title.backgroundColor = [UIColor clearColor];
                title.text = [NSString stringWithFormat:@"%@%@元", model.name, model.amount];
                title.textColor = [UIColor whiteColor];
                title.font = DMFont(12);
                [button addSubview:title];
                
                UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, 90, 40)];
                dateLab.backgroundColor = [UIColor clearColor];
                dateLab.text = model.endTime;
                dateLab.textColor = RGBA(255, 255, 255, 1);
                dateLab.font = DMFont(10);
                dateLab.textAlignment = NSTextAlignmentRight;
                [button addSubview:dateLab];
            }
            if (_ticketArray.count * 51 > scrollView.mj_h) {
                scrollView.contentSize = CGSizeMake(210, _ticketArray.count*51);
            } else {
                scrollView.contentSize = CGSizeMake(210, scrollView.mj_h);
            }
        }
    }
}


- (void)rewardBtnClick {
    
    if (isEmpty(_numTextField.text)) {
        UIAlertView *alertNum = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入打赏金额" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertNum show];
        return;
    }
    
    if ([_numTextField.text floatValue] <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入大于0的金额" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }

    
    [_rewardBtn setTitle:@"打赏中..." forState:UIControlStateNormal];
    _rewardBtn.userInteractionEnabled = NO;
    
    __weak __typeof(self) weakSelf = self;

    NSMutableDictionary *safeDic = [[NSMutableDictionary alloc] init];
    [safeDic dm_setObject:@"DMHY400047" forKey:@"iface"];
    [safeDic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
    [NetworkRequest post:serVerIP params:safeDic success:^(id responseObj) { // 查看用户是否设置了交易密码
        [_rewardBtn setTitle:@"打赏" forState:UIControlStateNormal];
        _rewardBtn.userInteractionEnabled = YES;

        SafetyMode *model = [SafetyMode mj_objectWithKeyValues:responseObj];
        if ([model.rescode isEqualToString:@"0000"]) {
            if ([model.payPwd isEqualToString:@"未设置"]) {
                
//                ForgetLoginController *forgetLogin = [[ForgetLoginController alloc] initWithNibName:@"ForgetLoginController" bundle:nil];
//                forgetLogin.type = @"30";
//                forgetLogin.phone = [BusinessLogic getPhoneNo];
//                [weakSelf presentViewController:forgetLogin animated:YES completion:nil];
                
                ForgetPayController *forgetVc = [[ForgetPayController alloc] init];
                forgetVc.type = @"30";
                forgetVc.mold = @"999";
                [weakSelf presentViewController:forgetVc animated:YES completion:nil];
                
            } else {
    
                [_rewardBtn setTitle:@"打赏中..." forState:UIControlStateNormal];
                _rewardBtn.userInteractionEnabled = NO;

                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic dm_setObject:@"DMHY400023" forKey:@"iface"];
                [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
                [NetworkRequest post:serVerIP params:dic success:^(id responseObj) { // 查询余额
                    [_rewardBtn setTitle:@"打赏" forState:UIControlStateNormal];
                    _rewardBtn.userInteractionEnabled = YES;

                    DMPayForGeneralModel *model = [DMPayForGeneralModel mj_objectWithKeyValues:responseObj];
                    if ([model.rescode isEqualToString:@"0000"]) {
                        [weakSelf.rewardBtn setTitle:@"打赏" forState:UIControlStateNormal];
                        weakSelf.rewardBtn.userInteractionEnabled = YES;
                        [weakSelf loadPayForViewWithBalance:model.usalbeAmount andVeId:_veId andTicketAmount:_ticketAmount]; // balance：余额 isTicket:是否是使用打赏券打赏  ticketAmount:打赏券金额
                    }
                    
                } failure:^(NSError *error) {
                    
                }];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)loadPayForViewWithBalance:(NSString *)balance andVeId:(NSString *)veId andTicketAmount:(NSString *)ticketAmount {
    
    if ([_fieldStr containsString:@"元"]) {
        _fieldStr = [_fieldStr substringToIndex:_fieldStr.length-1];
    }
    [_manager loadPayForViewWithBalance:balance andTitle:[NSString stringWithFormat:@"打赏%@元", _fieldStr] andRewardMoney:_fieldStr andVeId:veId andAnchorId:_anchorId andDynId:_dynId andChannel:_channel andRewardText:isEmpty(_inputTextView.text)?_defaultLabel.text : _inputTextView.text andTicketAmount:_ticketAmount];
    
}


- (void)ticketButtonClick {
    __weak __typeof(self) weakSelf = self;

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY400049" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
    [dic dm_setObject:@"3" forKey:@"type"];
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        DMRewardTicketListModel *model = [DMRewardTicketListModel mj_objectWithKeyValues:responseObj];
        if ([model.rescode isEqualToString:@"0000"]) {
            
            [weakSelf.ticketArray removeAllObjects];
            [weakSelf.ticketArray addObjectsFromArray:model.voucherExchangeList];
            [weakSelf loadRewardTicketView]; // 加载打赏券页面
            
            // 页面翻转动画
            UIView *fromView;
            [UIView transitionWithView:_bgView duration:0.6 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                [fromView removeFromSuperview];
                [_bgView addSubview:_ticketView];
            } completion:^(BOOL finished) {
                
            }];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)ticketSelectButtonClick:(UIButton *)button {
    
    DMRewardTicketModel *model = [_ticketArray dm_objectAtIndex:button.tag];
    
    UIView *toView;
    [UIView transitionWithView:_bgView duration:0.6 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [_ticketView removeFromSuperview];
        [_bgView addSubview:toView];
    } completion:^(BOOL finished) {
        _ticketView = nil;
        [_ticketBtn setTitle:[NSString stringWithFormat:@"%@%@元", model.name, model.amount] forState:UIControlStateNormal];
        _veId = model.mvId;
        _ticketAmount = model.amount;
        _ticketText.hidden = NO;
    }];
}


- (void)cancelButtonClick {
    UIView *toView;
    [UIView transitionWithView:_bgView duration:0.6 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [_ticketView removeFromSuperview];
        [_bgView addSubview:toView];
    } completion:^(BOOL finished) {
        _ticketView = nil;
        [_ticketBtn setTitle:@"用打赏券打赏" forState:UIControlStateNormal];
        _ticketText.hidden = YES;
        _veId = @"";
        _ticketAmount = @"0";
    }];
}


- (void)closeBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 30) {
        textField.text = [textField.text substringToIndex:30];
    }
   
//    if (textField.text.length > 0) {
        _fieldStr = textField.text;
//    }
}


- (UILabel *)getLabelWithText:(NSString *)text andTextColor:(UIColor *)textColor andFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}


#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    [_defaultLabel setHidden:_inputTextView.text.length > 0 ? YES: NO];
 
    if (textView.text.length > 200) {
        textView.text = [textView.text substringToIndex:200];
    }
}


#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) {
        return YES;
    }
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //正则表达式
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    return [self isValid:checkStr withRegex:regex];
}


- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == ) {
//        <#statements#>
//    }
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
