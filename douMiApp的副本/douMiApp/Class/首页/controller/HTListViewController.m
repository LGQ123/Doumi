//
//  HTListViewController.m
//  douMiApp
//
//  Created by ydz on 2016/11/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "HTListViewController.h"
#import "HTListCell.h"
#import "HTDetailsViewController.h"
#import "HTListMode.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"
@interface HTListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) NSMutableArray<TalkHTlist *> *dataArr;
@property (strong, nonatomic) HTListMode *mode;

@end

@implementation HTListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [MobClick beginLogPageView:@"更多话题"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"更多话题"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"热门话题";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    _dataArr = [[NSMutableArray alloc] init];
    [_myTableView registerNib:[UINib nibWithNibName:@"HTListCell" bundle:nil] forCellReuseIdentifier:@"HTListCell"];
    __weak __typeof(self) weakSelf = self;
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf request_Api];
    }];
    
    _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf request_MoreApi];
    }];
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    [self request_Api];
    
}

- (void)request_Api {
    _page = 1;
    [_dataArr removeAllObjects];
    __weak UITableView *tableView = self.myTableView;
    
    
    NSDictionary *dic = @{@"iface":@"DMHY200017",@"current":@"1"};
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [HTListMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.talkList];
        [tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    }];
}

- (void)request_MoreApi {
    __weak UITableView *tableView = self.myTableView;
    _page++;
    NSDictionary *dic = @{@"iface":@"DMHY200013",@"current":[NSString stringWithFormat:@"%li",(long)_page]};
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [HTListMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.talkList];
        [tableView reloadData];
        if (_mode.talkList.count < 10) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        [tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HTListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTListCell"];
    cell.mode = _dataArr[indexPath.section];
    if (_dataArr[indexPath.section].talkContent.length == 0) {
        
    } else {
        [UILabel changeLineSpaceForLabel:cell.contentLable WithSpace:5.0];
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HTDetailsViewController *htDetailsVC = [[HTDetailsViewController alloc] initWithNibName:@"HTDetailsViewController" bundle:nil];
    htDetailsVC.talkId = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section].talkId];
    [self.navigationController pushViewController:htDetailsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
