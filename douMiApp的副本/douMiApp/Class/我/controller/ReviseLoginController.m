//
//  ReviseLoginController.m
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "ReviseLoginController.h"

@interface ReviseLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPaw;
@property (weak, nonatomic) IBOutlet UITextField *xingMiMa1;

@property (weak, nonatomic) IBOutlet UITextField *xingMiMa2;
@property (weak, nonatomic) IBOutlet UILabel *tishi;


@end

@implementation ReviseLoginController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [_oldPaw addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_xingMiMa1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_xingMiMa2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField
{
   
        if (textField.text.length > 12) {
            textField.text = [textField.text substringToIndex:12];
        }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"修改登录密码";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
}
- (IBAction)xiaYiBuTouch:(UIButton *)sender {
    if (_oldPaw.text.length == 0) {
        _tishi.hidden = NO;
        _tishi.text = @"原密码不能为空";
    } else {
        if (_xingMiMa1.text.length == 0) {
            _tishi.hidden = NO;
            _tishi.text = @"新密码不能为空";
        } else {
            if ([_xingMiMa1.text isEqualToString:_xingMiMa2.text]) {
                [self request_Api];
                _tishi.hidden = YES;
                
            } else {
                _tishi.hidden = NO;
                _tishi.text = @"两次密码不一致";
            }
        
        }
    
    }
    
}

- (void)request_Api {
    NSDictionary *dic = @{@"iface":@"DMHY100009",@"userId":[BusinessLogic uuid],@"oldPwd":_oldPaw.text,@"password":_xingMiMa1.text};
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
