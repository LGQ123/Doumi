//
//  RefundCell.h
//  douMiApp
//
//  Created by ydz on 2017/1/11.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Overduerepayments;

typedef void(^LZNumberChangedBlock)(NSInteger number);
typedef void(^LZCellSelectedBlock)(BOOL select);

@interface RefundCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) UILabel *number;

@property (strong, nonatomic) UILabel *daiHuanBX;

@property (strong, nonatomic) UIButton *chooseBtn;

@property (strong, nonatomic) Overduerepayments *mode;

- (void)numberAddWithBlock:(LZNumberChangedBlock)block;
- (void)numberCutWithBlock:(LZNumberChangedBlock)block;
- (void)cellSelectedWithBlock:(LZCellSelectedBlock)block;

@end
