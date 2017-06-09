//
//  DMMeDouJiaDetailViewController.m
//  douMiApp
//
//  Created by edz on 2017/1/10.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "DMMeDouJiaDetailViewController.h"
#import "DMMDJPastDetailViewController.h"

@interface DMMeDouJiaDetailViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableDataArr;
@property (nonatomic, assign) NSInteger page;

@end

@implementation DMMeDouJiaDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableDataArr = [NSMutableArray array];

    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"蜜豆荚明细";
    self.lable.textColor = RGBA(39, 39, 39, 1);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    __weak __typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getRefreshData];
    }];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getLoadMoreData];
    }];
    [self getRefreshData];
}


// 下拉刷新
- (void)getRefreshData {
    
    _page = 1;
    [_tableDataArr removeAllObjects];
    
//    __weak __typeof(self) weakSelf = self;
    
    __weak UITableView *weakTableView = _tableView;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY600002" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
    [dic dm_setObject:@"20" forKey:@"pageSize"];
    [dic dm_setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"pageNo"];
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        DMMeDouJiaListModel *model = [DMMeDouJiaListModel mj_objectWithKeyValues:responseObj];
        [_tableDataArr addObjectsFromArray:model.results];
        
        if (_tableDataArr.count == 0) {
            weakTableView.hidden = YES;
            [weakTableView reloadData];
            // 拿到当前的下拉刷新控件，结束刷新状态
            [weakTableView.mj_header endRefreshing];
        } else {
            weakTableView.hidden = NO;
            [weakTableView reloadData];
            // 拿到当前的下拉刷新控件，结束刷新状态
            [weakTableView.mj_header endRefreshing];
            if (_tableDataArr.count == [model.totalRecord integerValue]) {
                [weakTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)getLoadMoreData {
    _page ++;
    __weak UITableView *weakTableView = _tableView;

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY600002" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
    [dic dm_setObject:@"20" forKey:@"pageSize"];
    [dic dm_setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"pageNo"];
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        DMMeDouJiaListModel *model = [DMMeDouJiaListModel mj_objectWithKeyValues:responseObj];
        [_tableDataArr addObjectsFromArray:model.results];
        [weakTableView reloadData];
        
        if (model.results.count == 0) {
            [weakTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [weakTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        [weakTableView.mj_footer endRefreshing];
    }];
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableDataArr.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DMMeDouJiaDetailModel *modle = [_tableDataArr dm_objectAtIndex:indexPath.row];
    
    DMMeDouJiaDetailCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMMeDouJiaDetailCell"];
    if (!cell) {
        cell = [[DMMeDouJiaDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMMeDouJiaDetailCell"];
    }
    [cell setItemWithModel:modle];
    cell.delegate = self;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61;
}


#pragma mark DMMDJDetailDelegate
// 展示蜜豆荚明细
- (void)showMeDouJiaDetailViewWithModel:(DMMeDouJiaDetailModel *)model {
    DMMDJPastDetailViewController *controller = [[DMMDJPastDetailViewController alloc] init];
    controller.mdjModel = model;
    [self.navigationController pushViewController:controller animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
