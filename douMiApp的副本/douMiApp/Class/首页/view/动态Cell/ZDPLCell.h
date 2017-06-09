//
//  ZDPLCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/23.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDPLDelegate <NSObject>

@optional

- (void)CollecIndex:(NSInteger)index ID:(NSInteger)Id;

@end

@interface ZDPLCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)UICollectionView *myCollec;
@property (copy, nonatomic) NSString *zanNumber;
@property (copy, nonatomic) NSString *plNumber;
@property (assign, nonatomic) NSInteger Id;
@property (assign, nonatomic) NSInteger ifZan;
@property (weak, nonatomic) id<ZDPLDelegate>delegate;

@end
