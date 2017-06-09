//
//  MyAccountController.m
//  douMiApp
//
//  Created by ydz on 2016/12/26.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MyAccountController.h"
#import "MyBackIdSController.h"
#import "RechargeWithdrawController.h"
#import "RWebViewConreoller.h"
#import "AutonymController.h"
@interface MyAccountController ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UIButton *chongzhiBtn;
@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;
@property (weak, nonatomic) IBOutlet UIButton *yhkBtn;

@property (copy, nonatomic) NSString *backID;
@property (copy, nonatomic) NSString *auth;

@end

@implementation MyAccountController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self request_Api];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    [self addItem:nitem_right btnTitleArr:@[@"历史"]];
    self.lable.text = @"我的账户";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    self.yhkBtn.layer.borderWidth = 1.0;
    self.yhkBtn.layer.borderColor = [RGBA(60, 60, 60, 2) CGColor];
    
    
}

- (void)request_Api {
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400023",@"userId":[BusinessLogic uuid]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _moneyLable.text = responseObj[@"usalbeAmount"];
        _backID =responseObj[@"bankCard"];
        _auth = responseObj[@"auth"];
        //if ([responseObj[@"auth"] isEqualToString:@"1"]) {
        if (_backID) {
            [_yhkBtn setTitle:[NSString stringWithFormat:@" 我的银行卡  %@",responseObj[@"bankCard"]] forState:UIControlStateNormal];
            _chongzhiBtn.enabled = YES;
            _tixianBtn.enabled = YES;
            [_chongzhiBtn setBackgroundColor:RGBA(255, 42, 80, 1)];
            [_tixianBtn setBackgroundColor:RGBA(60, 60, 60, 1)];
        } else {
            _chongzhiBtn.enabled = NO;
            _tixianBtn.enabled = NO;
            [_chongzhiBtn setBackgroundColor:[UIColor grayColor]];
            [_tixianBtn setBackgroundColor:[UIColor grayColor]];
            [_yhkBtn setTitle:@" 暂无绑定银行卡" forState:UIControlStateNormal];
        }
        /*} else {
         [_chongzhiBtn setBackgroundColor:[UIColor grayColor]];
         [_tixianBtn setBackgroundColor:[UIColor grayColor]];
         _chongzhiBtn.enabled = NO;
         [_yhkBtn setTitle:@" 暂无绑定银行卡" forState:UIControlStateNormal];
         }*/
        
    } failure:^(NSError *error) {
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
- (IBAction)chongzhiTouch:(UIButton *)sender {
    RechargeWithdrawController *rechargeVC = [[RechargeWithdrawController alloc] initWithNibName:@"RechargeWithdrawController" bundle:nil];
    rechargeVC.type = @"充值";
    [self.navigationController pushViewController:rechargeVC animated:YES];
}
- (IBAction)tixianTouch:(UIButton *)sender {
    RechargeWithdrawController *rechargeVC = [[RechargeWithdrawController alloc] initWithNibName:@"RechargeWithdrawController" bundle:nil];
    rechargeVC.type = @"提现";
    [self.navigationController pushViewController:rechargeVC animated:YES];
}
- (IBAction)yhkTouch:(UIButton *)sender {
    
    
    if ([_auth isEqualToString:@"1"]) {
        MyBackIdSController *backIds = [[MyBackIdSController alloc] initWithNibName:@"MyBackIdSController" bundle:nil];
        [self.navigationController pushViewController:backIds animated:YES];
    } else {
        AutonymController *autonymVc = [[AutonymController alloc] initWithNibName:@"AutonymController" bundle:nil];
        autonymVc.type = @"bind";
        [self.navigationController pushViewController:autonymVc animated:YES];
        
    }
    
}

- (void)showRightView:(UIButton *)btn {
    RWebViewConreoller * webVC = [[RWebViewConreoller alloc] initWithNibName:@"RWebViewConreoller" bundle:nil];
    webVC.titleStr = @"交易记录";
    webVC.urlStr = [NSString stringWithFormat:accountHistory,[BusinessLogic uuid]];
    [self.navigationController pushViewController:webVC animated:YES];
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
