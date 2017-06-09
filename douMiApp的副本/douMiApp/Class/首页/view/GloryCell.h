//
//  GloryCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/14.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class List;
@interface GloryCell : UITableViewCell

@property (strong, nonatomic) List *mode;
@property (weak, nonatomic) IBOutlet UILabel *indexLable;
@property (weak, nonatomic) IBOutlet UIImageView *icimage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *nmberLable;

@end
