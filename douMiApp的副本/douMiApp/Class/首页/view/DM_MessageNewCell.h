//
//  DM_MessageNewCell.h
//  douMiApp
//
//  Created by ydz on 2017/3/13.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Hotnewslist;
@interface DM_MessageNewCell : UITableViewCell

@property (strong, nonatomic)Hotnewslist *mode;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *mseTitle;
@property (weak, nonatomic) IBOutlet UILabel *mseText;
@property (weak, nonatomic) IBOutlet UIImageView *pic;

@end
