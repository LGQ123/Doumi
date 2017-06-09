//
//  DMMeDouJiaViewController.m
//  douMiApp
//
//  Created by edz on 2017/1/10.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "DMMeDouJiaViewController.h"
#import "DMMeDouJiaDetailViewController.h"
#import "DMMeDouJiaModel.h"
#import "DMPayForGeneralModel.h"
#import "DMPayForGeneralViewController.h"
#import "HelpCenterController.h"


#define inoutBtnH 60
#define margin (SCREEN_HEIGHT-300-inoutBtnH-64)/12
#define curveViewH 195
#define labelRedge (SCREEN_WIDTH-90)/6
#define percentLabH 21

@interface DMMeDouJiaViewController ()

@property (nonatomic, strong) UILabel *moneyTitle; // 昨日收益金额
@property (nonatomic, strong) UILabel *balanceLab; // 蜜豆荚余额
@property (nonatomic, strong) UILabel *incomeLab; // 累计收益(蜜豆)
@property (nonatomic, strong) NSString *balance; // 账户余额
@property (nonatomic, strong) DMMeDouJiaModel *model;

@end

@implementation DMMeDouJiaViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.hidesBackButton = YES;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
    [self requestMeDouJiaData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick event:@"MiDouNum"];
    // 设置页面背景渐变色
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:bgView];
    
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[(__bridge id)RGBA(255, 42, 80, 1).CGColor, (__bridge id)RGBA(8, 145, 232, 1).CGColor];
    layer.startPoint = CGPointMake(0.3, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    //    layer.locations = @[@(0.5f), @(1.0f)]; // 设置颜色分割点（范围：0-1）
    layer.frame = bgView.bounds;
    [bgView.layer addSublayer:layer];
    
    
    [self addItem:nitem_left btnTitleArr:@[@"BackW"]];
    [self addItem:nitem_right btnTitleArr:@[@"白线问号"]]; 
    self.lable.text = @"蜜豆荚";
    
    
    UIButton *inButton = [self getButtonWithTitle:@"转入"];
    inButton.tag = 1;
    [self.view addSubview:inButton];
    [inButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, inoutBtnH));
    }];
    
    UIButton *outButton = [self getButtonWithTitle:@"转出"];
    outButton.tag = 2;
    [self.view addSubview:outButton];
    [outButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, inoutBtnH));
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = RGBA(255, 255, 255, 1);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(inButton.mas_centerY);
    }];
    
    
    UILabel *title = [self getLabelWithText:@"昨日收益(元)" andFont:DMFont(16)];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(95, 20));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(104);
    }];
    
    _moneyTitle = [self getLabelWithText:@"0.00" andFont:DMFontBold(100)]; /////////////
    [self.view addSubview:_moneyTitle];
    [_moneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 76));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(title.mas_bottom).offset(margin);
    }];
    
    UIButton *lookBtn = [[UIButton alloc] init];
    lookBtn.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    lookBtn.titleLabel.font = DMFont(12);
    lookBtn.layer.borderWidth = 0.5;
    lookBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [lookBtn setTitle:@"查看明细" forState:UIControlStateNormal];
    [lookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lookBtn setImage:[UIImage imageNamed:@"白箭头"] forState:UIControlStateNormal]; // 9*15
    [lookBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -9, 0, 9)];
    [lookBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 55, 0, -55)];
    [lookBtn addTarget:self action:@selector(lookInfoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lookBtn];
    [lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(101, 31));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_moneyTitle.mas_bottom).offset(margin);
    }];
    
    _balanceLab = [self getLabelWithText:@"0.00 \n 蜜豆荚余额(元)" andFont:DMFont(12)]; /////////////////
    _balanceLab.numberOfLines = 0;
    [self.view addSubview:_balanceLab];
    [_balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 33));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(lookBtn.mas_bottom).offset(margin*2);
    }];
    
    
    _incomeLab = [self getLabelWithText:@"0 \n 累计收益(蜜豆)" andFont:DMFont(12)];
    _incomeLab.numberOfLines = 0;
    [self.view addSubview:_incomeLab];
    [_incomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 33));
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(_balanceLab.mas_top);
    }];
    
//    [self drawLine]; // 绘制曲线图

}


