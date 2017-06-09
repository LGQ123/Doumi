//
//  ForgetLogin2Controller.m
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "ForgetLogin2Controller.h"

@interface ForgetLogin2Controller ()
@property (weak, nonatomic) IBOutlet UITextField *loginText;
@property (weak, nonatomic) IBOutlet UITextField *loginText1;
@property (weak, nonatomic) IBOutlet UILabel *tishi;

@end

@implementation ForgetLogin2Controller

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
    self.lable.text = @"重置登录密码";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    [_loginText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_loginText1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField.text.length > 12) {
        textField.text = [textField.text substringToIndex:12];
    }
    
    
}


- (IBAction)finshTouch:(UIButton *)sender {
    if (_loginText.text.length == 0) {
        _tishi.hidden = NO;
        _tishi.text = @"密码不能为空";
    } else {
        if ([_loginText.text isEqualToString:_loginText1.text]) {
            _tishi.hidden = YES;
            [self request_Api];
            
        } else {
            _tishi.hidden = NO;
            _tishi.text = @"两次密码不一致";
        }
    }
    
}

- (void)request_Api {
    NSDictionary *dic = @{@"iface":@"DMHY100005",@"mobile":[BusinessLogic getPhoneNo],@"password":_loginText.text};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            _tishi.hidden = YES;
            [BusinessLogic setUUID:@""];
            [BusinessLogic setPhoneNo:@""];
            [self.navigationController popToRootViewControllerAnimated:YES];
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
