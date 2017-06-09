//
//  DM_MeCollecCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/21.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeCollecDelegate <NSObject>

@optional
- (void)touchCollec:(NSInteger)index;

@end

@interface DM_MeCollecCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *dataArr;
@property (strong, nonatomic) UICollectionView *myCollecTV;

@property (weak, nonatomic) id<MeCollecDelegate>delegate;

@end
