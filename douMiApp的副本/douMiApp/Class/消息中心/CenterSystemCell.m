//
//  CenterSystemCell.m
//  douMiApp
//
//  Created by edz on 2016/12/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "CenterSystemCell.h"
#import "masonry.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"


#define margin 10
#define leftRedge 13

@interface CenterSystemCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLab; // 标题
@property (nonatomic, strong) UILabel *dataLab; // 时间
@property (nonatomic, strong) UILabel *accountLab; // 账户,对应着接口的content1
@property (nonatomic, strong) UILabel *contentLab; // 内容，对应着接口的content2
@property (nonatomic, strong) UILabel *contentHeadLab; // 内容头部消息

@end

@implementation CenterSystemCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, margin, SCREEN_WIDTH, 91)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        
        _titleLab = [self getLabelWithFrame:CGRectMake(leftRedge, 20, 210, 15) andTitle:nil andTitleColor:RGBA(61, 61, 61, 1) andFont:DMFontBold(12)];
        [self addSubview:_titleLab];
        
        
        _dataLab = [self getLabelWithFrame:CGRectMake(SCREEN_WIDTH-leftRedge-130, 20, 130, 15) andTitle:nil andTitleColor:RGBA(141, 141, 141, 1) andFont:DMFont(12)];
        _dataLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:_dataLab];
    
        
        _accountLab = [self getLabelWithFrame:CGRectZero andTitle:nil andTitleColor:RGBA(60, 60, 60, 1) andFont:DMFont(10)];
        [self addSubview:_accountLab];
        
        
        _contentHeadLab = [self getLabelWithFrame:CGRectZero andTitle:nil andTitleColor:RGBA(60, 60, 60, 1) andFont:DMFont(10)];
        [self addSubview:_contentHeadLab];
        
        _contentLab = [self getLabelWithFrame:CGRectZero andTitle:nil andTitleColor:RGBA(255, 42, 80, 1) andFont:DMFont(10)];
        _contentLab.numberOfLines = 0;
        [self addSubview:_contentLab];
    }
    return self;
}


- (void)setItemWithModel:(MessageSystemModel *)model {
    _titleLab.text = model.title;
    _dataLab.text = model.publishDate;;
    
    if (!isEmpty(model.content1)) {
        _accountLab.text = model.content1;
        _accountLab.numberOfLines = 0;
        _accountLab.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [_accountLab sizeThatFits:CGSizeMake(SCREEN_WIDTH-leftRedge-leftRedge, MAXFLOAT)];
        _accountLab.frame = CGRectMake(_titleLab.mj_x, _titleLab.mj_y+_titleLab.mj_h+8, SCREEN_WIDTH-leftRedge-leftRedge, size.height);
        _accountLab.numberOfLines = 0;
        _accountLab.hidden = NO;
    } else {
        _accountLab.frame = CGRectMake(_titleLab.mj_x, _titleLab.mj_y+_titleLab.mj_h, _titleLab.mj_w, 0);
        _accountLab.hidden = YES;
    }
    
    if (!isEmpty(model.content2)) {

        _contentHeadLab.text = [model.content2 substringToIndex:5];
        _contentHeadLab.frame = CGRectMake(_accountLab.mj_x, _accountLab.mj_y+_accountLab.mj_h+8, 53, 12);
        _contentHeadLab.hidden = NO;
        
//        NSString *content = [NSString stringWithFormat:@"%@,500Y币礼品卡*1,300Y币礼品卡*1,10Y币礼品卡*10,800Y币礼品卡*1", model.content2];
        NSString *content = model.content2;
        if ([model.content2 containsString:@","]) {
            content = [content stringByReplacingOccurrencesOfString:@"," withString:@"      "];
        }
        
        _contentLab.text = [content substringFromIndex:5];
        CGSize singleSize = [@"一行的高度" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-_contentHeadLab.mj_w-leftRedge*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DMFont(10)} context:nil].size;
        CGSize contentSize = [_contentLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-_contentHeadLab.mj_w-leftRedge*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DMFont(10)} context:nil].size;
        
        if (contentSize.height/singleSize.height > 1) { // 多行的时候 要加上行间距
            [UILabel changeLineSpaceForLabel:_contentLab WithSpace:5];
            _contentLab.frame = CGRectMake(_contentHeadLab.mj_x+_contentHeadLab.mj_w, _accountLab.mj_y+_accountLab.mj_h+8, contentSize.width, contentSize.height+(contentSize.height/singleSize.height-1)*5);

        } else {
            _contentLab.frame = CGRectMake(_contentHeadLab.mj_x+_contentHeadLab.mj_w, _accountLab.mj_y+_accountLab.mj_h+8, contentSize.width, contentSize.height);

        }
        _contentLab.hidden = NO;
        
    } else {
        _contentLab.frame = CGRectMake(_accountLab.mj_x, _accountLab.mj_y+_accountLab.mj_h, SCREEN_WIDTH-leftRedge*2, 0);
        _contentLab.hidden = YES;
        _contentHeadLab.hidden = YES;
    }
    
    _bgView.mj_h = _contentLab.mj_y+_contentLab.mj_h+20-margin;
}


+ (CGFloat)getHeightWithModel:(MessageSystemModel *)model {
    
    if (model.cellHeight && model.cellHeight > 0) {
        return model.cellHeight;
    }
    
    float h = margin+20+15;
    if (!isEmpty(model.content1)) {
        
        UILabel *label = [[UILabel alloc] init];
        label.font = DMFont(10);
        label.text = model.content1;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [label sizeThatFits:CGSizeMake(SCREEN_WIDTH-leftRedge-leftRedge, MAXFLOAT)];
        h += 8+size.height;
    }
    
    if (!isEmpty(model.content2)) {
        
        UILabel *label = [[UILabel alloc] init];
        label.font = DMFont(10);
        NSString *content = model.content2;
        if ([model.content2 containsString:@","]) {
            content = [content stringByReplacingOccurrencesOfString:@"," withString:@"      "];
        }
        label.text = [content substringFromIndex:5];

        
        CGSize singleSize = [@"一行的高度" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-53-leftRedge*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DMFont(10)} context:nil].size;
        CGSize contentSize = [label.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-53-leftRedge*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DMFont(10)} context:nil].size;
        if (contentSize.height/singleSize.height > 1) {
            h += contentSize.height+(contentSize.height/singleSize.height-1)*5+8;
        } else {
            h += contentSize.height+8;
        }
    }
    
    h += 20;
    
    model.cellHeight = h;
    return model.cellHeight;
}


- (UILabel *)getLabelWithFrame:(CGRect)frame andTitle:(NSString *)title andTitleColor:(UIColor *)color andFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = title;
    label.textColor = color;
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
