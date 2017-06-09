//
//  DMUserIdentifyViewController.m
//  douMiApp
//
//  Created by edz on 2017/1/16.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "DMUserIdentifyViewController.h"
#import "DMSelectBankcardViewController.h"
#import "DMMeXinModel.h"

@interface DMUserIdentifyViewController ()

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *cardField;
@property (nonatomic, strong) UILabel *errorLable;
@property (nonatomic, assign) BOOL isApprove;
@end

@implementation DMUserIdentifyViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    // 进入页面同时请求是否进行了实名认证DMHY400016，若实名认证了默认将用户名和身份证号填入，若为实名，需要用户手动填写
    [self requestRealNameStatus];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MobClick endEvent:@"MFQIdApprove"];
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"实名认证";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    
    _nameField = [self getTextFieldWithFrame:CGRectMake(42, 104, SCREEN_WIDTH-84, 41) andPlaceHolder:@"请输入您的姓名" ];
    [self.view addSubview:_nameField];
    
    
    _cardField = [self getTextFieldWithFrame:CGRectMake(_nameField.mj_x, _nameField.mj_y+_nameField.mj_h+10, _nameField.mj_w, _nameField.mj_h) andPlaceHolder:@"请输入您的身份证号"];
    [self.view addSubview:_cardField];
    
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(_cardField.mj_x, _cardField.mj_y+_cardField.mj_h+49, _cardField.mj_w, _cardField.mj_h)];
    nextBtn.backgroundColor = RGBA(60, 60, 60, 1);
    nextBtn.titleLabel.font = DMFont(12);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    [self.view addSubview:self.errorLable];
    self.errorLable.hidden = YES;
}


- (void)requestRealNameStatus {
    __weak __typeof(self) weakSelf = self;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY400016" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        DMMeXinRealNameModel *model = [DMMeXinRealNameModel mj_objectWithKeyValues:responseObj];
        if ([model.rescode isEqualToString:@"0000"]) {
            if (!isEmpty(model.realName)) { // 已经实名验证了
                _isApprove = YES;
                weakSelf.nameField.textColor = [UIColor lightGrayColor];
                weakSelf.cardField.textColor = [UIColor lightGrayColor];
                weakSelf.nameField.text = model.realName;
                weakSelf.cardField.text = model.idCard;
                weakSelf.nameField.enabled = NO;
                weakSelf.cardField.enabled = NO;
                
            } else { // 未进行实名认证
                _isApprove = NO;
            
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)nextButtonClick {
    
    // 点击下一步，调用银行卡信息DMHY400019，若有银行卡信息跳到选择验证的银行卡页面，若没有银行卡isBindBankcard=no，跳到另一个页面
    
    if (isEmpty(_nameField.text)) {
        UIAlertView *alertName = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先输入姓名!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertName show];
        return;
    }
    
    if (isEmpty(_cardField.text)) {
        UIAlertView *alertCard = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先输入身份证号!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertCard show];
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    
    if (_isApprove) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic dm_setObject:@"DMHY400019" forKey:@"iface"];
        [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
        [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
            DMMeXinBankInfoModel *model = [DMMeXinBankInfoModel mj_objectWithKeyValues:responseObj];
            if ([model.rescode isEqualToString:@"0000"]) {
                if (!isEmpty(model.bank)) {
                    DMSelectBankcardViewController *controller = [[DMSelectBankcardViewController alloc] init];
                    controller.isBindBankcard = YES;
                    controller.bankInfoModel = model;
                    [weakSelf.navigationController pushViewController:controller animated:YES];
                } else { // 未绑定银行卡
                    DMSelectBankcardViewController *controller = [[DMSelectBankcardViewController alloc] init];
                    controller.isBindBankcard = NO;
                    [weakSelf.navigationController pushViewController:controller animated:YES];
                }
            }
        } failure:^(NSError *error) {
            [LCProgressHUD showMessage:@"连接超时"];
            
            
        }];
    } else {
        NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
        [dic1 dm_setObject:@"DMHY400017" forKey:@"iface"];
        [dic1 dm_setObject:_nameField.text forKey:@"name"];
        [dic1 dm_setObject:_cardField.text forKey:@"idCard"];
        [dic1 dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
        [NetworkRequest post1:serVerIP params:dic1 success:^(id responseObj) {
            self.errorLable.hidden = YES;
            self.errorLable.text = @"";
            if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic dm_setObject:@"DMHY400019" forKey:@"iface"];
                [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
                [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
                    DMMeXinBankInfoModel *model = [DMMeXinBankInfoModel mj_objectWithKeyValues:responseObj];
                    if ([model.rescode isEqualToString:@"0000"]) {
                        if (!isEmpty(model.bank)) {
                            DMSelectBankcardViewController *controller = [[DMSelectBankcardViewController alloc] init];
                            controller.isBindBankcard = YES;
                            controller.bankInfoModel = model;
                            [weakSelf.navigationController pushViewController:controller animated:YES];
                        } else { // 未绑定银行卡
                            DMSelectBankcardViewController *controller = [[DMSelectBankcardViewController alloc] init];
                            controller.isBindBankcard = NO;
                            [weakSelf.navigationController pushViewController:controller animated:YES];
                        }
                    }
                } failure:^(NSError *error) {
                    [LCProgressHUD showMessage:@"连接超时"];
                    
                    
                }];
                
            } else {
                self.errorLable.hidden = NO;
                self.errorLable.text = responseObj[@"resmsg"];
            }
            
            
        } failure:^(NSError *error) {
            self.errorLable.hidden = YES;
            self.errorLable.text = @"";
            [LCProgressHUD showMessage:@"连接超时"];
        }];
    
    }
    
    
    
    
    
    
    
}


- (UITextField *)getTextFieldWithFrame:(CGRect)frame andPlaceHolder:(NSString *)placeholder {
    UITextField *field = [[UITextField alloc] initWithFrame:frame];
    field.backgroundColor = [UIColor clearColor];
    field.layer.borderColor = RGBA(60, 60, 60, 1).CGColor;
    field.layer.borderWidth = 1;
    field.placeholder = placeholder;
    field.font = DMFont(12);
    field.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, field.mj_h)];
    field.leftViewMode = UITextFieldViewModeAlways;
    return field;
}

- (UILabel *)errorLable {
    if (!_errorLable) {
        _errorLable = [[UILabel alloc] init];
        _errorLable.backgroundColor = [UIColor clearColor];
        _errorLable.frame = CGRectMake(_cardField.mj_x, _cardField.mj_y+_cardField.mj_h+49+_cardField.mj_h+10, 200, 10);
        _errorLable.textColor = [UIColor redColor];
        _errorLable.textAlignment = NSTextAlignmentLeft;
        _errorLable.font = [UIFont systemFontOfSize:10];
        
        
    }
    
    return _errorLable;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
