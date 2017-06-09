//
//  MessageCenterSystemViewController.m
//  douMiApp
//
//  Created by edz on 2016/12/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MessageCenterSystemViewController.h"
#import "CenterSystemCell.h"
#import "MessageModeA.h"

@interface MessageCenterSystemViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *tableDataArr;
@property (nonatomic, strong) MessageSystemListModel *messageModel;

@end

@implementation MessageCenterSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableDataArr = [[NSMutableArray alloc] init];
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"系统消息";
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
        [weakSelf getLoadMoreData];
    }];
    [self getRefreshData];
}


// 下拉刷新
- (void)getRefreshData {
    _page = 1;
    [_tableDataArr removeAllObjects];
    
    __weak UITableView *weakTableView = _tableView;
//    __weak __typeof(self) weakSelf = self;
//    NSDictionary *dic = @{@"iface":@"DMHY200002",@"userId":@"254869",@"current":[NSString stringWithFormat:@"%ld",(long)_page], @"pageSize":@"20"};
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY200002" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"]; ////////////// [BusinessLogic uuid]  254869
    [dic dm_setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"current"];
    [dic dm_setObject:@"20" forKey:@"pageSize"];
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        _messageModel = [MessageSystemListModel mj_objectWithKeyValues:responseObj];
        [_tableDataArr addObjectsFromArray:_messageModel.messageList];
        
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
            if (_tableDataArr.count == [_messageModel.totalNum integerValue]) {
                [weakTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }

        
    } failure:^(NSError *error) {
        
        [weakTableView.mj_header endRefreshing];

    }];
}


// 加载更多
- (void)getLoadMoreData {
    
    _page ++;
    __weak UITableView *weakTableView = _tableView;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY200002" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
    [dic dm_setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"current"];
    [dic dm_setObject:@"20" forKey:@"pageSize"];
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        _messageModel = [MessageSystemListModel mj_objectWithKeyValues:responseObj];
        [_tableDataArr addObjectsFromArray:_messageModel.messageList];
        [weakTableView reloadData];
        
        if (_messageModel.messageList.count == 0) {
            [weakTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [weakTableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        [weakTableView.mj_footer endRefreshing];
//        _page --;
    }];
    
}


#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableDataArr.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageSystemModel *model = [_tableDataArr dm_objectAtIndex:indexPath.row]; // _tableDataArr.count > indexPath.row
    
    CenterSystemCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CenterZanCell"];
    if (cell == nil) {
        cell = [[CenterSystemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CenterZanCell"];
    }
    [cell setItemWithModel:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CenterSystemCell getHeightWithModel:[_tableDataArr dm_objectAtIndex:indexPath.row]];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end
