//
//  RootViewController.h
//  douMiApp
//
//  Created by ydz on 2016/11/4.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

typedef NS_ENUM(NSInteger, item_location) {
    item_left = 0,
    item_right,
    item_center
};

@property (strong, nonatomic)UIView *navigationView;
@property (strong, nonatomic)UILabel *lable;

@property (copy, nonatomic)NSString *D_title;


- (void)addItem:(item_location)location btnTitle:(NSString *)title viewTitle:(NSString *)str;
- (void)addTite:(NSString *)str;

- (void)showLeft;
- (void)showRight;
- (void)showCenter;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^) (UIAlertAction *action))handler;

@end
