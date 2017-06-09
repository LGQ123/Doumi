//
//  FoundHTCell.h
//  douMiApp
//
//  Created by ydz on 2016/11/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTFoundDelegate <NSObject>

- (void)HotHTDelegate:(UIButton *)ID;

@end

@interface FoundHTCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *hotHT1;
@property (weak, nonatomic) IBOutlet UIButton *hotHT2;
@property (weak, nonatomic) IBOutlet UIButton *hotHT3;
@property (weak, nonatomic) IBOutlet UIButton *hotHT4;

@property (weak, nonatomic) id<HTFoundDelegate>delegate;

@end
