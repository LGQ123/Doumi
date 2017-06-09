//
//  DMMeDouJiaDetailCell.m
//  douMiApp
//
//  Created by edz on 2017/1/10.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "DMMeDouJiaDetailCell.h"


#define margin 14
#define arrowW 15
#define arrowH 15
#define cellHeight 61

@interface DMMeDouJiaDetailCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *rollInOutLab;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UILabel *balanceLab;
@property (nonatomic, strong) DMMeDouJiaDetailModel *model;
@property (nonatomic, strong) UIImageView *arrowImage;

@end

@implementation DMMeDouJiaDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *bgButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cellHeight)];
        bgButton.backgroundColor = [UIColor clearColor];
        [bgButton addTarget:self action:@selector(bgButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 60.5, SCREEN_WIDTH-margin, 0.5)];
        line.backgroundColor = RGBA(200, 200, 200, 1);
        [self addSubview:line];
        
        _arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-margin-arrowW, (cellHeight-arrowH)/2, arrowW, arrowH)];
        _arrowImage.image = [UIImage imageNamed:@"right2"];
        [self addSubview:_arrowImage];
        
        _titleLab = [self getLabelWithFrame:CGRectMake(margin, margin, SCREEN_WIDTH/2, 15) andTextColor:RGBA(61, 61, 61, 1) andFont:DMFontBold(12)];
        [self addSubview:_titleLab];
        
        _rollInOutLab = [self getLabelWithFrame:CGRectMake(_arrowImage.mj_x-10-100, _titleLab.mj_y, 100, _titleLab.mj_h) andTextColor:RGBA(8, 145, 232, 1) andFont:DMFontBold(16)];
        _rollInOutLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rollInOutLab];
        
        _dateLab = [self getLabelWithFrame:CGRectMake(margin, _titleLab.mj_y+_titleLab.mj_h+10, SCREEN_WIDTH/2, 12) andTextColor:RGBA(60, 60, 60, 1) andFont:DMFont(10)];
        [self addSubview:_dateLab];
        
//        _balanceLab = [self getLabelWithFrame:CGRectMake(_rollInOutLab.mj_x, _dateLab.mj_y, 100, 12) andTextColor:RGBA(60, 60, 60, 1) andFont:DMFont(10)];
//        _balanceLab.textAlignment = NSTextAlignmentRight;
//        [self addSubview:_balanceLab];
    }
    return self;
}


- (void)setItemWithModel:(DMMeDouJiaDetailModel *)model {
    _model = model;
    
    if ([model.type isEqualToString:@"402"]) { // 蜜豆荚入账(转入)
        
        _rollInOutLab.text = [NSString stringWithFormat:@"+%@", model.outlay];
        _rollInOutLab.textColor = RGBA(8, 145, 232, 1);
        _rollInOutLab.mj_y = (cellHeight-15)/2;
        _arrowImage.hidden = NO;
        _balanceLab.hidden = NO;
        _balanceLab.text = model.balance;

    } else if ([model.type isEqualToString:@"401"]) { //蜜豆荚出账(转出)
        
        _rollInOutLab.text = [NSString stringWithFormat:@"-%@", model.income];
        _rollInOutLab.textColor = RGBA(255, 42, 80, 1);
        _rollInOutLab.mj_y = (cellHeight-15)/2;
        _arrowImage.hidden = YES;
        _balanceLab.hidden = NO;
        _balanceLab.text = model.balance;
        
    } else if ([model.type isEqualToString:@"404"]) { //蜜豆荚利息出账(产生收益) 用income outlay
        
        _rollInOutLab.text = [NSString stringWithFormat:@"+%@", model.income];
        _rollInOutLab.textColor = RGBA(8, 145, 232, 1);
        _rollInOutLab.mj_y = (cellHeight-15)/2;
        _arrowImage.hidden = YES;
        _balanceLab.hidden = YES;
    
    }
    
    _titleLab.text = model.remark;
    _dateLab.text = model.subTime;
}


- (void)bgButtonClick {
    
    if ([_model.type isEqualToString:@"402"]) { // 只有转入流水才能展开
        if ([self.delegate respondsToSelector:@selector(showMeDouJiaDetailViewWithModel:)]) {
            [self.delegate showMeDouJiaDetailViewWithModel:_model];
        }
    }
}


- (UILabel *)getLabelWithFrame:(CGRect)frame andTextColor:(UIColor *)textColor andFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.font = font;
    return label;
}









- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

}

@end
