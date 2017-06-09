//
//  DM_MessageNewCell.m
//  douMiApp
//
//  Created by ydz on 2017/3/13.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "DM_MessageNewCell.h"
#import "MessageMode.h"

@implementation DM_MessageNewCell


- (void)setMode:(Hotnewslist *)mode {
    _dateLable.text = mode.publishDate;
    _mseTitle.text = mode.title;
    _mseText.text = mode.content;
    [_pic sd_setImageWithURL:[NSURL URLWithString:mode.smallPic] placeholderImage:nil];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
