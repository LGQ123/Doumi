//
//  WriteInforController.m
//  douMiApp
//
//  Created by ydz on 2016/12/6.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "WriteInforController.h"
#import <IQKeyboardManager.h>
@interface WriteInforController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UILabel *plLable;
@property (strong, nonatomic) UIButton *isPublicBtn;
@property (strong, nonatomic) UIButton *jzjBtn;
@property (strong, nonatomic) UIButton *gkBtn;

@property (strong , nonatomic) UIImageView *jiantouIV;

@property (weak, nonatomic) UIButton *oldBtn;

@property (assign, nonatomic) BOOL isOpen;

@property (assign, nonatomic) CGSize kbSize;
@property (assign, nonatomic) double kbTime;

@property (strong, nonatomic) UIView *keyBordView;

@property (copy, nonatomic) NSString *key;

@property (copy, nonatomic) NSString *keyStatus;

@end

@implementation WriteInforController

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    _kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",_kbSize.height);
    [self createKeyBordView:_kbSize];
    
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.3 animations:^{
        _keyBordView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 50);
        _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
        _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
        _isPublicBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
    } completion:^(BOOL finished) {
        
    }];
    
    
}


- (void)createKeyBordView:(CGSize )kbSize {
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _keyBordView.frame = CGRectMake(0, SCREEN_HEIGHT-kbSize.height-50, SCREEN_WIDTH, 50);
        _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-kbSize.height-13-25, 50, 25);
        _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-kbSize.height-13-25, 50, 25);
        _isPublicBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-kbSize.height-13-25, 50, 25);
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self registerForKeyboardNotifications];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_myTextView becomeFirstResponder];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 40, 20);
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:RGBA(139, 139, 139, 1) forState:UIControlStateNormal];
    [btn setBackgroundColor:RGBA(247, 247, 247, 1)];
    btn.layer.borderColor = [RGBA(160, 160, 160, 1) CGColor];
    btn.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(showRightView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    [self addItem:nitem_left btnTitleArr:@[@"close3"]];
    self.lable.text = self.titleStr;
    self.lable.textColor = RGBA(40, 40, 40, 1);
    if ([self.titleStr isEqualToString:@"胸围"] || [self.titleStr isEqualToString:@"腰围"] || [self.titleStr isEqualToString:@"臀围"]) {
        self.plLable.text = [NSString stringWithFormat:@"请填写%@(CM)",self.titleStr];
        self.myTextView.keyboardType = UIKeyboardTypeNumberPad;
    } else if ([self.titleStr isEqualToString:@"主播关键字"] || [self.titleStr isEqualToString:@"兴趣爱好"]) {
        self.plLable.text = [NSString stringWithFormat:@"请填写%@(以,隔开)",self.titleStr];
        self.myTextView.keyboardType = UIKeyboardTypeDefault;
    } else {
        self.plLable.text = [NSString stringWithFormat:@"请填写%@",self.titleStr];
        self.myTextView.keyboardType = UIKeyboardTypeDefault;
    }
    self.lable.textColor = RGBA(145, 145, 145, 1);
    [self createKeyBordView];
    
    if ([self.titleStr isEqualToString:@"主播艺名"]) {
        _key = @"stageName";
    }
    if ([self.titleStr isEqualToString:@"主播平台"]) {
        _key = @"stageName";
    }
    if ([self.titleStr isEqualToString:@"YY号"]) {
        _key = @"yyAcount";
    }
    if ([self.titleStr isEqualToString:@"工会频道"]) {
        _key = @"channel";
    }
    if ([self.titleStr isEqualToString:@"直播间号"]) {
        _key = @"roomNum";
    }
    if ([self.titleStr isEqualToString:@"胸围"]) {
        _key = @"bust";
    }
    if ([self.titleStr isEqualToString:@"腰围"]) {
        _key = @"waist";
    }
    if ([self.titleStr isEqualToString:@"臀围"]) {
        _key = @"hips";
    }
    if ([self.titleStr isEqualToString:@"微信号"]) {
        _key = @"weixinNum";
    }
    if ([self.titleStr isEqualToString:@"微博昵称"]) {
        _key = @"weiboName";
    }
    if ([self.titleStr isEqualToString:@"兴趣爱好"]) {
        _key = @"hobby";
    }
    if ([self.titleStr isEqualToString:@"主播关键字"]) {
        _key = @"radioType";
    }
    
    if ([self.titleStr isEqualToString:@"我的梦想"]) {
        _key = @"dream";
    }
    if ([self.titleStr isEqualToString:@"我的简介"]) {
        _key = @"introduction";
    }
    
    if ([self.titleStr isEqualToString:@"昵称"]) {
        _key = @"uname";
    }
    if ([self.titleStr isEqualToString:@"个性签名"]) {
        _key = @"individualitySignature";
    }
    
    _keyStatus = [NSString stringWithFormat:@"%@Status",_key];
    
}


