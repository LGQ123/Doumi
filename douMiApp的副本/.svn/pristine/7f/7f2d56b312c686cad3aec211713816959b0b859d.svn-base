//
//  SuperBoCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/14.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "SuperBoCell.h"
#import "SuperBoMode.h"
@implementation SuperBoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setMode:(Hashmaplist *)mode {
    
    _titleLable.text = mode.bigTitle;
    _subTitle.text = [NSString stringWithFormat:@"%@/%@",mode.subtitle,mode.periodCreateTime];
//    _cycleSV.mode = mode;
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    SDCycleScrollView *cycleSV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_WIDTH*200/375) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleSV.LGQType = @"11111";
    cycleSV.autoScroll = NO;
    cycleSV.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleSV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleSV.pageControlDotSize = CGSizeMake(12, 12);
    //    _cycleSV.pageDotColor = [UIColor redColor];
    cycleSV.mode = mode;
    cycleSV.pageDotImage = [UIImage imageNamed:@"juxing2"];
    cycleSV.currentPageDotImage = [UIImage imageNamed:@"juxing"];
    [self.contentView addSubview:cycleSV];
    
}


//点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(superMVTouch:andShuID:)]) {
        [self.delegate superMVTouch:index andShuID:self.ID];
    }
    
}

//点赞

- (void)likeTouch:(NSInteger)ID {
    if ([self.delegate respondsToSelector:@selector(superLikeTouch:andShuID:)]) {
        [self.delegate superLikeTouch:ID andShuID:self.ID];
    }
}

//分享
- (void)shareTouch:(NSInteger)ID {
    if ([self.delegate respondsToSelector:@selector(superShareTouch:andShuID:)]) {
        [self.delegate superShareTouch:ID andShuID:self.ID];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
