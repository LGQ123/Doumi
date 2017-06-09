//
//  PersonageCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/23.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "PersonageCell.h"

@implementation PersonageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.icimage.layer.cornerRadius = (SCREEN_WIDTH*280/375-180)/2;
    self.icimage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
