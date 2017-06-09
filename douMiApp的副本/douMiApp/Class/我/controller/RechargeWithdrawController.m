//
//  RechargeWithdrawController.m
//  douMiApp
//
//  Created by ydz on 2016/12/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "RechargeWithdrawController.h"
#import "MyBackIdSController.h"
#import "SuccessViewController.h"
#import "BoundClipController.h"
#import "ForgetLoginController.h"
#import "PopupCodeview.h"
#import "PopupPawView.h"
#import "ForgetPayController.h"
#import <IQKeyboardManager.h>
#import "MEHomeMode.h"
@interface RechargeWithdrawController ()<popupCodeDelegate,popupPawDelegate>
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *backName;
@property (weak, nonatomic) IBOutlet UILabel *backId;
@property (weak, nonatomic) IBOutlet UILabel *stateLable;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UITextField *moneyText;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *yesBtn;
@property (weak, nonatomic) IBOutlet UILabel *centerLAble;
@property (copy, nonatomic) NSString *iface;
@property (nonatomic, strong) UITapGestureRecognizer *ges;
@property (weak, nonatomic) IBOutlet UILabel *tiShiLable;
@property (nonatomic, strong) PopupCodeview *popupView;
@property (nonatomic, strong) PopupPawView *popupPawView;
@property (copy, nonatomic) NSString *rechargeStr;
@property (copy, nonatomic) NSString *withdrawStr;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *alias;
@property (copy, nonatomic) NSString *backCard;
@property (copy, nonatomic) NSString *serialNumber;
@property (copy, nonatomic) NSString *orderId;
@property (copy, nonatomic) NSString *bankIds;
@property (copy, nonatomic) NSString *baoBindId;
@end

@implementation RechargeWithdrawController


- (void)dealloc{
    
    self.ges = nil;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    if ([self.type isEqualToString:@"充值"]) {
        self.allBtn.hidden = YES;
        _iface = @"DMHY400043";
    } else {
        self.allBtn.hidden = NO;
        _iface = @"DMHY400044";
    }
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self request_Api];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = self.type;
    self.lable.textColor = RGBA(40, 40, 40, 1);
    // Do any additional setup after loading the view from its nib.
    self.ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view1Touch:)];
    [self.view1 addGestureRecognizer:self.ges];
    self.allBtn.layer.borderWidth = 1;
    
    if ([self.type isEqualToString:@"充值"]) {
        _moneyText.keyboardType = UIKeyboardTypeNumberPad;
    } else {
         _moneyText.keyboardType = UIKeyboardTypeDecimalPad;
    }
    self.popupView = [PopupCodeview new];
    self.popupView.delegate = self;
    
    self.popupPawView = [PopupPawView new];
    self.popupPawView.delegate = self;
    
    [self.moneyText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length >10) {
        textField.text = [textField.text substringToIndex:10];
    }
}



- (void)view1Touch:(UITapGestureRecognizer *)tap {
    if (_backCard.length == 0) {
        BoundClipController *boundClip = [[BoundClipController alloc] init];
        [self.navigationController pushViewController:boundClip animated:YES];
    } else {
        
        MyBackIdSController *myBackIDsVC = [[MyBackIdSController alloc] initWithNibName:@"MyBackIdSController" bundle:nil];
        [self.navigationController pushViewController:myBackIDsVC animated:YES];
    }
    
    

}

