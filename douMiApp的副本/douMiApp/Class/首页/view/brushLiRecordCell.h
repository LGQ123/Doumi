//
//  brushLiRecordCell.h
//  douMiApp
//
//  Created by ydz on 2017/1/11.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Giftsinfo;
@protocol brushLiRecordDelegate <NSObject>

@optional
- (void)refundDelegate:(NSString *)bid;
- (void)mingXiDelegate:(NSString *)bid;
- (void)xieYiDelegate;

@end

@interface brushLiRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *MFQMoney;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *stateLable;
@property (weak, nonatomic) IBOutlet UILabel *yuQiLable;
@property (weak, nonatomic) IBOutlet UIView *useBackView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *mingXiBtn;
@property (weak, nonatomic) IBOutlet UIButton *XieYiBtn;
@property (weak, nonatomic) IBOutlet UILabel *yuQiTitle;
@property (weak, nonatomic) IBOutlet UIButton *refundBtn;
@property (copy, nonatomic) NSString *bId;
@property (strong, nonatomic) Giftsinfo *mode;

@property (weak, nonatomic) id<brushLiRecordDelegate>delegate;
@end
