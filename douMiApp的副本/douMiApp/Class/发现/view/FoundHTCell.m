//
//  FoundHTCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "FoundHTCell.h"

@implementation FoundHTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)HTTouch1:(UIButton *)sender {
    NSDictionary *dict = @{@"location" :@"0"};
    [MobClick event:@"foundTopic" attributes:dict];
    if ([self.delegate respondsToSelector:@selector(HotHTDelegate:)]) {
        [self.delegate HotHTDelegate:sender];
    }
}
- (IBAction)HTTouch2:(UIButton *)sender {
    NSDictionary *dict = @{@"location" :@"1"};
    [MobClick event:@"foundTopic" attributes:dict];
    if ([self.delegate respondsToSelector:@selector(HotHTDelegate:)]) {
        [self.delegate HotHTDelegate:sender];
    }
}
- (IBAction)HTTouch3:(UIButton *)sender {
    NSDictionary *dict = @{@"location" :@"2"};
    [MobClick event:@"foundTopic" attributes:dict];
    if ([self.delegate respondsToSelector:@selector(HotHTDelegate:)]) {
        [self.delegate HotHTDelegate:sender];
    }
}
- (IBAction)GDHTTouch:(UIButton *)sender {
    NSDictionary *dict = @{@"location" :@"3"};
    [MobClick event:@"foundTopic" attributes:dict];
    if ([self.delegate respondsToSelector:@selector(HotHTDelegate:)]) {
        [self.delegate HotHTDelegate:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
