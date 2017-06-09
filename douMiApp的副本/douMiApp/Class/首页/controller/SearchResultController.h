//
//  SearchResultController.h
//  douMiApp
//
//  Created by ydz on 2016/11/25.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "RootViewController.h"

@interface SearchResultController : RootViewController

@property (copy, nonatomic) NSString *searchStr;
@property (strong, nonatomic) UITableView *searchTableView;

- (void)request_Api;

@end
