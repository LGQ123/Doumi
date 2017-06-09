//
//  ActivityCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/14.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "ActivityCell.h"
#import "ActivityMode.h"

@implementation ActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMode:(ResultsActivity *)mode {
    if (mode.status == 1) {
        _activeView.hidden = YES;
        _activeOver.hidden = YES;
    } else {
        _activeView.hidden = NO;
        _activeOver.hidden = NO;
    }
    [_activeimage sd_setImageWithURL:[NSURL URLWithString:mode.coverUrl] placeholderImage:nil];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
