//
//  DM_BelowCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/8.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol messageDelegate <NSObject>
@optional
- (void)check:(UITableViewCell *)cell;
- (void)details:(UITableViewCell *)cell;
- (void)meDoujiaButtonClick;
- (void)fenQiButtonClick;

@end

@interface DM_BelowCell : UITableViewCell

@property (weak, nonatomic)id<messageDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIImageView *messageImg;
@property (weak, nonatomic) IBOutlet UIImageView *messageImg2;
@property (weak, nonatomic) IBOutlet UIImageView *messageImg3;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;
@property (weak, nonatomic) IBOutlet UILabel *mseTitle;
@property (weak, nonatomic) IBOutlet UILabel *mseText;
@property (weak, nonatomic) IBOutlet UIButton *douJiaBtn;
@property (weak, nonatomic) IBOutlet UIButton *fenQiBtn;


@end
