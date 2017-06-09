//
//  WriteInforController.h
//  douMiApp
//
//  Created by ydz on 2016/12/6.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "RootNViewController.h"

@protocol writeInforDelegate <NSObject>

@optional
- (void)writeStr:(NSString *)str title:(NSString *)title;

@end

@interface WriteInforController : RootNViewController

@property (copy, nonatomic) NSString *titleStr;

@property (weak, nonatomic) id<writeInforDelegate>delegate;
@property (assign, nonatomic) BOOL isGongKai;

@end
