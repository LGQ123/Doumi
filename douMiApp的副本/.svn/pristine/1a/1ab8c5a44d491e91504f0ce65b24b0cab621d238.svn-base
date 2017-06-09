//
//  HTListCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "HTListCell.h"
#import "HTListMode.h"

@implementation HTListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMode:(TalkHTlist *)mode {
    _titleLable.text = mode.talkTitle;
    _contentLable.text = mode.talkContent;
    _numberLable.text = [NSString stringWithFormat:@"%ld",(long)mode.hotNum];
    if (mode.headUrlList.count > 0) {
        [_im1 sd_setImageWithURL:[NSURL URLWithString:mode.headUrlList[0].headUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
//        NSLog(@"%@",_mode.talkHeadUrlList[0]);
    }
    if (mode.headUrlList.count > 1) {
        [_im2 sd_setImageWithURL:[NSURL URLWithString:mode.headUrlList[1].headUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    }
    if (mode.headUrlList.count > 2) {
        [_im3 sd_setImageWithURL:[NSURL URLWithString:mode.headUrlList[2].headUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    }
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
