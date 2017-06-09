//
//  AnchorCollecCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/18.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "AnchorCollecCell.h"
#import "AnchorMode.h"
@implementation AnchorCollecCell

- (void)setMode:(Anchorlist *)mode {
    _anchorName.text = mode.anchorName;
    [_anchorIcon sd_setImageWithURL:[NSURL URLWithString:mode.headUrl] placeholderImage:[UIImage imageNamed:@"dog"]];
    
    //高度固定不折行，根据字的多少计算label的宽度
    NSString *str =  [NSString stringWithFormat:@"%ld",(long)mode.likeNum];
    CGSize size = [str sizeWithFont:_fsNumber.font constrainedToSize:CGSizeMake(MAXFLOAT, _fsNumber.frame.size.height)];
    NSLog(@"size.width=%f, size.height=%f", size.width, size.height);
    //根据计算结果重新设置UILabel的尺寸
//    [label setFrame:CGRectMake(0, 10, size.width, 20)];
    _WWWWW.constant = size.width+5;
    _fsNumber.text = [NSString stringWithFormat:@"%ld",(long)mode.likeNum];

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
