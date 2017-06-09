//
//  FenSiCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/23.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Userimgurllsit;
@protocol fenSiDelegate <NSObject>

@optional

- (void)FSTouchDelegate;
- (void)FSCollecIndex:(NSInteger)index;

@end


@interface FenSiCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>


@property (strong, nonatomic)UICollectionView *myCollec;

@property (strong, nonatomic) NSArray <Userimgurllsit *>*dataArr;

@property (weak, nonatomic) id<fenSiDelegate>delegate;

@end
