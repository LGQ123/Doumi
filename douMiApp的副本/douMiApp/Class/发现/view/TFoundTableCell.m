//
//  TFoundTableCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "TFoundTableCell.h"
#import "TFoundSmallCell.h"
#import "AnchorActionMode.h"
@implementation TFoundTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_myTableView registerNib:[UINib nibWithNibName:@"TFoundSmallCell" bundle:nil] forCellReuseIdentifier:@"TFoundSmallCell"];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    __weak __typeof(self) weakSelf = self;
//    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf request_Api];
//    }];
    
    _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf request_MoreApi];
    }];
//    [self request_Api];
    
    
}

- (void)request_Api {
    
    __weak UITableView *tableView = self.myTableView;
    _page = 1;
    _dataArr = [[NSMutableArray alloc] init];
    NSDictionary *dic = @{@"iface":@"DMHY300012",@"userId":[BusinessLogic uuid],@"pageNo":@"1"};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        _mode = [AnchorActionMode mj_objectWithKeyValues:responseObj];
        _zhiboNumber.text = [NSString stringWithFormat:@"正在直播中(%ld)",(long)_mode.totalRecord];
        [_dataArr addObjectsFromArray:_mode.results];
        NSLog(@"%@",_dataArr);
        [tableView reloadData];
        if (_mode.results.count < _mode.pageSize) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            // 拿到当前的下拉刷新控件，结束刷新状态
            [tableView.mj_footer endRefreshing];
            
        }
        [tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    }];
}

- (void)request_MoreApi {
    __weak UITableView *tableView = self.myTableView;
    _page++;
    NSDictionary *dic = @{@"iface":@"DMHY300012",@"userId":[BusinessLogic uuid],@"pageNo":[NSString stringWithFormat:@"%ld",(long)_page]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        _mode = [AnchorActionMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.results];
        [tableView reloadData];
        if (_mode.results.count < _mode.pageSize) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            // 拿到当前的下拉刷新控件，结束刷新状态
            [tableView.mj_footer endRefreshing];
            
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    }];
    
}

#pragma mark- tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TFoundSmallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TFoundSmallCell"];
    cell.mode = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(smallTouchID:)]) {
        [self.delegate smallTouchID:_dataArr[indexPath.row].Id];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
