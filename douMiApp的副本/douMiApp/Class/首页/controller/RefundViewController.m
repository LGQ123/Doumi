//
//  RefundViewController.m
//  douMiApp
//
//  Created by ydz on 2017/1/11.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "RefundViewController.h"
#import "RefundCell.h"
#import "HuanKuanMode.h"
#import "SuccessViewController.h"
#import "ForgetLoginController.h"
#import "HelpCenterController.h"
#import "PaymentView.h"
#import "PayTypeMode.h"
#import "PopupPawView.h"
#import "PopupCodeview.h"
@interface RefundViewController ()<UITableViewDataSource,UITableViewDelegate,paymentDelegate,popupCodeDelegate,popupPawDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *allXuanBtn;

@property (assign, nonatomic) BOOL isBianJi;
@property (weak, nonatomic) IBOutlet UILabel *totlePriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *gotoHuan;

@property (strong,nonatomic)NSMutableArray <Overduerepayments *>*dataArray;
@property (strong,nonatomic)NSMutableArray <Overduerepayments *>*selectedArray;

@property (strong, nonatomic) HuanKuanMode *mode;

@property (strong, nonatomic)PaymentView *paymentView;//支付方式
@property (strong, nonatomic)PayTypeMode *payTypeMode;
@property (strong, nonatomic) PopupPawView *popupPaw;
@property (strong, nonatomic) PopupCodeview *popupCode;
@property (copy, nonatomic) NSString *serialNumber;
@property (copy, nonatomic) NSString *orderId;

@property (assign, nonatomic) double totlePrice;

@property (copy, nonatomic) NSString *payType;
@property (strong, nonatomic) NSMutableArray *overdueArr;

@end

@implementation RefundViewController

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
    _isBianJi = NO;
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    [self addItem:nitem_right btnTitleArr:@[@"批量",@"1",@"ask"]];
    self.playBtn.hidden = NO;
    self.lable.text = @"逾期还款";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    [_myTableView registerNib:[UINib nibWithNibName:@"RefundCell" bundle:nil] forCellReuseIdentifier:@"RefundCell"];

}

- (void)request_Api {
    _dataArray = [[NSMutableArray alloc] init];
    _selectedArray = [[NSMutableArray alloc] init];
    [self countPrice];
    NSDictionary *dic = @{@"iface":@"DMHY500014",@"userId":[BusinessLogic uuid]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        _mode = [HuanKuanMode mj_objectWithKeyValues:responseObj];
        [_dataArray addObjectsFromArray:_mode.overdueRepayments];
        [_myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

- (IBAction)allXuanBtnClick:(UIButton *)sender {
    
    _allXuanBtn.selected = !_allXuanBtn.selected;
    
    //点击全选时,把之前已选择的全部删除
    for (Overduerepayments *model in self.selectedArray) {
        model.select = NO;
    }
    
    [self.selectedArray removeAllObjects];
    
    if (_allXuanBtn.selected) {
        
        for (Overduerepayments *model in self.dataArray) {
            model.select = YES;
            [self.selectedArray addObject:model];
        }
    }
    
    
    
    
    [_myTableView reloadData];
    [self countPrice];
    
}
- (void)showRightView:(UIButton *)btn {
    
    if (btn.tag == 2) {
        //问题
        HelpCenterController *controller = [[HelpCenterController alloc] initWithNibName:@"HelpCenterController" bundle:nil];
        controller.childrenType = @"3";
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (btn.tag == 0) {
        NSLog(@"点击了编辑");
        _isBianJi = !_isBianJi;
        [_myTableView reloadData];
    }
    
}
- (IBAction)huanKuanBtnClick:(UIButton *)sender {
    if (_totlePrice <= 0) {
        [LCProgressHUD showMessage:@"请选择还款期数"];
    } else {
        _paymentView = [PaymentView new];
        _paymentView.delegate =self;
        [self request_ChannelApi];
    
    }
    
}

- (void)request_ChannelApi {
    NSDictionary *dic = @{@"iface":@"DMHY200010",@"userId":[BusinessLogic uuid],@"channel":@"0",@"payAmount":[NSString stringWithFormat:@"%.2f",_totlePrice]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        _payTypeMode = [PayTypeMode mj_objectWithKeyValues:responseObj];
        _paymentView.mode = _payTypeMode;
        _paymentView.titleLable.text = [NSString stringWithFormat:@"逾期还款"];
        _paymentView.moneyLable.text = [NSString stringWithFormat:@"%.2f",_totlePrice];
        NSLog(@"%@",self.totlePriceLabel.text);
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
        
        [self whatPay:_payType];
        
                
    }
}

- (void)popupPaw:(NSString *)paw{//输入代理
    [self verifyPayPaw:paw];
    
}

- (void)verifyPayPaw:(NSString *)paw {
    [MBProgressHUD showHUDAddedTo:_popupPaw animated:YES];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_overdueArr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonstring = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"iface":@"DMHY500015",@"userId":[BusinessLogic uuid],@"pepaymentTotalAmount":[NSString stringWithFormat:@"%.2f",_totlePrice],@"payType":_payType,@"tradePwd":paw,@"overdueRecords":jsonstring};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:_popupPaw animated:YES];
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            
            _popupPaw.errorLable.hidden = YES;
           
            [_popupPaw CloseAnimationFunction];
          
            SuccessViewController *successVC = [[SuccessViewController alloc] initWithNibName:@"SuccessViewController" bundle:nil];
            successVC.money =@"还款成功";
            [self.navigationController pushViewController:successVC animated:YES];
        }else {
            
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
        
        _popupPaw = [PopupPawView new];
        _popupPaw.delegate = self;
        [_popupPaw startAnimationFunction];
    }
}


- (void)request_Recharge {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400025",@"userId":[BusinessLogic uuid],@"rechargeAmount":[NSString stringWithFormat:@"%.2f",_totlePrice]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            _serialNumber = responseObj[@"serialNumber"];
            _orderId = responseObj[@"orderId"];
            [self request_CodeApi:responseObj[@"serialNumber"] orderId:responseObj[@"orderId"]];
        } else {
           [LCProgressHUD showMessage:responseObj[@"resmsg"]];
            
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [LCProgressHUD showMessage:@"请求超时"];
    }];
    
}