- (void)request_Api {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":_iface,@"userId":[BusinessLogic uuid]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *bankCard =responseObj[@"bankCard"];
        _rechargeStr =responseObj[@"singleCharge"];
        _withdrawStr = responseObj[@"usableAmount"];
        _backCard = responseObj[@"bankCard"];
        _phone = responseObj[@"phone"];
        _alias = responseObj[@"bankabbreviation"];
        _bankIds = responseObj[@"id"];
        _baoBindId = responseObj[@"baoBindId"];
        if (bankCard.length == 0) {
            _backId.hidden = YES;
            _backName.hidden = YES;
            _centerLAble.hidden = NO;
            _moneyText.textColor = [UIColor lightGrayColor];
            _moneyText.enabled = NO;
            _allBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            [_allBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _allBtn.enabled = NO;
            _moneyLable.textColor = [UIColor lightGrayColor];
            _centerLAble.text = @"未绑定银行卡，请前往绑定";
            [_yesBtn setBackgroundColor:[UIColor lightGrayColor]];
            _yesBtn.enabled = NO;
            _stateLable.hidden = YES;
            _moneyText.text = [self.type isEqualToString:@"提现"]?[NSString stringWithFormat:@"本次最多可%@%@元",self.type,responseObj[@"usableAmount"]]:@"请输入充值金额";
        } else {
            _backId.hidden = NO;
            _backName.hidden = NO;
            _centerLAble.hidden = YES;
            _backName.text = [NSString stringWithFormat:@"%@：%@",responseObj[@"debitCard"],responseObj[@"bankName"]];
            NSMutableString *backStr = [[NSMutableString alloc] initWithString:responseObj[@"bankCard"]];
            _backId.text = [NSString stringWithFormat:@"尾号%@",[backStr substringFromIndex:backStr.length-4]];
            _stateLable.hidden = NO;
            _stateLable.text = [self.type isEqualToString:@"充值"]?[NSString stringWithFormat:@"该卡本次最多可充值%@元",responseObj[@"singleCharge"]]:[NSString stringWithFormat:@"单笔提现上限为%@",responseObj[@"usableAmount"]];
            _moneyLable.textColor = RGBA(40, 40, 40, 1);
            _moneyText.textColor = RGBA(140, 140, 140, 1);
             _moneyText.enabled = YES;
            _allBtn.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
            [_allBtn setTitleColor:RGBA(40, 40, 40, 1) forState:UIControlStateNormal];
            _allBtn.enabled = YES;
            [_yesBtn setBackgroundColor:RGBA(60, 60, 60, 1)];
            _yesBtn.enabled = YES;
            _moneyText.placeholder = [self.type isEqualToString:@"提现"]?[NSString stringWithFormat:@"本次最多可%@%@元",self.type,responseObj[@"usableAmount"]]:@"请输入充值金额";
            
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (IBAction)allTouch:(UIButton *)sender {
    if ([self.type isEqualToString:@"提现"]) {
        _moneyText.text = _withdrawStr;
        
    } else {
        
        
    }
    
    
}
- (IBAction)yesTouch:(UIButton *)sender {
    if ([self.type isEqualToString:@"充值"]) {
        if (_moneyText.text.length == 0) {
            _tiShiLable.hidden = NO;
            _tiShiLable.text = @"请输入充值金额";
        } else {
        if ([_moneyText.text floatValue] > [_rechargeStr floatValue]) {
            _tiShiLable.hidden = NO;
            _tiShiLable.text = @"超出最大充值金额";
        } else {
            _tiShiLable.hidden = YES;
             [self request_Recharge];
        }
        }
    } else {
        if (_moneyText.text.length == 0) {
            _tiShiLable.hidden = NO;
            _tiShiLable.text = @"请输入提现金额";
        } else {
            if ([_moneyText.text floatValue] > [_withdrawStr floatValue]) {
                _tiShiLable.hidden = NO;
                _tiShiLable.text = @"超出最大提现金额";
            } else {
                _tiShiLable.hidden = YES;
                
                NSDictionary *dic = @{@"iface":@"DMHY400047",@"userId":[BusinessLogic uuid]};
                [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
                    if ([responseObj[@"payPwd"] isEqualToString:@"已设置"]) {
                        [self.popupPawView startAnimationFunction];
                        
                    } else {
                        ForgetPayController *forgetVC = [[ForgetPayController alloc] init];
                        forgetVC.mold = @"999";
                        [self.navigationController pushViewController:forgetVC animated:YES];
                        
                    }
                    
                } failure:^(NSError *error) {
                    
                }];
                
                
                
            }
        }
    }
}

- (void)request_Recharge {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400025",@"userId":[BusinessLogic uuid],@"rechargeAmount":_moneyText.text};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            _tiShiLable.hidden = YES;
            _serialNumber = responseObj[@"serialNumber"];
            _orderId = responseObj[@"orderId"];
            [self request_CodeApi];
        } else {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
            _tiShiLable.hidden = NO;
            _tiShiLable.text = responseObj[@"resmsg"];
        }
    } failure:^(NSError *error) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        _tiShiLable.hidden = NO;
        _tiShiLable.text = @"网络错误";
    }];

}



