//
//  RecreationController.m
//  douMiApp
//
//  Created by ydz on 2017/1/13.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "RecreationController.h"
#import "YTicketViewController.h"
#import "ForgetPayController.h"
#import "ForgetLoginController.h"
#import "SuccessViewController.h"
#import "YYTangchuVC.h"
#import "PaymentView.h"
#import "PayTypeMode.h"
#import "YTicketMode.h"
#import "PopupPawView.h"
#import "PopupCodeview.h"
#import "MEHomeMode.h"
@interface RecreationController ()<YTicketViewDelegate,paymentDelegate,popupCodeDelegate,popupPawDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *pawText;
@property (weak, nonatomic) IBOutlet UIButton *drawBtn;//是否记住密码
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIButton *Y9;
@property (weak, nonatomic) IBOutlet UIButton *Y27;
@property (weak, nonatomic) IBOutlet UIButton *Y90;
@property (weak, nonatomic) IBOutlet UIButton *Y270;
@property (weak, nonatomic) IBOutlet UIButton *Y810;
@property (weak, nonatomic) IBOutlet UIButton *Y2700;
@property (weak, nonatomic) IBOutlet UIView *TicketView;

@property (weak, nonatomic) UIButton *oldBtn;

@property (copy, nonatomic) NSString *YBiStr;
@property (copy, nonatomic) NSString *payType;
@property (strong, nonatomic)PaymentView *paymentView;//支付方式

@property (strong, nonatomic)YTicketMode *yTicketMode;
@property (strong, nonatomic)PayTypeMode *payTypeMode;
@property (weak, nonatomic) IBOutlet UILabel *ticketLable;
@property (weak, nonatomic) IBOutlet UILabel *errorLable;
@property (copy, nonatomic) NSString *mvId;
@property (assign, nonatomic) NSInteger amount;

@property (strong, nonatomic) PopupPawView *popupPaw;
@property (strong, nonatomic) PopupCodeview *popupCode;
@property (copy, nonatomic) NSString *serialNumber;
@property (copy, nonatomic) NSString *orderId;


@end

@implementation RecreationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self reauest_api];
    [MobClick beginLogPageView:@"娱乐充值"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"娱乐充值"];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"娱乐直充";
    self.lable.textColor = RGBA(40, 40, 40, 1);

    // Do any additional setup after loading the view from its nib.
    _amount = 0;
    
    [_accountText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_pawText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *ticketTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ticketTap:)];
    [_TicketView addGestureRecognizer:ticketTap];
    
    _view1.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
    _view1.layer.borderWidth = 1.0;
    _view2.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
    _view2.layer.borderWidth = 1.0;
    _Y9.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
    _Y9.layer.borderWidth = 1.0;
    [self YBiClick:_Y9];
    
    _Y27.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
    _Y27.layer.borderWidth = 1.0;
    _Y90.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
    _Y90.layer.borderWidth = 1.0;
    _Y270.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
    _Y270.layer.borderWidth = 1.0;
    _Y810.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
    _Y810.layer.borderWidth = 1.0;
    _Y2700.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
    _Y2700.layer.borderWidth = 1.0;
    
    _accountText.text = [BusinessLogic YYAccound];
    
    if ([BusinessLogic YYPaw].length == 0) {
        _drawBtn.selected = YES;
    } else {
        _drawBtn.selected = NO;
        _pawText.text = [BusinessLogic YYPaw];
    }
    
    
}


- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.accountText) {
        if (textField.text.length > 30) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
    if (textField == self.pawText) {
        if (textField.text.length >30) {
            textField.text = [textField.text substringToIndex:12];
        }
    }
    
    [BusinessLogic setYYAccound:self.accountText.text];
    
    if (_drawBtn.selected) {
        
    } else {
        if (self.accountText.text.length == 0) {
            [BusinessLogic setYYPaw:@""];
            
        } else {
            [BusinessLogic setYYPaw:self.pawText.text];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    {
        if([string length] != 0)
        {
            NSLog(@"点击了非删除键");
        }
        else
        {
            NSLog(@"点击了删除键");
            self.pawText.text = @"";
        }
    }
    return YES;
}

- (void)reauest_api {
    NSDictionary *dic = @{@"iface":@"DMHY400049",@"type":@"2",@"userId":[BusinessLogic uuid]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        _yTicketMode = [YTicketMode mj_objectWithKeyValues:responseObj];
        if (_yTicketMode.voucherExchangeList.count > 0) {
           _ticketLable.text = [NSString stringWithFormat:@"优惠券：Y币%@元优惠券",_yTicketMode.voucherExchangeList[0].amount];
            _amount = [_yTicketMode.voucherExchangeList[0].amount integerValue];
            _mvId = _yTicketMode.voucherExchangeList[0].mvId;
        } else {
            _ticketLable.text = @"无可用优惠券";
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    

}

- (IBAction)markClick:(UIButton *)sender {//问号
    YYTangchuVC *yyTCVC = [[YYTangchuVC alloc] initWithNibName:@"YYTangchuVC" bundle:nil];
    [self presentViewController:yyTCVC animated:YES completion:nil];
}

- (IBAction)drawBtnClick:(UIButton *)sender {//记住密码
    _drawBtn.selected = !_drawBtn.selected;
    if (_drawBtn.selected) {
        [BusinessLogic setYYPaw:@""];
    } else {
        [BusinessLogic setYYPaw:_pawText.text];
    }
    
}

- (void)ticketTap:(UITapGestureRecognizer *)tap {
    
    if (_yTicketMode.voucherExchangeList.count > 0) {
        //优惠券
        YTicketViewController *ticketVC = [[YTicketViewController alloc] initWithNibName:@"YTicketViewController" bundle:nil];
        ticketVC.delegate =self;
        ticketVC.mode = _yTicketMode;
        [self presentViewController:ticketVC animated:YES completion:nil];
    } else {
       
    }
    
    
    
}

- (void)returnVoucher:(VoucherExchangeList *)mode {
    
    if (mode.amount.length == 0) {
        _ticketLable.text = @"请选择优惠券";
        _mvId = @"";
        _amount = 0;
    } else {
    
    _ticketLable.text = [NSString stringWithFormat:@"优惠券：Y币%@元优惠券",mode.amount];
        _amount = [mode.amount integerValue];
    _mvId = mode.mvId;
    }
}

- (IBAction)YBiClick:(UIButton *)sender {
    [_oldBtn setTitleColor:RGBA(60, 60, 60, 1) forState:UIControlStateNormal];
    [_oldBtn setBackgroundColor:[UIColor clearColor]];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender setBackgroundColor:RGBA(60, 60, 60, 1)];
    _oldBtn = sender;
    _YBiStr = [NSString stringWithFormat:@"%i",sender.tag];
}

- (IBAction)chongZhiClick:(UIButton *)sender {
    [MobClick event:@"rechargeNum"];
    _paymentView = [PaymentView new];
    _paymentView.delegate = self;
    if (_accountText.text.length == 0) {
        _errorLable.hidden = NO;
        _errorLable.text = @"YY账号不能为空";
    } else {
        if (_pawText.text.length == 0) {
            _errorLable.hidden = NO;
            _errorLable.text = @"YY密码不能为空";
        } else {
         _errorLable.hidden = YES;
        [self request_ChannelApi];
        }
    
    }
    
    
}

- (void)request_ChannelApi {
    NSDictionary *dic = @{@"iface":@"DMHY200010",@"userId":[BusinessLogic uuid],@"channel":@"1",@"payAmount":[NSString stringWithFormat:@"%li",(long)[_YBiStr integerValue]-_amount]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        _payTypeMode = [PayTypeMode mj_objectWithKeyValues:responseObj];
        _paymentView.mode = _payTypeMode;
        _paymentView.titleLable.text = [NSString stringWithFormat:@"给%@充值%@Y币",_accountText.text,_YBiStr];
        _paymentView.moneyLable.text = [NSString stringWithFormat:@"%.2f",[_YBiStr floatValue]-_amount];
       [_paymentView startAnimationFunction];
    } failure:^(NSError *error) {
        
    }];
    
    

}

- (void)selectPayment:(NSString *)typePay {
    _payType = typePay;
    
}

- (void)paymentAffirmDelegate {
    
    if (_payType.length == 0 ) {
        
    } else {
    
    NSDictionary *dic = @{@"iface":@"DMHY400047",@"userId":[BusinessLogic uuid]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        if ([responseObj[@"payPwd"] isEqualToString:@"已设置"]) {
            _popupPaw = [PopupPawView new];
            _popupPaw.delegate = self;
            [_popupPaw startAnimationFunction];
            
        } else {
            ForgetPayController *forgetVC = [[ForgetPayController alloc] init];
            forgetVC.mold = @"999";
            [self.navigationController pushViewController:forgetVC animated:YES];
        
        }
        
    } failure:^(NSError *error) {
        
    }];
    }
}

- (void)popupPaw:(NSString *)paw{//输入代理
    [self verifyPayPaw:paw];

}
- (void)foundPawDelegate{//忘记密码代理
    ForgetLoginController *forLVC = [[ForgetLoginController alloc] initWithNibName:@"ForgetLoginController" bundle:nil];
    forLVC.type = @"3";
    [self.navigationController pushViewController:forLVC animated:YES];
}

- (void)verifyPayPaw:(NSString *)paw {
    [MBProgressHUD showHUDAddedTo:_popupPaw animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY200011",@"userId":[BusinessLogic uuid],@"tradePwd":paw};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
       
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            [self whatPay:_payType];
        } else {
             [MBProgressHUD hideHUDForView:_popupPaw animated:YES];
            _popupPaw.errorLable.hidden = NO;
            _popupPaw.errorLable.text = responseObj[@"resmsg"];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:_popupPaw animated:YES];
        _popupPaw.errorLable.hidden = NO;
        _popupPaw.errorLable.text = @"网络错误";
    }];
    
}

