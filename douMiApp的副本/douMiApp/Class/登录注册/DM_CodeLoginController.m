//
//  DM_CodeLoginController.m
//  douMiApp
//
//  Created by ydz on 2016/11/4.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_CodeLoginController.h"
#import "DM_SignController.h"
#import "UMMobClick/MobClick.h"
@interface DM_CodeLoginController ()
@property (weak, nonatomic) IBOutlet MBTextFieldWithFontAdapter *phoneLable;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet MBTextFieldWithFontAdapter *codeLable;
@property (weak, nonatomic) IBOutlet UILabel *tishi;

@end

@implementation DM_CodeLoginController

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
    self.lable.text = @"登录";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    [_phoneLable addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_codeLable addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneLable) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
    if (textField == self.codeLable) {
        if (textField.text.length >6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}

- (IBAction)codeTouch:(UIButton *)sender {
    if ([BusinessLogic isValidateMobile:_phoneLable.text]) {
        _tishi.hidden = YES;
        [self request_CodeApi];
    } else {
        
        _tishi.hidden = NO;
        _tishi.text = @"请输入正确的手机号";
    }
}

- (void)countDown {
    _codeBtn.enabled = NO;
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_codeBtn setTitle:@"验证" forState:UIControlStateNormal];
                //                _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                _codeBtn.enabled = YES;
                
                
            });
        } else {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_codeBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //                sender.titleLabel.font = [UIFont systemFontOfSize:12];
                _codeBtn.enabled = NO;
            });
            
            timeout--;
        }
    });
    dispatch_resume(timer);
    
    
}

- (IBAction)sign:(UIButton *)sender {//注册豆蜜
    
    DM_SignController *sign = [[DM_SignController alloc] initWithNibName:@"DM_SignController" bundle:nil];
    sign.type = self.type;
    [self.navigationController pushViewController:sign animated:YES];
    
}
- (IBAction)password:(UIButton *)sender {//密码登录
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)loginTouch:(UIButton *)sender {//登录
    if ([BusinessLogic isValidateMobile:_phoneLable.text]) {
        if (_codeLable.text.length!=6) {
            _tishi.hidden = NO;
            _tishi.text = @"验证码不正确";
        } else {
             _tishi.hidden = YES;
            [self request_Api];
        }
        
    } else {
    
        _tishi.hidden = NO;
        _tishi.text = @"请输入正确的手机号";
    }
    
}

- (void)request_Api {
    NSDictionary *dic = @{@"iface":@"DMHY100007",@"mobile":_phoneLable.text,@"captcha":_codeLable.text};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            
            if ([_phoneLable.text isEqualToString:@"18611648317"]) {
                [BusinessLogic setIsAllow:@"N"];
            }
            
            _tishi.hidden = YES;
            [BusinessLogic setUUID:responseObj[@"userId"]];
            [BusinessLogic setPhoneNo:_phoneLable.text];
            [MobClick profileSignInWithPUID:_phoneLable.text];
            [BusinessLogic setToken:responseObj[@"token"]];
            
            if ([BusinessLogic deviceToken].length == 0) {
                
            } else {
                
                [NetworkRequest post1:serVerIP params:@{@"iface":@"DMHY100015",@"source":@"1",@"deviceSoleMark":[BusinessLogic deviceToken],@"userId":responseObj[@"userId"]} success:^(id responseObj) {
                    NSLog(@"lll22222=======%@",responseObj);
                } failure:^(NSError *error) {
                    
                }];
            }
            
            
            if ([_type isEqualToString:@"push"]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                 [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }else {
            _tishi.hidden = NO;
            _tishi.text = responseObj[@"resmsg"];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)request_CodeApi {
    NSDictionary *dic = @{@"iface":@"DMHY100006",@"mobile":_phoneLable.text,@"type":@"2"};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            [self countDown];
            _tishi.hidden = YES;
        } else {
            _tishi.hidden = NO;
            _tishi.text = responseObj[@"resmsg"];
        }
        
    } failure:^(NSError *error) {
        
    }];
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
