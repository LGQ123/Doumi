//
//  DM_MeYuECell.h
//  douMiApp
//
//  Created by ydz on 2016/11/21.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeYuECollecDelegate <NSObject>

@optional
- (void)touchYuECollec:(NSInteger)index;

@end

@interface DM_MeYuECell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *myCollecTV;
@property (weak, nonatomic) id<MeYuECollecDelegate>delegate;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end
