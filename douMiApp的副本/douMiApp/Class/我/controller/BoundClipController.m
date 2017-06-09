//
//  BoundClipController.m
//  douMiApp
//
//  Created by ydz on 2016/12/26.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "BoundClipController.h"
#import "BackInforMode.h"
#import "BoundClip2ViewController.h"
@interface BoundClipController ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *btn;
@property (copy, nonatomic) NSString *cardNumber;
@property (strong, nonatomic) UILabel *tishiLable;
@property (strong, nonatomic) BackInforMode *mode;
@end

@implementation BoundClipController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"绑定银行卡";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    
    self.tishiLable.hidden = YES;
    [self.view addSubview:self.textField];
    [self.view addSubview:self.btn];
}

- (void)request_Api {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400020",@"userId":[BusinessLogic uuid],@"bankCard":_cardNumber};
    
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            self.tishiLable.hidden = YES;
            _mode = [BackInforMode mj_objectWithKeyValues:responseObj];
            BoundClip2ViewController *boundClip2 = [[BoundClip2ViewController alloc] initWithNibName:@"BoundClip2ViewController" bundle:nil];
            boundClip2.mode = _mode;
            boundClip2.type = self.type;
            [self.navigationController pushViewController:boundClip2 animated:YES];
        } else {
            self.tishiLable.hidden = NO;
            self.tishiLable.text = responseObj[@"resmsg"];
        }
    } failure:^(NSError *error) {
        self.tishiLable.hidden = YES;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)btnClick:(UIButton *)sender {
    if (_cardNumber.length == 0) {
        self.tishiLable.hidden = NO;
        self.tishiLable.text = @"银行卡号不能为空";
    } else {
        self.tishiLable.hidden = YES;
        [self request_Api];
        
    }
    
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(42, 104, SCREEN_WIDTH-84, 40)];
        _textField.placeholder = @" 请输入您的银行卡号";
        _textField.textColor = RGBA(141, 141, 141, 1);
        _textField.font = [UIFont systemFontOfSize:12];
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
        _textField.keyboardType = UIKeyboardTypePhonePad;
        _textField.delegate = self;
        
    }
    return _textField;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(42, 164, SCREEN_WIDTH-84, 40);
        [_btn setBackgroundColor:RGBA(60, 60, 60, 1)];
        _btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btn setTitle:@"下一步" forState:UIControlStateNormal];
        
    }
    return _btn;
}

- (UILabel *)tishiLable {
    if (!_tishiLable) {
        _tishiLable = [[UILabel alloc] initWithFrame:CGRectMake(42, 214, SCREEN_WIDTH-84, 11)];
        _tishiLable.textAlignment = NSTextAlignmentLeft;
        _tishiLable.textColor = RGBA(255, 42, 80, 1);
        _tishiLable.font = [UIFont systemFontOfSize:10];
        [self.view addSubview:_tishiLable];
    }
    return _tishiLable;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 35) {
        return NO;
    }
    NSLog(@"==== %@",newString);
    [textField setText:newString];
    _cardNumber = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return NO;
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
