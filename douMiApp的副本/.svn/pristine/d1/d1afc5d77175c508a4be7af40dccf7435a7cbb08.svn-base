//
//  DMMeDouJiaDetailCell.h
//  douMiApp
//
//  Created by edz on 2017/1/10.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMMeDouJiaModel.h"



@protocol DMMDJDetailDelegate <NSObject>

- (void)showMeDouJiaDetailViewWithModel:(DMMeDouJiaDetailModel *)model;

@end

@interface DMMeDouJiaDetailCell : UITableViewCell

@property (nonatomic, weak) id<DMMDJDetailDelegate>delegate;

- (void)setItemWithModel:(DMMeDouJiaDetailModel *)model;

//+ (CGFloat)getCellHeight;

@end
