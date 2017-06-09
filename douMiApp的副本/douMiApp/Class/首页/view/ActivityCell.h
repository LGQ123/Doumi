//
//  ActivityCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/14.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResultsActivity;
@interface ActivityCell : UITableViewCell

@property (strong, nonatomic) ResultsActivity *mode;
@property (weak, nonatomic) IBOutlet UIImageView *activeimage;
@property (weak, nonatomic) IBOutlet UIView *activeView;
@property (weak, nonatomic) IBOutlet UIImageView *activeOver;

@end
