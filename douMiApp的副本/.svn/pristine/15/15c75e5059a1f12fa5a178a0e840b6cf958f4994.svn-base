//
//  GZFSCell.m
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "GZFSCell.h"
#import "FSAndZDMode.h"
@implementation GZFSCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imageArr= [[NSMutableArray alloc] init];
    
    for (int i = 1; i<=10; i++) {
        [_imageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"b%d",i]]];
    }
    _zhiboType.animationImages = _imageArr; //动画图片数组
    _zhiboType.animationDuration = 1; //执行一次完整动画所需的时长
    _zhiboType.animationRepeatCount = 10000000;  //动画重复次数
}

- (void)setMode:(FSZBList *)mode {
    _nikename.text = mode.uname;
    [_icimage sd_setImageWithURL:[NSURL URLWithString:mode.imgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    if (mode.isOnline == 1) {
        _zhiboType.hidden = NO;
        
        [_zhiboType startAnimating];
    } else {
        [_zhiboType stopAnimating];
    _zhiboType.hidden = YES;
        
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
