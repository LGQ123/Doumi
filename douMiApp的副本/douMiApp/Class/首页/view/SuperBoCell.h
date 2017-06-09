//
//  SuperBoCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/14.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@protocol superDelegate <NSObject>
@optional
- (void)superMVTouch:(NSInteger)ID andShuID:(NSInteger)SID;
- (void)superLikeTouch:(NSInteger)ID andShuID:(NSInteger)SID;
- (void)superShareTouch:(NSInteger)ID andShuID:(NSInteger)SID;

@end

@class Hashmaplist,Ents;
@interface SuperBoCell : UITableViewCell<SDCycleScrollViewDelegate>


@property (strong, nonatomic)SDCycleScrollView *cycleSV;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@property (strong, nonatomic) Hashmaplist *mode;
@property (assign, nonatomic) NSInteger ID;
@property (weak, nonatomic) id<superDelegate>delegate;

@end
