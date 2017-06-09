//
//  CenterZanCell.m
//  douMiApp
//
//  Created by edz on 2016/12/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "CenterZanCell.h"


#define margin 10

@interface CenterZanCell ()

@property (nonatomic, strong) UILabel *titleLab; // 标题
@property (nonatomic, strong) UILabel *dataLab; // 时间

@end

@implementation CenterZanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, margin, SCREEN_WIDTH, 51)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, SCREEN_WIDTH-140, 51)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = RGBA(61, 61, 61, 1);
        _titleLab.font = DMFontBold(12);
        [bgView addSubview:_titleLab];
        
        
        _dataLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-margin-110, 0, 110, 51)];
        _dataLab.backgroundColor = [UIColor clearColor];
        _dataLab.textColor = RGBA(60, 60, 60, 1);
        _dataLab.font = DMFont(10);
        _dataLab.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:_dataLab];
    }
    return self;
}


- (void)setItemWithModel:(MessageZanModel *)model {
    _titleLab.text = model.title;
    _dataLab.text = model.createDate;
}















- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

}

@end
