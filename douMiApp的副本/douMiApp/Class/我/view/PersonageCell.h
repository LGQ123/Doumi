//
//  PersonageCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/23.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *isZhiBoBtn;
@property (weak, nonatomic) IBOutlet UILabel *isZhiBoLAble;
@property (weak, nonatomic) IBOutlet UIButton *icimage;
@property (weak, nonatomic) IBOutlet UIButton *isGuanZhuBtn;
@property (weak, nonatomic) IBOutlet UILabel *isGuanZhuLable;
@property (weak, nonatomic) IBOutlet UILabel *YYHome;
@property (weak, nonatomic) IBOutlet UITextView *GXText;
@property (weak, nonatomic) IBOutlet UIImageView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *juBaoBtn;

@end
