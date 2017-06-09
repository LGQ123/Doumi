//
//  DM_MeHomeTCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/21.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_MeHomeTCell.h"
#import "MEHomeMode.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation DM_MeHomeTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.icImgBtn.layer.cornerRadius = (SCREEN_WIDTH*240/375-140)/2;
    self.icImgBtn.layer.masksToBounds = YES;
    
}

- (void)setMode:(MEHomeMode *)mode {
    if ([BusinessLogic uuid].length == 0) {
        [_icImgBtn setBackgroundImage:[UIImage imageNamed:@"组"] forState:UIControlStateNormal];
    } else {
        [_icImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:mode.imgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userdog"]];
    }
    [_fenSiNum setTitle:mode.fansNum forState:UIControlStateNormal];
    [_guanZhuNum setTitle:mode.anchorNum forState:UIControlStateNormal];
    [_ronYaoNum setTitle:mode.money forState:UIControlStateNormal];

}

- (IBAction)icTouch:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(icTouch)]) {
        [self.delegate icTouch];
    }
    
}
- (IBAction)fensiTou:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(fensiTouch)]) {
        [self.delegate fensiTouch];
    }
    
}

- (IBAction)guanzhuTouch:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(guanzhuTouch)]) {
        [self.delegate guanzhuTouch];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