- (void)whatPay:(NSString *)payType
{
    
    if ([payType isEqualToString:@"3"]) {
        
        [self request_Recharge];
    } else {
        
        [self request_Atlast];
    
    }
}

- (void)request_Recharge {
    NSDictionary *dic = @{@"iface":@"DMHY400025",@"userId":[BusinessLogic uuid],@"rechargeAmount":[NSString stringWithFormat:@"%li",(long)[_YBiStr integerValue]-_amount]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            _popupPaw.errorLable.hidden = YES;
            _serialNumber = responseObj[@"serialNumber"];
            _orderId = responseObj[@"orderId"];
            [self request_CodeApi:responseObj[@"serialNumber"] orderId:responseObj[@"orderId"]];
        } else {
            [MBProgressHUD hideHUDForView:_popupPaw animated:YES];
            _popupPaw.errorLable.hidden = NO;
            _popupPaw.errorLable.text = responseObj[@"resmsg"];
           
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:_popupPaw animated:YES];
        _popupPaw.errorLable.hidden = NO;
        _popupPaw.errorLable.text = @"网络错误";
    }];
    
}

- (void)request_CodeApi:(NSString *)serialNumber orderId:(NSString *)orderId {
    
    NSDictionary *dic = @{@"iface":@"DMHY400012",@"userId":[BusinessLogic uuid],@"phone":[BusinessLogic getPhoneNo],@"nextTxnSubType":@"04",@"txnSubType":@"05",@"baoBindId":_payTypeMode.bankInfo.bindId,@"txnAmt":[NSString stringWithFormat:@"%li",(long)[_YBiStr integerValue]-_amount],@"orderId":orderId,@"serialNumber":serialNumber};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj[@"resmsg"]);
        [MBProgressHUD hideHUDForView:_popupPaw animated:YES];
        
        NSMutableString *str = [[NSMutableString alloc] initWithString:[BusinessLogic getPhoneNo]];
        NSRange range = {0,7};
        [str replaceCharactersInRange:range withString:@"****"];
        _popupCode = [PopupCodeview new];
        _popupCode.phone = str;
        _popupCode.delegate = self;
        
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            _popupPaw.errorLable.hidden = YES;
//            [_popupPaw CloseAnimationFunction];
            [_popupCode startAnimationFunction];
        } else {
            _popupPaw.errorLable.hidden = NO;
            _popupPaw.errorLable.text = responseObj[@"resmsg"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:_popupPaw animated:YES];
        _popupPaw.errorLable.hidden = NO;
        _popupPaw.errorLable.text = @"网络错误";
        
    }];
    
    
}

