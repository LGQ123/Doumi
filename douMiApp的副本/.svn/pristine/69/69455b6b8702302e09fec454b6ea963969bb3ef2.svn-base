//
//  MiFenQiCell.m
//  douMiApp
//
//  Created by ydz on 2017/1/10.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "MiFenQiCell.h"
#import "DM_CircleView.h"
#import "DMMeXinModel.h"
@implementation MiFenQiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _cricleView = [[DM_CircleView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    [_myImageView addSubview:_cricleView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(brushLiRecordTap:)];
    [_brushLi addGestureRecognizer:tap];
    
}
- (IBAction)shuaLiClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(brushLiDelegate)]) {
        [self.delegate brushLiDelegate];
    }
}
- (IBAction)huanKuanBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(refundDelegate)]) {
        [self.delegate refundDelegate];
    }
}

- (void)brushLiRecordTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(brushLiRecordDelegate)]) {
        [self.delegate brushLiRecordDelegate];
    }
    
}

- (void)setMode:(DMMeXinModel *)mode {
    _usableMoney.text = mode.creditInfo.leftAmount;
//    if ([mode.creditInfo.creditAmount isEqualToString:mode.creditInfo.leftAmount]) {
//        _cricleView.hidden = YES;
//        _myImageView.image = [UIImage imageNamed:@"满额"];
//    } else {
        _cricleView.hidden = NO;
         _myImageView.image = [UIImage imageNamed:@"凹槽"];
        [_cricleView setPercent:([mode.creditInfo.leftAmount floatValue]/[mode.creditInfo.creditAmount floatValue])*100 animated:YES];
//    }
    _allLimit.text = [NSString stringWithFormat:@"我的总额度:%@元",mode.creditInfo.creditAmount];
    if ([mode.creditInfo.overdueStatus isEqualToString:@"0"]) {
        [_brushLiBtn setBackgroundColor:RGBA(60, 60, 60, 1)];
        _brushLiBtn.enabled = YES;
        _allLimitLine.hidden = YES;
        _refundBtn.hidden = YES;
        _delayMoney.hidden = YES;
    } else {
        [_brushLiBtn setBackgroundColor:RGBA(160, 160, 160, 1)];
        _brushLiBtn.enabled = NO;
        _allLimitLine.hidden = NO;
        _refundBtn.hidden = NO;
        _delayMoney.hidden = NO;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
