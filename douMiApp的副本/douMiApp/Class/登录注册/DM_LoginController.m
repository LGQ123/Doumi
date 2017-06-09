//
//  DM_LoginController.m
//  douMiApp
//
//  Created by ydz on 2016/11/4.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_LoginController.h"
#import "DM_CodeLoginController.h"
#import "DM_SignController.h"
#import "UMMobClick/MobClick.h"
#import "ZYKMD5.h"
@interface DM_LoginController ()
@property (weak, nonatomic) IBOutlet MBTextFieldWithFontAdapter *phoneLable;
@property (weak, nonatomic) IBOutlet MBTextFieldWithFontAdapter *pawLable;
@property (weak, nonatomic) IBOutlet UILabel *tishi;

@end

@implementation DM_LoginController

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
    [_pawLable addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneLable) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
    if (textField == self.pawLable) {
        if (textField.text.length >12) {
            textField.text = [textField.text substringToIndex:12];
        }
    }
}

- (IBAction)codeLogin:(UIButton *)sender {
    DM_CodeLoginController *dm_cLogin = [[DM_CodeLoginController alloc] initWithNibName:@"DM_CodeLoginController" bundle:nil];
    dm_cLogin.type = self.type;
    [self.navigationController pushViewController:dm_cLogin animated:YES];
    
}
- (IBAction)sign:(UIButton *)sender {
    DM_SignController *dm_sign = [[DM_SignController alloc] initWithNibName:@"DM_SignController" bundle:nil];
    dm_sign.type = self.type;
    [self.navigationController pushViewController:dm_sign animated:YES];
}
- (IBAction)loginTouch:(UIButton *)sender {
    if ([BusinessLogic isValidateMobile:_phoneLable.text]) {
        if ([BusinessLogic isValidatePassword:_pawLable.text]) {
            _tishi.hidden = YES;
            [self request_PhoneApi];
        } else {
            _tishi.hidden = NO;
            _tishi.text = @"密码错误，请重新输入";
        }
        
    } else {
        _tishi.hidden = NO;
        _tishi.text = @"请输入正确的手机号";
    }
    
}


- (void)request_PhoneApi {
    NSDictionary *dic = @{@"iface":@"DMHY100001",@"mobile":_phoneLable.text};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        NSString *isRegFlag = responseObj[@"isRegFlag"];
        if ([isRegFlag isEqualToString:@"0"]) {
            _tishi.hidden = NO;
            _tishi.text = @"该手机号尚未注册";
        } else {
            _tishi.hidden = YES;
            [self request_Api];
        }
    } failure:^(NSError *error) {
        
    }];

}

- (void)request_Api {
    NSDictionary *dic;
    
    dic = @{@"iface":@"DMHY100004",@"mobile":_phoneLable.text,@"password":_pawLable.text};
   
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
                NSLog(@"getToken ==== %@",[BusinessLogic getToken]);
            [NetworkRequest post1:serVerIP params:@{@"iface":@"DMHY100015",@"source":@"1",@"deviceSoleMark":[BusinessLogic deviceToken],@"userId":responseObj[@"userId"]} success:^(id responseObj) {
                NSLog(@"lll22222=======%@",responseObj);
            } failure:^(NSError *error) {
                
            }];
            }
            
            
            if ([_type isEqualToString:@"push"]) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
        } else {
            _tishi.hidden = NO;
            _tishi.text = responseObj[@"resmsg"];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)showLeftView:(UIButton *)btn {
    if ([_type isEqualToString:@"push"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        [self.navigationController popViewControllerAnimated:YES];
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
