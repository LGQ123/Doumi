//
//  DMRewardRootViewController.m
//  douMiApp
//
//  Created by edz on 2016/12/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DMRewardRootViewController.h"

@interface DMRewardRootViewController ()

@end

@implementation DMRewardRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor clearColor];
}


- (void)toRootViewController {
    UIViewController *viewController = self;
    while (viewController.presentingViewController) {
        //判断是否为最底层控制器
        if ([viewController isKindOfClass:[DMRewardRootViewController class]]) {
            viewController = viewController.presentingViewController;
        }else{
            break;
        }
    }
    if (viewController) {
        [viewController dismissViewControllerAnimated:NO completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
