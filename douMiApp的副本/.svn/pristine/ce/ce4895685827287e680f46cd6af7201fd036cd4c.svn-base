//
//  TFoundTableCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TFoundSmallCell;
@class AnchorActionMode;
@class FoundResults;

@protocol smallCellTouchDelegate <NSObject>

@optional
- (void)smallTouchID:(NSInteger)ID;

@end

@interface TFoundTableCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *zhiboNumber;

@property (weak, nonatomic) IBOutlet UIImageView *liveImage;
@property (strong, nonatomic) NSMutableArray <FoundResults *>*dataArr;

@property (strong, nonatomic) AnchorActionMode *mode;

@property (assign, nonatomic) NSInteger page;
@property (weak, nonatomic)id<smallCellTouchDelegate>delegate;
- (void)request_Api;

@end
