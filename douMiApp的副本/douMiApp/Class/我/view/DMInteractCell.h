//
//  DMInteractCell.h
//  douMiApp
//
//  Created by ydz on 2016/12/30.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InteractMode.h"
@protocol DMInteractDelegate <NSObject>
@optional
- (void)DMInteractTouch:(NSString *)ID;

@end


@interface DMInteractCell : UITableViewCell
@property (weak, nonatomic)id<DMInteractDelegate>delegate;
@property (strong, nonatomic) Map *mode;
@property (copy, nonatomic) NSString *ID;
@end
