//
//  YTicketCell.h
//  douMiApp
//
//  Created by ydz on 2017/1/16.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTicketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *noTickeLable;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
