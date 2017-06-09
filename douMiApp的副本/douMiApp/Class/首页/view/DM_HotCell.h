//
//  DM_HotCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/8.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DM_HotCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *HTTitle;
@property (weak, nonatomic) IBOutlet UILabel *HTContent;
@property (weak, nonatomic) IBOutlet UILabel *HTNumber;
@property (weak, nonatomic) IBOutlet UIImageView *im3;
@property (weak, nonatomic) IBOutlet UIImageView *im2;
@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIButton *HTBtn;
@property (weak, nonatomic) IBOutlet UIView *touchView;

@property (strong, nonatomic)UICollectionView *myCollec;

@end
