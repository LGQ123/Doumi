//
//  TFoundSmallCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "TFoundSmallCell.h"
#import "AnchorActionMode.h"

@implementation TFoundSmallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMode:(FoundResults *)mode
{
   [ _icImageView sd_setImageWithURL:[NSURL URLWithString:mode.headImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    _nameLable.text = mode.uname;
    _contenLable.text = mode.introduction;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
