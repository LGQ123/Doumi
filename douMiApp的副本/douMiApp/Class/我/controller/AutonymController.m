//
//  AutonymController.m
//  douMiApp
//
//  Created by ydz on 2016/12/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "AutonymController.h"
#import "BoundClipController.h"
@interface AutonymController ()
@property (weak, nonatomic) IBOutlet UITextField *unameText;
@property (weak, nonatomic) IBOutlet UITextField *identityText;
@property (weak, nonatomic) IBOutlet UIButton *unameBtn;
@property (weak, nonatomic) IBOutlet UILabel *tishiLable;

@end

@implementation AutonymController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [_unameText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_identityText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField == self.unameText) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }
    
    
    if (textField == self.identityText) {
        if (textField.text.length > 18) {
            textField.text = [textField.text substringToIndex:18];
        }
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"实名认证";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    if ([self.type isEqualToString:@"bind"]) {
        [self.unameBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
}

- (IBAction)btnTouch:(UIButton *)sender {
    if (self.unameText.text.length == 0) {
        _tishiLable.hidden = NO;
        _tishiLable.text = @"请输入您的真实姓名";
    } else {
        if ([BusinessLogic isValidateIdentityCard:self.identityText.text]) {
            _tishiLable.hidden = YES;
            [self request_Api:sender];
            
        } else {
            _tishiLable.hidden = NO;
            _tishiLable.text = @"请正确输入身份证号";
        
        
        }
    
    
    }
    
}


- (void)request_Api:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400017",@"userId":[BusinessLogic uuid],@"name":self.unameText.text,@"idCard":self.identityText.text};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            if ([sender.titleLabel.text isEqualToString:@"完成"]) {
                _tishiLable.hidden = YES;
                [self.navigationController popViewControllerAnimated:YES];
                
            } else {
                BoundClipController *boundVC = [[BoundClipController alloc] init];
                boundVC.type = self.type;
                [self.navigationController pushViewController:boundVC animated:YES];
            }
        } else {
            _tishiLable.hidden = NO;
            _tishiLable.text = responseObj[@"resmsg"];
        
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
