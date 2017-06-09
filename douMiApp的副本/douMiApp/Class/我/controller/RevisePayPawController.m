//
//  RevisePayPawController.m
//  douMiApp
//
//  Created by ydz on 2016/12/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "RevisePayPawController.h"
#import "PasswordEnterView.h"
#import "PasswordTextField.h"
@interface RevisePayPawController ()

@property (nonatomic,strong)PasswordTextField *textFieldOne;
@property (nonatomic,strong)PasswordTextField *textFieldTwo;
@property (nonatomic,strong)PasswordTextField *textFieldThree;
@property (nonatomic, strong)UILabel *mylable;
@property (nonatomic, strong)UILabel *tishilable;

@end

@implementation RevisePayPawController

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
    self.lable.text = @"修改支付密码";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    self.view.backgroundColor = RGBA(247, 247, 247, 1);
    
    [self initEnterViewOne];
    [self initEnterViewTwo];
    [self initEnterViewThree];
    NSArray *arr = @[@"原密码",@"新密码",@"再次输入"];
    
    for (int i = 0; i<3; i++) {
        _mylable = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-290)/2, 104+i*106, 200, 16)];
        _mylable.text = arr[i];
        _mylable.font = [UIFont systemFontOfSize:16];
        _mylable.textColor = RGBA(40, 40, 40, 1);
        _mylable.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:_mylable];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(42, 420, SCREEN_WIDTH-84, 40);
    [btn setBackgroundColor:RGBA(60, 60, 60, 1)];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _tishilable = [[UILabel alloc] initWithFrame:CGRectMake(42, 470, 200, 11)];
    _tishilable.textColor = RGBA(255, 42, 80, 1);
    _tishilable.textAlignment = NSTextAlignmentLeft;
    _tishilable.font = [UIFont systemFontOfSize:10];
    _tishilable.hidden = YES;
    [self.view addSubview:_tishilable];
    
    
}

- (void)btnClick:(UIButton *)sender {
    if (_textFieldOne.text.length != 6) {
        _tishilable.hidden = NO;
        _tishilable.text = @"原密码格式不正确";
    }else {
        if (_textFieldTwo.text.length != 6) {
            _tishilable.hidden = NO;
            _tishilable.text = @"新密码格式不正确";
        } else {
            if ([_textFieldTwo.text isEqualToString:_textFieldThree.text]) {
                _tishilable.hidden = YES;
                
                [self request_Api];
            } else {
                _tishilable.hidden = NO;
                _tishilable.text = @"两次密码不一致";
            
            }
        
        
        }
    
    
    }
    
}

- (void)request_Api {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400027",@"userId":[BusinessLogic uuid],@"oldPwd":_textFieldOne.text,@"tradePwd":_textFieldTwo.text};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            _tishilable.hidden = YES;
            [self.navigationController popViewControllerAnimated:YES];
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
- (void)initEnterViewThree{
    PasswordEnterView *_enterView2 = [[PasswordEnterView alloc]initWithFrame:CGRectMake(0, 340, self.view.frame.size.width,40) count:6 isCiphertext:YES type:@"" textField:^(PasswordTextField *textField) {
//        [textField becomeFirstResponder];
        _textFieldThree = textField;
    }];
    
    _enterView2.textDetail = ^(NSString *textDetail){
        NSLog(@"%@",_textFieldThree.text);
        
        
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