- (void)request_CodeApi {
    
    NSDictionary *dic = @{@"iface":@"DMHY400012",@"userId":[BusinessLogic uuid],@"bankCode":_alias,@"bankNo":_backCard,@"phone":_phone,@"nextTxnSubType":@"04",@"txnSubType":@"05",@"baoBindId":_baoBindId,@"txnAmt":_moneyText.text,@"orderId":_orderId,@"serialNumber":_serialNumber};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _tiShiLable.hidden = YES;
        NSMutableString *str = [[NSMutableString alloc] initWithString:_phone];
        NSRange range = {0,7};
        [str replaceCharactersInRange:range withString:@"****"];
        self.popupView.phone = str;
        [self.popupView startAnimationFunction];
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            self.popupView.errorLable.hidden = YES;
        } else {
            self.popupView.errorLable.hidden = NO;
            self.popupView.errorLable.text = responseObj[@"resmsg"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _tiShiLable.hidden = NO;
        _tiShiLable.text = @"网络错误";

    }];
    
    
}

- (void)codeDelegate {
    [MBProgressHUD showHUDAddedTo:self.popupView animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400012",@"userId":[BusinessLogic uuid],@"bankCode":_alias,@"bankNo":_backCard,@"phone":_phone,@"nextTxnSubType":@"04",@"txnSubType":@"05",@"baoBindId":_baoBindId,@"txnAmt":_moneyText.text,@"orderId":_orderId,@"serialNumber":_serialNumber};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.popupView animated:YES];
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            self.popupView.errorLable.hidden = YES;
        } else {
            self.popupView.errorLable.hidden = NO;
            self.popupView.errorLable.text = responseObj[@"resmsg"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.popupView animated:YES];
        self.popupView.errorLable.hidden = NO;
        self.popupView.errorLable.text = @"网络错误";
        
    }];
}

- (void)confirmDelegate {
    if (self.popupView.phoneText.text.length == 0) {
        self.popupView.errorLable.hidden = NO;
        self.popupView.errorLable.text = @"请输入验证码";
    } else {
        [MBProgressHUD showHUDAddedTo:self.popupView animated:YES];
//        self.popupView.confirmBtn.enabled = NO;
        NSDictionary *dic = @{@"iface":@"DMHY400041",@"userId":[BusinessLogic uuid],@"orderId":_orderId,@"rechargeAmount":_moneyText.text,@"bankId":_bankIds,@"txnSubType":@"04",@"validCode":self.popupView.phoneText.text,@"serialNumber":_serialNumber};
        [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
             [MBProgressHUD hideHUDForView:self.popupView animated:YES];
             MEHomeMode *mode = [MEHomeMode mj_objectWithKeyValues:responseObj];
            self.popupView.confirmBtn.enabled = YES;
            if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
                if (mode.success == 0) {
                    self.popupView.errorLable.hidden = NO;
                    self.popupView.errorLable.text = responseObj[@"message"];
                } else {
                    self.popupView.errorLable.hidden = YES;
                    [self.popupView CloseAnimationFunction];
                    SuccessViewController *successVC = [[SuccessViewController alloc] initWithNibName:@"SuccessViewController" bundle:nil];
                    successVC.money = _moneyText.text;
                    [self.navigationController pushViewController:successVC animated:YES];
                }
            } else {
                
                self.popupView.errorLable.hidden = NO;
                self.popupView.errorLable.text = responseObj[@"resmsg"];
            }

            
        } failure:^(NSError *error) {
             [MBProgressHUD hideHUDForView:self.popupView animated:YES];
            self.popupView.confirmBtn.enabled = YES;
            self.popupView.errorLable.hidden = NO;
            self.popupView.errorLable.text = @"网络错误";
        }];
    }
    
    
    
    
}

- (void)popupPaw:(NSString *)paw {
    [MBProgressHUD showHUDAddedTo:self.popupPawView animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400026",@"userId":[BusinessLogic uuid],@"bankId":_bankIds,@"applyCashAmount":_moneyText.text,@"tradePwd":paw};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.popupPawView animated:YES];
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            self.popupPawView.errorLable.hidden = YES;
            [self.popupPawView CloseAnimationFunction];
            SuccessViewController *successVC = [[SuccessViewController alloc] initWithNibName:@"SuccessViewController" bundle:nil];
            [self.navigationController pushViewController:successVC animated:YES];
        } else {
            self.popupPawView.errorLable.hidden = NO;
            self.popupPawView.errorLable.text = responseObj[@"resmsg"];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.popupPawView animated:YES];
        self.popupPawView.errorLable.hidden = NO;
        self.popupPawView.errorLable.text = @"网络错误";
    }];

}

- (void)foundPawDelegate {
    ForgetLoginController *forgetPaw = [[ForgetLoginController alloc] initWithNibName:@"ForgetLoginController" bundle:nil];
    forgetPaw.type = @"3";
    forgetPaw.phone = _phone;
    [self.navigationController pushViewController:forgetPaw animated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
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
