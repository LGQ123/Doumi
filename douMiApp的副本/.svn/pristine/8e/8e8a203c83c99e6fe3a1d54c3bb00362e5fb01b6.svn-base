//
//  PaymentView.m
//  douMiApp
//
//  Created by ydz on 2017/1/14.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "PaymentView.h"
#import "PaymentCell.h"
#import "Masonry.h"
#import "PayTypeMode.h"
@interface PaymentView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView *myTableView;
@property (strong, nonatomic)UIButton *close;
@property (strong, nonatomic)UIButton *affirm;

@property (nonatomic, strong) UITapGestureRecognizer *ges;
@property (nonatomic, strong) UIView *backView;

@property (strong, nonatomic) NSMutableArray <UnifyMode *>*dataArr;
@property (strong, nonatomic) NSMutableArray <UnifyMode *>*sortArrY;
@property (strong, nonatomic) NSMutableArray <UnifyMode *>*sortArrN;
@property (weak, nonatomic) PaymentCell *oldCell;
@end


@implementation PaymentView
- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [window addSubview:self];
        UIView *blackView1 = [UIView new];
        blackView1.backgroundColor = RGB16(0x000000);
        blackView1.alpha = 0.6f;
        blackView1.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubview:blackView1];
        self.ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestureCloseSelectViewAnimation:)];
        [self.window bringSubviewToFront:self];
        [blackView1 addGestureRecognizer:self.ges];
        self.backView = [UIView new];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 450);
        //self.backView.center = CGPointMake(nc_ScreenWidth/2.0f, nc_ScreenHeight+130);
        [self addSubview:self.backView];
        [self creadtionSub];
        self.hidden = YES;
        _dataArr = [[NSMutableArray alloc] init];
        _sortArrY = [[NSMutableArray alloc] init];
        _sortArrN = [[NSMutableArray alloc] init];
    }
    
    return self;
    
}