- (void)request_CodeApi:(NSString *)serialNumber orderId:(NSString *)orderId {
    
    NSDictionary *dic = @{@"iface":@"DMHY400012",@"userId":[BusinessLogic uuid],@"phone":[BusinessLogic getPhoneNo],@"nextTxnSubType":@"04",@"txnSubType":@"05",@"baoBindId":_payTypeMode.bankInfo.bindId,@"txnAmt":[NSString stringWithFormat:@"%.2f",_totlePrice],@"orderId":orderId,@"serialNumber":serialNumber};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableString *str = [[NSMutableString alloc] initWithString:[BusinessLogic getPhoneNo]];
        NSRange range = {0,7};
        [str replaceCharactersInRange:range withString:@"****"];
        _popupCode = [PopupCodeview new];
        _popupCode.delegate = self;
        _popupCode.phone = str;
        
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            [_popupCode startAnimationFunction];
        } else {
            [LCProgressHUD showMessage:responseObj[@"resmsg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
         [LCProgressHUD showMessage:@"请求超时"];
        
    }];
    
    
}

- (void)codeDelegate {
   [MBProgressHUD showHUDAddedTo:self.popupCode animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400012",@"userId":[BusinessLogic uuid],@"phone":[BusinessLogic getPhoneNo],@"nextTxnSubType":@"04",@"txnSubType":@"05",@"baoBindId":_payTypeMode.bankInfo.bindId,@"txnAmt":[NSString stringWithFormat:@"%.2f",_totlePrice],@"orderId":_orderId,@"serialNumber":_serialNumber};
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
        self.popupCode.confirmBtn.enabled = NO;
        [MBProgressHUD showHUDAddedTo:self.popupCode animated:YES];
        NSDictionary *dic = @{@"iface":@"DMHY400041",@"userId":[BusinessLogic uuid],@"orderId":_orderId,@"rechargeAmount":[NSString stringWithFormat:@"%.2f",_totlePrice],@"bankId":[NSString stringWithFormat:@"%li",(long)_payTypeMode.bankInfo.bankId],@"txnSubType":@"04",@"validCode":self.popupCode.phoneText.text,@"serialNumber":_serialNumber};
        [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
            [MBProgressHUD hideHUDForView:self.popupCode animated:YES];
            self.popupCode.confirmBtn.enabled = YES;
            if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
                [self.popupCode CloseAnimationFunction];
                self.popupCode.errorLable.hidden = YES;
                _popupPaw = [PopupPawView new];
                _popupPaw.delegate = self;
                [_popupPaw startAnimationFunction];
                
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


- (void)foundPawDelegate{//忘记密码代理
    ForgetLoginController *forLVC = [[ForgetLoginController alloc] initWithNibName:@"ForgetLoginController" bundle:nil];
    forLVC.type = @"3";
    [self.navigationController pushViewController:forLVC animated:YES];
}

#pragma tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _mode.overdueRepayments.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 108;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundCell"];
    if (_isBianJi) {
        cell.myScrollView.contentOffset = CGPointMake(80, 0);
    } else {
        cell.myScrollView.contentOffset = CGPointMake(0, 0);
    }
    Overduerepayments *overduerepayments = _dataArray[indexPath.section];
    
    [cell numberAddWithBlock:^(NSInteger number) {

        overduerepayments.number = number;
        
        [self.dataArray replaceObjectAtIndex:indexPath.section withObject:overduerepayments];
        if ([self.selectedArray containsObject:overduerepayments]) {
            [self.selectedArray removeObject:overduerepayments];
            [self.selectedArray addObject:overduerepayments];
            [self countPrice];
        }
    }];
    
    [cell numberCutWithBlock:^(NSInteger number) {
        
        
        overduerepayments.number = number;
        
        [self.dataArray replaceObjectAtIndex:indexPath.section withObject:overduerepayments];
        
        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([self.selectedArray containsObject:overduerepayments]) {
            [self.selectedArray removeObject:overduerepayments];
            [self.selectedArray addObject:overduerepayments];
            [self countPrice];
        }
    }];
    
    [cell cellSelectedWithBlock:^(BOOL select) {
        
        overduerepayments.select = select;
        if (select) {
            [self.selectedArray addObject:overduerepayments];
        } else {
            [self.selectedArray removeObject:overduerepayments];
        }
        
        if (self.selectedArray.count == self.dataArray.count) {
            _allXuanBtn.selected = YES;
        } else {
            _allXuanBtn.selected = NO;
        }
        
        [self countPrice];
    }];
    
    cell.mode = overduerepayments;
    return cell;
    
}

-(void)countPrice {
    _totlePrice = 0.0;
    _overdueArr = [[NSMutableArray alloc] init];
    for (Overduerepayments *model in self.selectedArray) {
        
        double price = model.principalInterest + model.monthManage;
       
        _totlePrice += price*model.number+model.overdueRevenue+model.overdueFine;
        
        NSDictionary *dic = @{@"bId":[NSString stringWithFormat:@"%li",model.bId],@"payPeriods":[NSString stringWithFormat:@"%li",model.number]};
        [_overdueArr addObject:dic];
        
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",_totlePrice];
    
   
    self.totlePriceLabel.text = string;
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
