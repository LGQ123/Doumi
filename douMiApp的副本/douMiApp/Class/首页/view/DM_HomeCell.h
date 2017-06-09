//
//  DM_HomeCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/7.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Listanchoronindex;
@protocol homeHotDelegate <NSObject>

@optional

- (void)adimageDelegate;
- (void)hotTouchDelegate;
- (void)hotCollecIndex:(NSInteger)index;

@end

@interface DM_HomeCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (strong, nonatomic)UICollectionView *myCollec;
@property (weak, nonatomic) IBOutlet UIImageView *adImage;

@property (strong, nonatomic)NSArray <Listanchoronindex *>*dataArr;

@property (weak, nonatomic) id<homeHotDelegate>delegate;

@end
