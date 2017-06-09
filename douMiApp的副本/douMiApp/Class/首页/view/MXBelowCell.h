//
//  MXBelowCell.h
//  douMiApp
//
//  Created by ydz on 2017/1/13.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RepaymentDetails;
@interface MXBelowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *qiHao;
@property (weak, nonatomic) IBOutlet UILabel *huanKuanJE;
@property (weak, nonatomic) IBOutlet UILabel *BXLable;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;

@property (strong, nonatomic) RepaymentDetails *mode;

@end
