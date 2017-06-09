//
//  MessageController.m
//  douMiApp
//
//  Created by ydz on 2016/11/9.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MessageController.h"
//#import "DM_MessageCell.h"
#import "MessageMode.h"
#import "RWebViewConreoller.h"
#import "MagScreenCell.h"
#import "DM_MessageNewCell.h"
@interface MessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) MessageMode *mode;
@property (assign, nonatomic) NSInteger page;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITableView *popTableView;
@property (strong, nonatomic) NSMutableArray <Hotnewslist*>*dataArr;

@property (strong, nonatomic) NSArray *strArr;
@property (assign, nonatomic) NSInteger locationCell;
@property (copy, nonatomic) NSString *str;

@end

@implementation MessageController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
     [MobClick beginLogPageView:@"更多资讯"];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"更多资讯"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _strArr = @[@"全部新闻",@"星闻联播",@"主播天地",@"热点资讯",@"粉丝投稿"];
//    _locationCell = 0;
    _str = @"0";
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    _dataArr = [[NSMutableArray alloc] init];
    _page = 1;
//    [self addItem:item_left btnTitle:nil viewTitle:@"八头条"];
////    [self addItem:item_right btnTitle:@"loudou" viewTitle:nil];
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    [self addItem:nitem_right btnTitleArr:@[@"loudou"]];
    self.lable.text = @"八头条";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    [_myTableView registerNib:[UINib nibWithNibName:@"DM_MessageNewCell" bundle:nil] forCellReuseIdentifier:@"DM_MessageNewCell"];
    [_popTableView registerNib:[UINib nibWithNibName:@"MagScreenCell" bundle:nil] forCellReuseIdentifier:@"MagScreenCell"];
    __weak __typeof(self) weakSelf = self;
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf request_Api:_str];
    }];
    
    _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf request_MoreApi:_str];
    }];
    [self request_Api:_str];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBack:)];
    [_backView addGestureRecognizer:tap];
    
    
}

- (void)tapBack:(UITapGestureRecognizer *)tap {
    _backView.hidden =YES;
    _popTableView.hidden = YES;
}

- (void)showRightView:(UIButton *)btn {
    _backView.hidden =NO;
    _popTableView.hidden = NO;
    
    
}


- (void)request_Api:(NSString *)type {
    _page = 1;
    [_dataArr removeAllObjects];
    __weak UITableView *tableView = self.myTableView;

    
    NSDictionary *dic = @{@"iface":@"DMHY200013",@"current":@"1",@"type":type};
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [MessageMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.hotNewsList];
        [tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
        [tableView setContentOffset:CGPointMake(0,0) animated:NO];
        if (_mode.hotNewsList.count == 0) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            [tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    }];
}

- (void)request_MoreApi:(NSString *)type {
    __weak UITableView *tableView = self.myTableView;
    _page++;
    NSDictionary *dic = @{@"iface":@"DMHY200013",@"current":[NSString stringWithFormat:@"%li",(long)_page],@"type":type};
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [MessageMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.hotNewsList];
        [tableView reloadData];
        if (_mode.hotNewsList.count == 0) {
             [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            
           [tableView.mj_footer endRefreshing];
        }
       
    } failure:^(NSError *error) {
        [tableView.mj_footer endRefreshing];
    }];

}

#pragma mark - tableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == _myTableView) {
        return _dataArr.count;
    } else {
        return _strArr.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == _myTableView) {
        DM_MessageNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DM_MessageNewCell"];
        cell.mode = _dataArr[indexPath.section];
        return cell;
    } else {
        MagScreenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MagScreenCell"];
        cell.titleLable.text = _strArr[indexPath.section];
        if (indexPath.section == _locationCell) {
            cell.blueGou.hidden = NO;
        } else {
            cell.blueGou.hidden = YES;
        }
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _myTableView) {
        RWebViewConreoller *webVC = [[RWebViewConreoller alloc] initWithNibName:@"RWebViewConreoller" bundle:nil];
        webVC.titleStr = @"资讯详情";
        webVC.urlStr = [NSString stringWithFormat:NewIP,[NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section].Id]];
        [self.navigationController pushViewController:webVC animated:YES];
    } else {
        _locationCell = indexPath.section;
        [_popTableView reloadData];
        
        if (_locationCell == 0) {
            _str = @"0";
        }
        if (_locationCell == 1) {
            _str = @"3";
        }
        if (_locationCell == 2) {
            _str = @"2";
        }
        if (_locationCell == 3) {
            _str = @"1";
        }
        if (_locationCell == 4) {
            _str = @"4";
        }
        
        [self request_Api:_str];
        _popTableView.hidden = YES;
        _backView.hidden = YES;
    }
    
    
    
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
