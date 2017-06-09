//
//  DM_MeHomeTCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/21.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MEHomeMode;
@protocol DM_MeHomeTDelegate <NSObject>

@optional
- (void)icTouch;
- (void)fensiTouch;
- (void)guanzhuTouch;


@end

@interface DM_MeHomeTCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *icImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *fenSiNum;
@property (weak, nonatomic) IBOutlet UIButton *guanZhuNum;
@property (weak, nonatomic) IBOutlet UIButton *ronYaoNum;
@property (weak, nonatomic) IBOutlet UIImageView *btnImage;
@property (weak, nonatomic) id<DM_MeHomeTDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *FensILable;
@property (weak, nonatomic) IBOutlet UIButton *guanZhuLable;
@property (weak, nonatomic) IBOutlet UIButton *ronYaoLable;

@property (strong, nonatomic) MEHomeMode *mode;
@end