//请求网络
- (void)request_Api {
    NSDictionary *dic;
    if (self.isGongKai) {
        dic = @{@"iface":@"DMHY400005",@"userId":[BusinessLogic uuid],_key:_myTextView.text};
        
    } else {
        dic = @{@"iface":@"DMHY400005",@"userId":[BusinessLogic uuid],_key:_myTextView.text,_keyStatus:[_isPublicBtn.titleLabel.text isEqualToString:@"公开"]?@"0":@"1"};
    }
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        [self.navigationController popViewControllerAnimated:YES];
        if ([self.delegate respondsToSelector:@selector(writeStr: title:)]) {
            [self.delegate writeStr:_myTextView.text title:self.titleStr];
        }
        
    } failure:^(NSError *error) {
        
    }];
    

}

//创建keyBordView

- (void)createKeyBordView {
    
    _keyBordView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 50)];
    _keyBordView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_keyBordView];
    
    
    _jzjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
    [_jzjBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_jzjBtn setTitleColor:RGBA(39, 39, 39, 1) forState:UIControlStateNormal];
    [_jzjBtn setTitle:@"仅自己" forState:UIControlStateNormal];
    _jzjBtn.titleLabel.font= [UIFont systemFontOfSize:10];
    [_jzjBtn setBackgroundColor:[UIColor whiteColor]];
    _jzjBtn.layer.cornerRadius = 13;
    _jzjBtn.layer.masksToBounds = YES;
    _jzjBtn.layer.borderWidth = 0.5;
    [_jzjBtn addTarget:self action:@selector(BtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self BtnTouch:_jzjBtn];
    [self.view addSubview:_jzjBtn];
    
    _gkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
    [_gkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_gkBtn setTitleColor:RGBA(39, 39, 39, 1) forState:UIControlStateNormal];
    [_gkBtn setTitle:@"公开" forState:UIControlStateNormal];
    _gkBtn.titleLabel.font= [UIFont systemFontOfSize:10];
    [_gkBtn setBackgroundColor:[UIColor whiteColor]];
    _gkBtn.layer.cornerRadius = 13;
    _gkBtn.layer.masksToBounds = YES;
    _gkBtn.layer.borderWidth = 0.5;
    [_gkBtn addTarget:self action:@selector(BtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_gkBtn];
    
    _isPublicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _isPublicBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
    [_isPublicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_isPublicBtn setTitle:@"仅自己" forState:UIControlStateNormal];
    _isPublicBtn.titleLabel.font= [UIFont systemFontOfSize:10];
    [_isPublicBtn setBackgroundColor:RGBA(60, 60, 60, 1)];
    _isPublicBtn.layer.cornerRadius = 13;
    _isPublicBtn.layer.masksToBounds = YES;
    _isPublicBtn.layer.borderWidth = 0.5;
    [_isPublicBtn addTarget:self action:@selector(isPublicBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_isPublicBtn];
    
    
    
    _jiantouIV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-42, 4, 6, 5)];
    _jiantouIV.image = [UIImage imageNamed:@"top"];
    [_keyBordView addSubview:_jiantouIV];
    
    _jzjBtn.hidden = _isGongKai;
    _gkBtn.hidden = _isGongKai;
    _isPublicBtn.hidden = _isGongKai;
    _jiantouIV.hidden = _isGongKai;
    
}

- (void)BtnTouch:(UIButton *)sender {
    _isOpen = !_isOpen;
    _oldBtn.selected = NO;
    [_oldBtn setBackgroundColor:[UIColor whiteColor]];
    sender.selected = YES;
    [sender setBackgroundColor:RGBA(60, 60, 60, 1)];
    _oldBtn = sender;
    [_isPublicBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25, 50, 25);
        _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25, 50, 25);
        _jiantouIV.image = [UIImage imageNamed:@"top"];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)isPublicBtnTouch:(UIButton *)sender {
    _isOpen = !_isOpen;
    if (_isOpen) {
        [UIView animateWithDuration:0.5 animations:^{
            _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25-39, 50, 25);
            _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25-74, 50, 25);
            _jiantouIV.image = [UIImage imageNamed:@"bottom"];
        } completion:^(BOOL finished) {
            
        }];
    } else {
        
        [_isPublicBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25, 50, 25);
            _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25, 50, 25);
            _jiantouIV.image = [UIImage imageNamed:@"top"];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    
}

- (void)showRightView:(UIButton *)btn {
    
    if (_myTextView.text.length == 0 ) {
        [LCProgressHUD showMessage:@"填写信息不能为空"];
    } else {
        [self request_Api];
    }
    
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{    if (![text isEqualToString:@""])
    
{
    
    _plLable.hidden = YES;
    
}
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        
        _plLable.hidden = NO;
        
    }
    
    return YES;
    
}


- (void)textViewDidChange:(UITextView *)textView {
    
    
    if ([self.titleStr isEqualToString:@"胸围"] || [self.titleStr isEqualToString:@"腰围"] || [self.titleStr isEqualToString:@"臀围"]) {
        if (textView.text.length > 3) {
            textView.text = [textView.text substringToIndex:3];
        }
    } else if ([self.titleStr isEqualToString:@"主播关键字"] || [self.titleStr isEqualToString:@"兴趣爱好"] || [self.titleStr isEqualToString:@"我的梦想"] || [self.titleStr isEqualToString:@"我的简介"] || [self.titleStr isEqualToString:@"个性签名"] ) {
        if (textView.text.length > 160) {
            textView.text = [textView.text substringToIndex:160];
        }
        
    } else {
        if (textView.text.length > 20) {
            textView.text = [textView.text substringToIndex:20];
        }
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
