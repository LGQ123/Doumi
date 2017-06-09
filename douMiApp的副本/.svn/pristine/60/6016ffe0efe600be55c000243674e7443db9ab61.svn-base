//
//  HTPLCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Comments;

@protocol htplDelegate <NSObject>
@optional
- (void)htplIcTouch:(NSInteger)ID;

@end

@interface HTPLCell : UITableViewCell

@property (strong, nonatomic) Comments *mode;
@property (assign, nonatomic) NSInteger ID;
@property (weak, nonatomic)id<htplDelegate>delegate;
@end
