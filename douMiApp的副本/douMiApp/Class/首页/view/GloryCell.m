//
//  GloryCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/14.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "GloryCell.h"
#import "GloryMode.h"
@implementation GloryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMode:(List *)mode {
    [_icimage sd_setImageWithURL:[NSURL URLWithString:mode.imgUrl] placeholderImage:[UIImage imageNamed:@"dog"]];
    _nameLable.text = mode.nickName;
    _nmberLable.text = mode.amounts;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