- (void)requestMeDouJiaData {
    
    __weak __typeof(self) weakSelf = self;

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY600001" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        DMMeDouJiaModel *model = [DMMeDouJiaModel mj_objectWithKeyValues:responseObj];
        self.model = model;
        if ([model.rescode isEqualToString:@"0000"]) {
            weakSelf.moneyTitle.text = model.earningsYesterday;
            weakSelf.balanceLab.text = [NSString stringWithFormat:@"%@ \n 蜜豆荚余额(元)", model.newerSubscription];
            weakSelf.incomeLab.text = [NSString stringWithFormat:@"%@ \n 累计收益(蜜豆)", model.accumulatedEarnings];
            [weakSelf drawLineWithRateArray:model.listMap]; // 绘制曲线图
            
            if (!isEmpty(model.newerSubscription)) {
                NSMutableAttributedString *balaceAttr = [[NSMutableAttributedString alloc] initWithString:weakSelf.balanceLab.text];
                [balaceAttr addAttribute:NSFontAttributeName value:DMFontBold(14) range:[weakSelf.balanceLab.text rangeOfString:model.newerSubscription]];
                weakSelf.balanceLab.attributedText = balaceAttr;
            }
            
            if (!isEmpty(model.accumulatedEarnings)) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:weakSelf.incomeLab.text];
                [attStr addAttribute:NSFontAttributeName value:DMFontBold(14) range:[weakSelf.incomeLab.text rangeOfString:model.accumulatedEarnings]];
                weakSelf.incomeLab.attributedText = attStr;
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


// 曲线图
- (void)drawLineWithRateArray:(NSArray *)dataListArray {
    float y = 0;
    if (SCREEN_WIDTH > 320) {
        y = _balanceLab.mj_y+_balanceLab.mj_h+60;
    } else { // iphone5 iphone5s
        y = SCREEN_HEIGHT-inoutBtnH-curveViewH;
    }
    UIView *curveView = [[UIView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, curveViewH)];
    curveView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:curveView];
    
    float redge = (SCREEN_WIDTH-90)/6;
    int onePercentH = 7; // 一个百分比的高度
    
    
    NSMutableArray *dateArray = [NSMutableArray array];
    NSMutableArray *rateArray = [NSMutableArray array];
    float sumPercent = 0.00;
    
    if (dataListArray && dataListArray.count > 0) {
        for (int i = 0; i < dataListArray.count; i ++) {
            
            DMMeDouJiaListMapModel *model = [dataListArray dm_objectAtIndex:i];
            [dateArray dm_addObject:model.interestDate];
            [rateArray dm_addObject:model.interest];
            
            sumPercent = sumPercent+[model.interest floatValue];
        }
    }
    
    
    // 第一、UIBezierPath绘制线段
    UIBezierPath *path = [UIBezierPath bezierPath];
    //7个点
    CGPoint point1 = CGPointMake(45, 105-([[rateArray dm_objectAtIndex:0] floatValue])*onePercentH);
    CGPoint point2 = CGPointMake(45+redge, 105-([[rateArray dm_objectAtIndex:1] floatValue])*onePercentH);
    CGPoint point3 = CGPointMake(45+redge*2, 105-([[rateArray dm_objectAtIndex:2] floatValue])*onePercentH);
    CGPoint point4 = CGPointMake(45+redge*3, 105-([[rateArray dm_objectAtIndex:3] floatValue])*onePercentH);
    CGPoint point5 = CGPointMake(45+redge*4, 105-([[rateArray dm_objectAtIndex:4] floatValue])*onePercentH);
    CGPoint point6 = CGPointMake(45+redge*5, 105-([[rateArray dm_objectAtIndex:5] floatValue])*onePercentH);
    CGPoint point7 = CGPointMake(45+redge*6, 105-([[rateArray dm_objectAtIndex:6] floatValue])*onePercentH);
    
    NSArray *arr = [NSArray arrayWithObjects: [NSValue valueWithCGPoint:point1],
                                              [NSValue valueWithCGPoint:point2],
                                              [NSValue valueWithCGPoint:point3],
                                              [NSValue valueWithCGPoint:point4],
                                              [NSValue valueWithCGPoint:point5],
                                              [NSValue valueWithCGPoint:point6],
                                              [NSValue valueWithCGPoint:point7], nil];
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, arr.count)];
    
    //第二、绘制
    [arr enumerateObjectsAtIndexes:set options:0 usingBlock:^(NSValue *pointValue, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point = [pointValue CGPointValue];
        [path addLineToPoint:point];
        
        CGRect rect;
        rect.origin.x = point.x - 1.5;
        rect.origin.y = point.y - 1.5;
        rect.size.width = 4;
        rect.size.height = 4;
        
        UIBezierPath *arc = [UIBezierPath bezierPathWithOvalInRect:rect];
        [path appendPath:arc];
    }];
    
    //第三、UIBezierPath和CAShapeLayer关联
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH-90, 105);
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.lineWidth = 2;
    lineLayer.path = path.CGPath;
    lineLayer.strokeColor = [UIColor whiteColor].CGColor;
    [curveView.layer addSublayer:lineLayer];

    
    UIImageView *lineBottom = [[UIImageView alloc] initWithFrame:CGRectMake(45, 105, SCREEN_WIDTH-90, 1)];
    lineBottom.backgroundColor = [UIColor whiteColor];
    [curveView addSubview:lineBottom];
    
    for (int i = 0; i < dateArray.count; i ++) {
        UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectMake(45+labelRedge*i-5, 110, labelRedge, 13)];
        dateLab.textColor = [UIColor whiteColor];
        if (i == dateArray.count-1) {
            dateLab.font = DMFontBold(14);
        } else {
            dateLab.font = DMFont(10);
        }
        dateLab.text = [dateArray dm_objectAtIndex:i];
        [curveView addSubview:dateLab];
    }
    
    NSMutableArray *percentArray = [NSMutableArray arrayWithObjects:@"15%", @"12%", @"9%", @"6%", @"3%", nil];
    for (int j = 0; j < percentArray.count; j ++) {
        UILabel *percentLab = [[UILabel alloc] initWithFrame:CGRectMake(27, 21*j-4, 18, 8)];
        percentLab.font = DMFont(8);
        percentLab.text = [percentArray dm_objectAtIndex:j];
        percentLab.textColor = [UIColor whiteColor];
        [curveView addSubview:percentLab];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(45, 21*j, SCREEN_WIDTH-90, 0.3)];
        line.backgroundColor = [UIColor clearColor];
        line.image = [UIImage imageNamed:@"半透白虚线"];
        [curveView addSubview:line];
    }
    
    
    UILabel *infoLab = [self getLabelWithText:[NSString stringWithFormat:@"七日年化：%.2f%@", sumPercent/7, @"%"] andFont:DMFont(12)];
    infoLab.frame = CGRectMake(45, 144, SCREEN_WIDTH-90, 14);
    [curveView addSubview:infoLab];
}


