//
//  DM_MessageCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/9.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Hotnewslist;
@interface DM_MessageCell : UITableViewCell

@property (strong, nonatomic)Hotnewslist *mode;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;
@property (weak, nonatomic) IBOutlet UILabel *mseTitle;
@property (weak, nonatomic) IBOutlet UILabel *mseText;

@end
