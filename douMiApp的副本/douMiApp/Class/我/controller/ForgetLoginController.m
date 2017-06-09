//
//  ForgetLoginController.m
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "ForgetLoginController.h"
#import "ForgetLogin2Controller.h"
#import "ForgetPayController.h"
@interface ForgetLoginController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UILabel *tishi;

@end

@implementation ForgetLoginController

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
    
    self.lable.textColor = RGBA(40, 40, 40, 1);
    self.lable.text = [_type isEqualToString:@"3"]?@"重置交易密码":@"重置登录密码";
    if ([_type isEqualToString:@"30"]) {
        self.lable.text = @"重置交易密码"; ////////
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 20, 20)];
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
        [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
    }
    
    _phoneLable.text = self.phone;
    
    [self codeTouch:_codeBtn];
    
    [_codeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

// 全局关闭键盘
- (IBAction)bgButtonClick:(id)sender {
    [self.view endEditing:YES];
}

- (void)backButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter  defaultCenter]postNotificationName:@"backback" object:nil]; 
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
    
    
}


- (void)request_Api {
    NSDictionary *dic = @{@"iface":@"DMHY100006",@"mobile":[BusinessLogic getPhoneNo],@"type":@"4"};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        [self countDown];
    } failure:^(NSError *error) {
        
    }];
    

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

- (IBAction)codeTouch:(UIButton *)sender {
    [self request_Api];
    
}
- (IBAction)buzaishengbian:(UIButton *)sender {
    
}

- (IBAction)xiaYiBuTouch:(UIButton *)sender {
    
    if (_codeText.text.length != 6) {
         _tishi.hidden = NO;
        _tishi.text = @"验证码不正确";
    } else {
        NSDictionary *dic = @{@"iface":@"DMHY100007",@"mobile":[BusinessLogic getPhoneNo],@"captcha":_codeText.text};
        [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
            
            if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
                _tishi.hidden = YES;
                if ([_type isEqualToString:@"3"]) {
                    ForgetPayController *forgetVC = [[ForgetPayController alloc] init];
                    [self.navigationController pushViewController:forgetVC animated:YES];
                } else if ([_type isEqualToString:@"30"]) { //////////////////
                    ForgetPayController *controller = [[ForgetPayController alloc] init];
                    controller.type = @"30";
                    [self presentViewController:controller animated:YES completion:nil];
                } else {
                    ForgetLogin2Controller *forgetVC = [[ForgetLogin2Controller alloc] initWithNibName:@"ForgetLogin2Controller" bundle:nil];
                    [self.navigationController pushViewController:forgetVC animated:YES];
                }
                
            }
            
            
            
        } failure:^(NSError *error) {
            
        }];
    
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
