//
//  GZFSCell.h
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSZBList;
@interface GZFSCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icimage;
@property (weak, nonatomic) IBOutlet UILabel *nikename;
@property (weak, nonatomic) IBOutlet UIImageView *zhiboType;
@property (strong, nonatomic) FSZBList *mode;
@property (strong, nonatomic) NSMutableArray *imageArr;
@end
