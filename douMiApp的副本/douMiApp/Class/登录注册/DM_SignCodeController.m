//
//  DM_SignCodeController.m
//  douMiApp
//
//  Created by ydz on 2016/11/7.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_SignCodeController.h"
#import "DM_PerfectController.h"
#import "CountDown.h"
#import "RWebViewConreoller.h"
#import "UMMobClick/MobClick.h"
@interface DM_SignCodeController ()
@property (weak, nonatomic) IBOutlet MBTextFieldWithFontAdapter *codeText;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (assign, nonatomic) BOOL isChoose;
@property (strong, nonatomic)  CountDown *countDownForBtn;
@property (weak, nonatomic) IBOutlet UILabel *tishi;
@property (assign, nonatomic) NSTimeInterval aMinutes;
@end

@implementation DM_SignCodeController

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
    [MobClick endEvent:@"registerCode"];
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"注册";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    [self countDown];
    [_codeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.codeText) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
    
}


- (IBAction)codeTouch:(UIButton *)sender {//验证码
    [self request_CodeApi];
}
- (IBAction)chooseTouch:(UIButton *)sender {//选择
    _isChoose = !_isChoose;
    sender.selected = _isChoose;
    
}
- (IBAction)protocolTouch:(UIButton *)sender {//协议
    RWebViewConreoller *protocolVC = [[RWebViewConreoller alloc] initWithNibName:@"RWebViewConreoller" bundle:nil];
    protocolVC.titleStr = @"协议";
    protocolVC.urlStr = @"http://m.doume.tv/f/regAgreement";
    [self.navigationController pushViewController:protocolVC animated:YES];
    
}

- (IBAction)signTouch:(UIButton *)sender {
    if (_codeText.text.length !=6) {
        _tishi.hidden = NO;
        _tishi.text = @"验证码不正确";
    }
    
    else {
        if (_chooseBtn.selected) {
            
            _tishi.hidden = NO;
            _tishi.text = @"请同意协议";
        } else {
            _tishi.hidden = YES;
            [self request_Api];
            
        }
        
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


- (void)request_CodeApi {
    NSDictionary *dic = @{@"iface":@"DMHY100006",@"mobile":_phone,@"type":@"1"};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            [self countDown];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)request_Api {
    NSDictionary *dic = @{@"iface":@"DMHY100002",@"mobile":_phone,@"password":_paw,@"captcha":_codeText.text,@"source":@"ios"};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        NSLog(@"responseObj == %@",responseObj);
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            
            [BusinessLogic setUUID:responseObj[@"userId"]];
            [MobClick profileSignInWithPUID:_phone];
            [BusinessLogic setPhoneNo:_phone];
            [BusinessLogic setToken:responseObj[@"token"]];
            DM_PerfectController *dm_pc = [[DM_PerfectController alloc]
                                           initWithNibName:@"DM_PerfectController" bundle:nil];
            dm_pc.type = self.type;
            
            if ([BusinessLogic deviceToken].length == 0) {
                
            } else {
                
                [NetworkRequest post1:serVerIP params:@{@"iface":@"DMHY100015",@"source":@"1",@"deviceSoleMark":[BusinessLogic deviceToken],@"userId":responseObj[@"userId"]} success:^(id responseObj) {
                    NSLog(@"lll22222=======%@",responseObj);
                } failure:^(NSError *error) {
                    
                }];
            }
            
            
            [self.navigationController pushViewController:dm_pc animated:YES];
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
