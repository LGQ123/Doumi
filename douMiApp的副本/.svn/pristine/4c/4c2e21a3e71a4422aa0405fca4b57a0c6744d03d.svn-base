//
//  DMUserDouTicketViewController.m
//  douMiApp
//
//  Created by edz on 2016/12/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DMUserDouTicketViewController.h"
#import "DMDouTicketCell.h"
#import "DMDouTicketListModel.h"

@interface DMUserDouTicketViewController ()

@property (nonatomic, strong) NSMutableArray *tableDataArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DMUserDouTicketViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    _tableDataArr = [[NSMutableArray alloc] init];
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"豆券";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
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
//        [weakSelf getLoadMoreData];
    }];
    [self getRefreshData];
}


- (void)getRefreshData {

    [_tableDataArr removeAllObjects];
    
    __weak UITableView *weakTableView = _tableView;
    __weak __typeof(self) weakSelf = self;

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY400046" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];

    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        DMDouTicketListModel *model = [DMDouTicketListModel mj_objectWithKeyValues:responseObj];
//        [_tableDataArr addObjectsFromArray:model.mapList];
        if (model.mapList && model.mapList.count > 0) {
            [weakSelf classifiedWithDataArray:model.mapList];
        }
        
        if (model.mapList.count == 0) {
            weakTableView.hidden = YES;
            [weakTableView reloadData];
            // 拿到当前的下拉刷新控件，结束刷新状态
            [weakTableView.mj_header endRefreshing];
        } else {
            weakTableView.hidden = NO;
            [weakTableView reloadData];
            // 拿到当前的下拉刷新控件，结束刷新状态
            [weakTableView.mj_header endRefreshing];
            [weakTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        
        [weakTableView.mj_header endRefreshing];
        
    }];
}


// 对券进行分类（可用、过期、已使用）
- (void)classifiedWithDataArray:(NSArray *)dataArray {
    
    NSMutableArray *outDateArray = [NSMutableArray array];
    NSMutableArray *inDateArray = [NSMutableArray array];
    NSMutableArray *usedArray = [NSMutableArray array];
    
    for (DMDouTicketModel *model in dataArray) {
        
        if ([model.status intValue] == 0) {  // 状态：0：未使用 1：已使用  （已过期：现在时间比结束时间大）
            
            // 时间的比较
            NSDate *select = [NSDate date];
            // 解决通过[NSDate date]获取现在时间少8个小时的问题
            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate: select];
            NSDate *nowDate = [select dateByAddingTimeInterval: interval];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy.MM.dd"];
            NSDate *endDate = [formatter dateFromString:model.endTime];
            
            NSComparisonResult result = [nowDate compare:endDate];
            if (result == NSOrderedDescending) { // 已过期
                [outDateArray dm_addObject:model];
            } else if (result == NSOrderedAscending) { // 未过期
                [inDateArray dm_addObject:model];
            } else { // 相同
                [inDateArray dm_addObject:model];
            }
            
        } else if ([model.status intValue] == 1) {
            [usedArray dm_addObject:model];
        }
    }
    
    [_tableDataArr addObjectsFromArray:inDateArray];
    [_tableDataArr addObjectsFromArray:usedArray];
    [_tableDataArr addObjectsFromArray:outDateArray];
}


// 没有分页
//- (void)getLoadMoreData {
//    
//}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableDataArr.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DMDouTicketModel *model = [_tableDataArr dm_objectAtIndex:indexPath.row];
    DMDouTicketCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CenterZanCell"];
    if (cell == nil) {
        cell = [[DMDouTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CenterZanCell"];
    }
    [cell setItemWithModel:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 151;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
