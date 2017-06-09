//
//  CustomBannerCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/14.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ents;
@protocol ShareDelegate <NSObject>

@optional

- (void)shareCell:(NSInteger )ID;
- (void)likeDelegate:(NSInteger)ID;
@end

@interface CustomBannerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *subTileLable;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *zanNumber;

@property (weak, nonatomic)id<ShareDelegate>delegate;

@property (strong, nonatomic) Ents *entsMode;

@property (assign, nonatomic) NSInteger ID;

@end
