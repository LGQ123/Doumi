//
//  ForgetPayController.m
//  douMiApp
//
//  Created by ydz on 2016/12/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "ForgetPayController.h"
#import "PasswordEnterView.h"
#import "PasswordTextField.h"


@interface ForgetPayController ()
@property (nonatomic,strong)PasswordTextField *textFieldOne;
@property (nonatomic,strong)PasswordTextField *textFieldTwo;
@property (nonatomic, strong)UILabel *mylable;
@property (nonatomic, strong)UILabel *tishilable;
@end

@implementation ForgetPayController

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
    
    if ([self.type isEqualToString:@"30"]) {  // 从支付输入密码页面进入，重置密码 ///////////
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-80, 30, 160, 20)];
        title.backgroundColor = [UIColor clearColor];
        title.font = DMFont(17);
        title.text = @"重置交易密码";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = RGBA(40, 40, 40, 1);
        [self.view addSubview:title];
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 20, 20)];
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
        [self.view addSubview:backBtn];
        
        // 全局关闭键盘
        UIButton *bgButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        bgButton.backgroundColor = [UIColor clearColor];
        [bgButton addTarget:self action:@selector(bgButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bgButton];
        
        if ([self.mold isEqualToString:@"999"]) { // 从打赏页面进入，设置支付密码
            title.text = @"设置交易密码";
        }
    } else {
        if ([self.mold isEqualToString:@"999"]) {
           self.lable.text = @"设置交易密码";
        } else {

            self.lable.text = @"重置交易密码";
        }
    }
    
    
    [self initEnterViewOne];
    [self initEnterViewTwo];
    NSArray *arr = @[@"新密码",@"再次输入"];
    
    for (int i = 0; i<2; i++) {
        _mylable = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-290)/2, 104+i*106, 200, 16)];
        _mylable.text = arr[i];
        _mylable.font = [UIFont systemFontOfSize:16];
        _mylable.textColor = RGBA(40, 40, 40, 1);
        _mylable.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:_mylable];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(42, 315, SCREEN_WIDTH-84, 40);
    [btn setBackgroundColor:RGBA(60, 60, 60, 1)];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _tishilable = [[UILabel alloc] initWithFrame:CGRectMake(42, 365, 200, 11)];
    _tishilable.textColor = RGBA(255, 42, 80, 1);
    _tishilable.textAlignment = NSTextAlignmentLeft;
    _tishilable.font = [UIFont systemFontOfSize:10];
    _tishilable.hidden = YES;
    [self.view addSubview:_tishilable];
    
}

- (void)bgButtonClick {
    [self.view endEditing:YES];
}

- (void)backButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnClick:(UIButton *)sender {
    if (_textFieldOne.text.length != 6) {
        _tishilable.hidden = NO;
        _tishilable.text = @"新密码格式不正确";
    } else {
        if ([_textFieldOne.text isEqualToString:_textFieldTwo.text]) {
            _tishilable.hidden = YES;
            [self request_Api];
            
        }else {
            _tishilable.hidden = NO;
            _tishilable.text = @"两次密码不一致";
        }
    
    }
    

}

- (void)request_Api {
    __weak __typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400013",@"userId":[BusinessLogic uuid],@"tradePwd":_textFieldOne.text};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            _tishilable.hidden = YES;
            if ([weakSelf.type isEqualToString:@"30"]) { ///////////
                if ([weakSelf.mold isEqualToString:@"999"]) { // 从打赏页面进入，设置支付密码
                    [weakSelf.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                } else { // 从支付输入密码页面进入，重置密码
                    [weakSelf.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                    [[NSNotificationCenter  defaultCenter]postNotificationName:@"backback" object:nil];
                }
            } else {
                if ([weakSelf.mold isEqualToString:@"999"]) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    [weakSelf.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
                }

            }
        } else {
            _tishilable.hidden = NO;
            _tishilable.text = responseObj[@"resmsg"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

}


- (void)initEnterViewOne{
    PasswordEnterView *_enterView2 = [[PasswordEnterView alloc]initWithFrame:CGRectMake(0, 130, self.view.frame.size.width,40) count:6 isCiphertext:YES type:@"" textField:^(PasswordTextField *textField) {
        //        [textField becomeFirstResponder];
        _textFieldOne = textField;
    }];
    
    _enterView2.textDetail = ^(NSString *textDetail){
        NSLog(@"%@",_textFieldOne.text);
        
        
    };
    _enterView2.backgroundColor = RGBA(247, 247, 247, 1);
    [self.view addSubview:_enterView2];
}
- (void)initEnterViewTwo{
    PasswordEnterView *_enterView2 = [[PasswordEnterView alloc]initWithFrame:CGRectMake(0, 235, self.view.frame.size.width,40) count:6 isCiphertext:YES type:@"" textField:^(PasswordTextField *textField) {
        //        [textField becomeFirstResponder];
        _textFieldTwo = textField;
    }];
    
    _enterView2.textDetail = ^(NSString *textDetail){
        NSLog(@"%@",_textFieldTwo.text);
        
        
    };
    _enterView2.backgroundColor = RGBA(247, 247, 247, 1);
    [self.view addSubview:_enterView2];
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
