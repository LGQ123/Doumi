//
//  MXBelowCell.m
//  douMiApp
//
//  Created by ydz on 2017/1/13.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "MXBelowCell.h"
#import "MingXiMode.h"
@implementation MXBelowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _timeLable.layer.borderWidth = 1;
    _timeLable.layer.borderColor = [RGBA(40, 40, 40, 1) CGColor];
}

- (void)setMode:(RepaymentDetails *)mode {
    
    _timeLable.text = mode.refundDate;
    _qiHao.text = [NSString stringWithFormat:@"[%@]",mode.currentPeriod];
    _huanKuanJE.text = [NSString stringWithFormat:@"还款金额%li元",(long)mode.principalInterest];
    _BXLable.text = [NSString stringWithFormat:@"(含：%li本金+%li利息)",(long)mode.principal,(long)mode.interest];
    if (mode.status == 0) {
        _typeLable.textColor = RGBA(255, 42, 80, 1);
        _typeLable.text = @"逾期待还";
        _coverView.hidden = YES;
    } else if (mode.status == 1) {
        _typeLable.textColor = RGBA(255, 42, 80, 1);
        _typeLable.text = @"待还";
        _coverView.hidden = YES;
    } else {
        _typeLable.textColor = RGBA(40, 40, 40, 1);
        _typeLable.text = @"已还";
        _coverView.hidden = NO;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
