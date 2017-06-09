//
//  brushLiRecordCell.m
//  douMiApp
//
//  Created by ydz on 2017/1/11.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "brushLiRecordCell.h"
#import "ShuaLiMode.h"
@implementation brushLiRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.mingXiBtn.layer.borderWidth = 1;
    self.mingXiBtn.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
    self.XieYiBtn.layer.borderWidth = 1;
    self.XieYiBtn.layer.borderColor = [RGBA(60, 60, 60, 1) CGColor];
}

- (void)setMode:(Giftsinfo *)mode {
    _titleLable.text =[NSString stringWithFormat:@"%@(%@)", mode.borrowTitle,mode.currentPeriod];
    _timeLable.text = mode.term;
    _MFQMoney.text = [NSString stringWithFormat:@"%li元",(long)mode.borrowAmount];
    _yuQiLable.text = [NSString stringWithFormat:@"%li",(long)mode.overdueAmount];
    if (mode.status == 2) {
        _userImage.hidden = NO;
        _stateLable.hidden = YES;
        _refundBtn.hidden = YES;
        _yuQiLable.hidden = YES;
        _yuQiTitle.hidden = YES;
        _useBackView.hidden = NO;
    } else if (mode.status == 1) {
        _userImage.hidden = YES;
        _stateLable.hidden = NO;
        _stateLable.text = @"使用中";
        _stateLable.textColor = RGBA(8, 145, 232, 1);
        _refundBtn.hidden = YES;
        _yuQiLable.hidden = YES;
        _yuQiTitle.hidden = YES;
        _useBackView.hidden = YES;
    } else {
        _userImage.hidden = YES;
        _stateLable.hidden = NO;
        _stateLable.text = @"逾期待还";
        _stateLable.textColor = RGBA(255, 42, 80, 1);
        _refundBtn.hidden = NO;
        _yuQiLable.hidden = NO;
        _yuQiTitle.hidden = NO;
        _useBackView.hidden = YES;
    }
    _bId = [NSString stringWithFormat:@"%li",(long)mode.bId];
}

- (IBAction)refundBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(refundDelegate:)]) {
        [self.delegate refundDelegate:_bId];
    }
}

- (IBAction)mingXiBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mingXiDelegate:)]) {
        [self.delegate mingXiDelegate:_bId];
    }
}
- (IBAction)xieYiBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(xieYiDelegate)]) {
        [self.delegate xieYiDelegate];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