- (void)codeDelegate {
    [MBProgressHUD showHUDAddedTo:self.popupCode animated:YES];
   NSDictionary *dic = @{@"iface":@"DMHY400012",@"userId":[BusinessLogic uuid],@"phone":[BusinessLogic getPhoneNo],@"nextTxnSubType":@"04",@"txnSubType":@"05",@"baoBindId":_payTypeMode.bankInfo.bindId,@"txnAmt":[NSString stringWithFormat:@"%li",(long)[_YBiStr integerValue]-_amount],@"orderId":_orderId,@"serialNumber":_serialNumber};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.popupCode animated:YES];
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            self.popupCode.errorLable.hidden = YES;
        } else {
            self.popupCode.errorLable.hidden = NO;
            self.popupCode.errorLable.text = responseObj[@"resmsg"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.popupCode animated:YES];
        self.popupCode.errorLable.hidden = NO;
        self.popupCode.errorLable.text = @"网络错误";
        
    }];
    
}
- (void)confirmDelegate {
    if (self.popupCode.phoneText.text.length == 0) {
        self.popupCode.errorLable.hidden = NO;
        self.popupCode.errorLable.text = @"请输入验证码";
    } else {
        [MBProgressHUD showHUDAddedTo:self.popupCode animated:YES];
//        self.popupCode.confirmBtn.enabled = NO;
        NSDictionary *dic = @{@"iface":@"DMHY400041",@"userId":[BusinessLogic uuid],@"orderId":_orderId,@"rechargeAmount":[NSString stringWithFormat:@"%li",(long)[_YBiStr integerValue]-_amount],@"bankId":[NSString stringWithFormat:@"%li",(long)_payTypeMode.bankInfo.bankId],@"txnSubType":@"04",@"validCode":self.popupCode.phoneText.text,@"serialNumber":_serialNumber};
        [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
            [MBProgressHUD hideHUDForView:self.popupCode animated:YES];
            self.popupCode.confirmBtn.enabled = YES;
            MEHomeMode *mode = [MEHomeMode mj_objectWithKeyValues:responseObj];
            if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
                if (mode.success == 1) {
                    self.popupCode.errorLable.hidden = YES;
                    [self request_Atlast];
                } else {
                    self.popupCode.errorLable.hidden = NO;
                    self.popupCode.errorLable.text = responseObj[@"message"];
                }
            } else {
                self.popupCode.errorLable.hidden = NO;
                self.popupCode.errorLable.text = responseObj[@"resmsg"];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.popupCode animated:YES];
            self.popupCode.confirmBtn.enabled = YES;
            self.popupCode.errorLable.hidden = NO;
            self.popupCode.errorLable.text = @"网络错误";
        }];
    }
}

- (void)request_Atlast {
    NSDictionary *dic;
    if (_mvId.length == 0) {
        dic = @{@"iface":@"DMHY200012",@"payType":_payType,@"password":_pawText.text,@"userId":[BusinessLogic uuid],@"totalMoney":_YBiStr,@"type":@"0",@"yyAcounts":_accountText.text};
    } else {
        dic = @{@"iface":@"DMHY200012",@"payType":_payType,@"password":_pawText.text,@"userId":[BusinessLogic uuid],@"totalMoney":_YBiStr,@"type":@"0",@"veId":_mvId,@"yyAcounts":_accountText.text};
    }
    
    NSLog(@"%@",[NetworkRequest dictionaryToJson:dic]);
    
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:_popupPaw animated:YES];
        [MBProgressHUD hideHUDForView:_popupCode animated:YES];
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            
            if ([@"1" isEqualToString:responseObj[@"status"]]) {
                if ([_payType isEqualToString:@"3"]) {
                    _popupCode.errorLable.hidden = NO;
                    _popupCode.errorLable.text = @"系统正在维护,请稍后再试";
                } else {
                    _popupPaw.errorLable.hidden = NO;
                    _popupPaw.errorLable.text = @"系统正在维护,请稍后再试";
                }
            } else {
            
            _popupPaw.errorLable.hidden = YES;
            _popupCode.errorLable.hidden = YES;
            [_popupPaw CloseAnimationFunction];
            [_popupCode CloseAnimationFunction];
            SuccessViewController *successVC = [[SuccessViewController alloc] initWithNibName:@"SuccessViewController" bundle:nil];
            successVC.money =_YBiStr;
                [self.navigationController pushViewController:successVC animated:YES];
            }
        }else {
            if ([_payType isEqualToString:@"3"]) {
                _popupCode.errorLable.hidden = NO;
                _popupCode.errorLable.text = responseObj[@"resmsg"];
            } else {
                _popupPaw.errorLable.hidden = NO;
                _popupPaw.errorLable.text = responseObj[@"resmsg"];
            }
        
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:_popupPaw animated:YES];
        [MBProgressHUD hideHUDForView:_popupCode animated:YES];
        if ([_payType isEqualToString:@"3"]) {
            _popupCode.errorLable.hidden = NO;
            _popupCode.errorLable.text = @"网络错误";
        } else {
            _popupPaw.errorLable.hidden = NO;
            _popupPaw.errorLable.text = @"网络错误";
        }
        
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
