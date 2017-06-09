//
//  MessageCenterCell.h
//  douMiApp
//
//  Created by edz on 2016/12/29.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModeA.h"

@interface MessageCenterCell : UITableViewCell

- (void)setItemWithModel:(id)model andCount:(NSString *)count; // count:系统消息数或者点赞数

@end