- (void)creadtionSub {
    UIView *sub = self.backView;
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-60, 40)];
    _titleLable.textColor = RGBA(40, 40, 40, 1);
    _titleLable.font = [UIFont systemFontOfSize:16];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [sub addSubview:_titleLable];
    
    _close = [UIButton buttonWithType:UIButtonTypeCustom];
    _close.frame = CGRectMake(SCREEN_WIDTH-30, 13, 13, 13);
    [_close setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    [sub addSubview:_close];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, 3)];
    line1.backgroundColor = RGBA(60, 60, 60, 1);
    [sub addSubview:line1];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 240) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [sub addSubview:_myTableView];
    [_myTableView registerNib:[UINib nibWithNibName:@"PaymentCell" bundle:nil] forCellReuseIdentifier:@"PaymentCell"];
    
    
    _moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(0, POINTY(_myTableView)+HEIGTH(_myTableView)+25, SCREEN_WIDTH, 13)];
    _moneyLable.textColor = RGBA(8, 145, 232, 1);
    _moneyLable.textAlignment = NSTextAlignmentCenter;
    _moneyLable.font = [UIFont systemFontOfSize:16];
    [sub addSubview:_moneyLable];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(135, POINTY(_moneyLable)+HEIGTH(_moneyLable)+10, SCREEN_WIDTH-270, 3)];
    line2.backgroundColor = RGBA(60, 60, 60, 0.5);
    [sub addSubview:line2];
    
    UILabel *shiji  = [[UILabel alloc] initWithFrame:CGRectMake(0, POINTY(line2)+HEIGTH(line2)+10, SCREEN_WIDTH, 12)];
    shiji.textColor = RGBA(40, 40, 40, 1);
    shiji.text = @"实际支付";
    shiji.font = [UIFont systemFontOfSize:12];
    shiji.textAlignment = NSTextAlignmentCenter;
    [sub addSubview:shiji];
    
    _affirm = [UIButton buttonWithType:UIButtonTypeCustom];
    _affirm.frame = CGRectMake(42, POINTY(shiji)+HEIGTH(shiji)+25, SCREEN_WIDTH-84, 40);
    [_affirm setTitle:@"确认"forState:UIControlStateNormal];
    _affirm.titleLabel.font = [UIFont systemFontOfSize:12];
    [_affirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_affirm setBackgroundColor:RGBA(60, 60, 60, 1)];
    [_affirm addTarget:self action:@selector(affirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [sub addSubview:_affirm];
}


- (void)startAnimationFunction{
    UIView *AnView = self.backView;
    self.hidden = NO;
    CGRect rect = AnView.frame;
    rect.origin.y = SCREEN_HEIGHT-450;
    [self.window bringSubviewToFront:self];
    [UIView animateWithDuration:0.4f animations:^{
        
        AnView.frame = rect;
    }];
    
    
    
}
- (void)CloseAnimationFunction{
    
    UIView *AnView = self.backView;
    CGRect rect = AnView.frame;
    rect.origin.y = SCREEN_HEIGHT;
    [UIView animateWithDuration:0.4f animations:^{
        AnView.frame = rect;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}

- (void)closeClick:(UIButton *)sender {//关闭
    [self CloseAnimationFunction];

}

- (void)affirmClick:(UIButton *)sender {//确认
    
    if ([self.delegate respondsToSelector:@selector(paymentAffirmDelegate)]) {
        [self.delegate paymentAffirmDelegate];
    }
    
    [self CloseAnimationFunction];
}

- (void)GestureCloseSelectViewAnimation:(UIGestureRecognizer *)ges{
    
    [self CloseAnimationFunction];
}

- (void)dealloc{
    
    self.ges = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sortArrN.count+_sortArrY.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentCell"];
    
    if (indexPath.row < _sortArrY.count) {
        UnifyMode *mode = _sortArrY[indexPath.row];
        cell.mode = mode;
        if (mode.type == 3) {
           cell.PayC_image.image = [UIImage imageNamed:@"银行卡"];
        } else {
            cell.PayC_image.image = [UIImage imageNamed:@"钱币"];
            if (mode.type == 0) {//判断如果是密分期
                    cell.Pay_YQ.hidden = ![_mode.creditInfo.overdueStatus isEqualToString:@"1"];
            }
        }
        if (indexPath.row == 0) {
            cell.Pay_gou.hidden = NO;
            _oldCell = cell;
            if ([self.delegate respondsToSelector:@selector(selectPayment:)]) {
                [self.delegate selectPayment:cell.payType];
            }
        } else {
            cell.Pay_gou.hidden = YES;
        }
        
    } else {
       
        if (_sortArrY.count == 0) {
            
            UnifyMode *mode = _sortArrN[indexPath.row];
            cell.mode = mode;
            if (mode.type == 3) {
                cell.PayC_image.image = [UIImage imageNamed:@"银行卡"];
            } else {
                cell.PayC_image.image = [UIImage imageNamed:@"钱币"];
                if (mode.type == 0) {//判断如果是密分期
                    cell.Pay_YQ.hidden = ![_mode.creditInfo.overdueStatus isEqualToString:@"1"];
                }
            }
            
        } else {
            UnifyMode *mode = _sortArrN[indexPath.row-_sortArrY.count];
            cell.mode = mode;
            if (mode.type == 3) {
                cell.PayC_image.image = [UIImage imageNamed:@"银行卡"];
            } else {
                cell.PayC_image.image = [UIImage imageNamed:@"钱币"];
                if (mode.type == 0) {//判断如果是密分期
                    cell.Pay_YQ.hidden = ![_mode.creditInfo.overdueStatus isEqualToString:@"1"];
                }
            }
            
        }
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PaymentCell *cell = (PaymentCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.Pay_cover.hidden) {
        _oldCell.Pay_gou.hidden = YES;
        cell.Pay_gou.hidden = NO;
        if ([self.delegate respondsToSelector:@selector(selectPayment:)]) {
            [self.delegate selectPayment:cell.payType];
        }
    }
    _oldCell = cell;
}

- (void)setMode:(PayTypeMode *)mode {
    for (int i = 0; i<4; i++) {
        UnifyMode *unifyMode = [[UnifyMode alloc] init];
        if (i == 0) {
           unifyMode.title = @"密分期(推荐)";
           unifyMode.subTitle = [NSString stringWithFormat:@"%li",(long)mode.creditInfo.creditAmount];
            unifyMode.status = mode.creditInfo.status;
        }
        if (i == 1) {
            unifyMode.title = @"余额";
            unifyMode.subTitle = [NSString stringWithFormat:@"%li",(long)mode.accountInfo.usalbeAmount];
            unifyMode.status = mode.accountInfo.status;
        }
        if (i == 2) {
            unifyMode.title = @"蜜豆荚";
            unifyMode.subTitle = [NSString stringWithFormat:@"%li",(long)mode.podsInfo.redeemAmount];
            unifyMode.status = mode.podsInfo.status;
        }
        if (i == 3) {
            unifyMode.title = [NSString stringWithFormat:@"银行卡:%@",mode.bankInfo.bankName];
            unifyMode.subTitle = [NSString stringWithFormat:@"%@",mode.bankInfo.bankCard];
            unifyMode.status = mode.bankInfo.status;
        }
        unifyMode.type = i;
        [_dataArr addObject:unifyMode];
    }
    
    [self sortArr];
    
}

- (void)sortArr {//排序
    for (UnifyMode *mode in _dataArr) {
        if ([mode.status isEqualToString:@"1"]) {
            [_sortArrY addObject:mode];
        } else {
            [_sortArrN addObject:mode];
        }
    }
    NSLog(@"_sortArrN=%@ _sortArrY=%@",_sortArrN,_sortArrY);
    [_myTableView reloadData];
}


@end

@implementation UnifyMode

@end