- (void)inOutButtonClick:(UIButton *)button {
    if (button.isSelected) {
        return;
    }
    
    if (button.tag == 1) { // 转入
        __weak __typeof(self) weakSelf = self;

        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic dm_setObject:@"DMHY400023" forKey:@"iface"];
        [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
        
        [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
            DMPayForGeneralModel *model = [DMPayForGeneralModel mj_objectWithKeyValues:responseObj];
            if ([model.rescode isEqualToString:@"0000"]) {
                weakSelf.balance = model.usalbeAmount;

                // 获取到账户余额
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"从余额转入" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                UITextField *txtName = [alert textFieldAtIndex:0];
                txtName.keyboardType = UIKeyboardTypeNumberPad;
                if ([model.usalbeAmount longLongValue] > (10000-[_balanceLab.text longLongValue])) {
                    txtName.placeholder = [NSString stringWithFormat:@"还可从余额转入%lld元", 10000-[_balanceLab.text longLongValue]];
                } else {
                    txtName.placeholder = [NSString stringWithFormat:@"还可从余额转入%@元", model.usalbeAmount];
                }
                txtName.delegate = weakSelf;
                [txtName addTarget:weakSelf action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
                alert.tag = 1;
                [alert show];
            }
        } failure:^(NSError *error) {
            
        }];
        
    } else if (button.tag == 2) { // 转出
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"从蜜豆荚转出" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alert textFieldAtIndex:0];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.delegate = self;
        textField.placeholder = [NSString stringWithFormat:@"还可从蜜豆荚转出%@元", _model.newerSubscription];
        [textField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
        alert.tag = 2;
        [alert show];
    }
}


// 点击帮助按钮
- (void)showRightView:(UIButton *)btn {
    HelpCenterController *controller = [[HelpCenterController alloc] initWithNibName:@"HelpCenterController" bundle:nil];
    controller.childrenType = @"2";
    [self.navigationController pushViewController:controller animated:YES];
}


// 查看明细
- (void)lookInfoButtonClick {
    DMMeDouJiaDetailViewController *controller = [[DMMeDouJiaDetailViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)textFieldTextChange:(UITextField *)textField {
    
    if (textField.text.length > 5) {
        textField.text = [textField.text substringToIndex:5];
    }
}



- (UIButton *)getButtonWithTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    button.titleLabel.font = DMFont(20);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(inOutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (UILabel *)getLabelWithText:(NSString *)text andFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    __weak __typeof(self) weakSelf = self;
    
    if (buttonIndex == 1) {
        
        UITextField *field = [alertView textFieldAtIndex:0];
        if ([field.text floatValue] <= 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入大于0的数!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }
    
        if (alertView.tag == 1) {
            
            long maxMoney = 0;
            if ([_balance longLongValue] < (10000-[_balanceLab.text longLongValue])) {
                maxMoney = [_balance longLongValue];
            } else {
                maxMoney = 10000-[_balanceLab.text longLongValue];
            }
            
            if ([field.text longLongValue] > maxMoney) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"您最多还可以从余额转入%ld元!", maxMoney] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return;
            }
            
            DMPayForGeneralViewController *controller = [[DMPayForGeneralViewController alloc] initWithTitle:[NSString stringWithFormat:@"转入蜜豆荚%@元", field.text] andMoney:field.text andBalance:_balance];
            controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            controller.type = DMPayForTypeMeDouJiaRollIn;
            [weakSelf presentViewController:controller animated:YES completion:nil];
            
        } else if (alertView.tag == 2) {
            
            DMPayForGeneralViewController *controller = [[DMPayForGeneralViewController alloc] initWithTitle:[NSString stringWithFormat:@"从蜜豆荚转出%@元", field.text] andMoney:field.text andBalance:_model.newerSubscription];
            controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            controller.type = DMPayForTypeMeDouJiaRollOut;
            [weakSelf presentViewController:controller animated:YES completion:nil];
            
        }
    }
}


#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) {
        return YES;
    }
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //正则表达式
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    return [self isValid:checkStr withRegex:regex];
}


- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
