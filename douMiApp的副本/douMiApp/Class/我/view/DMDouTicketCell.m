//
//  DMDouTicketCell.m
//  douMiApp
//
//  Created by edz on 2016/12/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DMDouTicketCell.h"


#define margin 10
#define picW 87
#define picH 70

@interface DMDouTicketCell ()

@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIImageView *statusPic;
@property (nonatomic, strong) UIView *topView;

@end

@implementation DMDouTicketCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, SCREEN_WIDTH-margin*2, 141)];
        _coverImage.backgroundColor = [UIColor clearColor];
        [self addSubview:_coverImage];
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, SCREEN_WIDTH-margin*2, 141)];
        bgImage.image = [UIImage imageNamed:@"券"];
        [self addSubview:bgImage];
        
        _titleLab = [self getLabelWithFrame:CGRectMake(20, margin, SCREEN_WIDTH-160, 21) andBgcolor:[UIColor clearColor] andTitleColor:RGBA(40, 40, 40, 1) andFont:DMFontBold(16)];
        [bgImage addSubview:_titleLab];
        
        _numLab = [self getLabelWithFrame:CGRectMake(_titleLab.mj_x+_titleLab.mj_w+9, _titleLab.mj_y, 91, _titleLab.mj_h) andBgcolor:RGBA(255, 42, 80, 1) andTitleColor:[UIColor whiteColor] andFont:DMFontBold(16)];
        _numLab.textAlignment = NSTextAlignmentCenter;
        [bgImage addSubview:_numLab];
        
        _dateLab = [self getLabelWithFrame:CGRectMake(_titleLab.mj_x, _titleLab.mj_y+_titleLab.mj_h+30, SCREEN_WIDTH-40, 18) andBgcolor:[UIColor clearColor] andTitleColor:RGBA(40, 40, 40, 1) andFont:DMFont(12)];
        [bgImage addSubview:_dateLab];
        
        _contentLab = [self getLabelWithFrame:CGRectMake(_titleLab.mj_x, _dateLab.mj_y+_dateLab.mj_h, SCREEN_WIDTH-40, 18) andBgcolor:[UIColor clearColor] andTitleColor:RGBA(40, 40, 40, 1) andFont:DMFont(12)];
        [bgImage addSubview:_contentLab];
        
        _addressLab = [self getLabelWithFrame:CGRectMake(_titleLab.mj_x, _contentLab.mj_y+_contentLab.mj_h, SCREEN_WIDTH-40, 18) andBgcolor:[UIColor clearColor] andTitleColor:RGBA(40, 40, 40, 1) andFont:DMFont(12)];
        [bgImage addSubview:_addressLab];
        
        UILabel *infoLab = [self getLabelWithFrame:CGRectMake(_titleLab.mj_x, _coverImage.mj_h-15, 130, 10) andBgcolor:[UIColor clearColor] andTitleColor:RGBA(255, 42, 80, 1) andFont:DMFont(8)];
        infoLab.text = @"本券最终解释权归豆蜜网站所有";
        [bgImage addSubview:infoLab];
        
        _topView = [[UIView alloc] initWithFrame:_coverImage.bounds];
        _topView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
        [bgImage addSubview:_topView];
        _topView.hidden = YES;
        
        _statusPic = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-picW, 36, picW, picH)];
        [bgImage addSubview:_statusPic];
        _statusPic.hidden = YES;
        
    }
    return self;
}


- (void)setItemWithModel:(DMDouTicketModel *)model {
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
    if ([model.type intValue] == 2 || [model.type intValue] == 3) { // 打赏券和充值券需要自己拼接标题
        _titleLab.text = [NSString stringWithFormat:@"%@%@元", model.name, model.amount];
    } else {
        _titleLab.text = model.name;
    }
    
    if (!isEmpty(model.exchangeNum)) {
        _numLab.text = model.exchangeNum;
        _numLab.hidden = NO;
    } else {
        _numLab.hidden = YES;
    }
    
    _dateLab.text = [NSString stringWithFormat:@"有效期: %@-%@", model.beginTime, model.endTime];
    if ([model.type intValue] == 2 || [model.type intValue] == 3) {
        _contentLab.text = [NSString stringWithFormat:@"内容: %@%@元", model.content, model.amount];
    } else {
        _contentLab.text = [NSString stringWithFormat:@"内容: %@", model.content];
    }
    if (!isEmpty(model.businessAddress)) {
        _addressLab.hidden = NO;
        _addressLab.text = [NSString stringWithFormat:@"地址: %@", model.businessAddress];
        
    } else {
        _addressLab.hidden = YES;
        _dateLab.mj_y = _titleLab.mj_y+_titleLab.mj_h+30+9;
        _contentLab.mj_y = _dateLab.mj_y+_dateLab.mj_h;
    }
    
    if ([model.status intValue] == 0) { // 状态：0：未使用 1：已使用  （已过期：现在时间比结束时间大）
        
        // 时间的比较
        NSDate *select = [NSDate date];
        // 解决通过[NSDate date]获取现在时间少8个小时的问题
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: select];
        NSDate *nowDate = [select dateByAddingTimeInterval: interval];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy.MM.dd"];
        NSDate *endDate = [formatter dateFromString:model.endTime];
        
        NSComparisonResult result = [nowDate compare:endDate];
        if (result == NSOrderedDescending) { // 已过期
            NSLog(@"-------nowDate>endDate------");
            
            _statusPic.hidden = NO;
            _statusPic.image = [UIImage imageNamed:@"已过期"];
            _topView.hidden = NO;
            
        } else if (result == NSOrderedAscending) { // 未过期
            NSLog(@"--------nowDate<endDate------"); // nowDate是过去
            
            _statusPic.hidden = YES;
            _topView.hidden = YES;
            
        } else {
            NSLog(@"--------nowDate=endDate-------"); // 相同
            
            _statusPic.hidden = YES;
            _topView.hidden = YES;
            
        }
    } else if ([model.status intValue] == 1) {
        _statusPic.hidden = NO;
        _statusPic.image = [UIImage imageNamed:@"已使用"];
        _topView.hidden = NO;
    }
}




- (UILabel *)getLabelWithFrame:(CGRect)frame andBgcolor:(UIColor *)bgColor andTitleColor:(UIColor *)textColor andFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = bgColor;
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
