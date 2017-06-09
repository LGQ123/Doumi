//
//  MessageCenterZanViewController.m
//  douMiApp
//
//  Created by edz on 2016/12/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MessageCenterZanViewController.h"
#import "CenterZanCell.h"
#import "MessageModeA.h"
#import "DTDetailsViewController.h"

#define btnW 91
#define btnH 25

@interface MessageCenterZanViewController ()

@property (nonatomic, strong) UIButton *preSelectBtn;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *tableDataArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *pageType; // 2:赞我的  3:我赞的

@end

@implementation MessageCenterZanViewController


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


    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-btnW*2)/2, 0, btnW*2, btnH)];
    topView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = topView;
    
    UIButton *leftBtn = [self getButtonWithBgcolor:RGBA(60, 60, 60, 1) andTag:1 andTitle:@"赞我的" andFrame:CGRectMake(0, 0, btnW, btnH) andTitleColor:RGBA(40, 40, 40, 1) andSelectColor:[UIColor whiteColor] ];
    leftBtn.selected = YES;
    _preSelectBtn = leftBtn;
//    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [topView addSubview:leftBtn];
    
    UIButton *rightBtn = [self getButtonWithBgcolor:[UIColor clearColor] andTag:2 andTitle:@"我赞的" andFrame:CGRectMake(btnW, 0, btnW, btnH) andTitleColor:RGBA(40, 40, 40, 1) andSelectColor:[UIColor whiteColor]];
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.borderColor = RGBA(60, 60, 60, 1).CGColor;
//    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [topView addSubview:rightBtn];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    __weak __typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([weakSelf.pageType isEqualToString:@"2"]) {
            [weakSelf getRefreshOtherZanData];
        } else {
            [weakSelf getRefreshMeZanData];
        }
    }];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        if ([weakSelf.pageType isEqualToString:@"2"]) {
//            [weakSelf getLoadMoreOtherZanData];
//        } else {
//            [weakSelf getLoadMoreMeZanData];
//        }
    }];
    
    _pageType = @"2";
    [self getRefreshOtherZanData];
}


// 顶部导航按钮切换
- (void)zanButtonClick:(UIButton *)button {
    if (button.isSelected) {
        return;
    }
    button.selected = YES;
    button.backgroundColor = RGBA(60, 60, 60, 1);
    _preSelectBtn.backgroundColor = [UIColor clearColor];
    _preSelectBtn.layer.borderColor = RGBA(60, 60, 60, 1).CGColor;
    _preSelectBtn.layer.borderWidth = 1;
    _preSelectBtn.selected = NO;
    _preSelectBtn = button;
    
    if (button.tag == 1) { // 赞我的
        _pageType = @"2";
        [self getRefreshOtherZanData];
    } else { // 我赞的
        _pageType = @"3";
        [self getRefreshMeZanData];
    }
}


// 下拉刷新(赞我的) 不需要分页
- (void)getRefreshOtherZanData {
    [self getRefreshDataWithType:@"2"];
}


// 加载更多(赞我的)
//- (void)getLoadMoreOtherZanData {
//    [self loadMoreDataWithType:@"2"];
//}


// 下拉刷新(我赞的)
- (void)getRefreshMeZanData {
    [self getRefreshDataWithType:@"3"];
}


// 加载更多(我赞的)
//- (void)getLoadMoreMeZanData {
//    [self loadMoreDataWithType:@"3"];
//}


// 下拉刷新
- (void)getRefreshDataWithType:(NSString *)type {
//    _page = 1;
    [_tableDataArr removeAllObjects];
    
    __weak UITableView *weakTableView = _tableView;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY300016" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
    [dic dm_setObject:type forKey:@"type"]; // 2:赞我的  3:我赞的
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        MessageZanListModel *model = [MessageZanListModel mj_objectWithKeyValues:responseObj];
        [_tableDataArr addObjectsFromArray:model.map];
        
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
            [weakTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        
        [weakTableView.mj_header endRefreshing];
        
    }];
}


// 加载更多
//- (void)loadMoreDataWithType:(NSString *)type {
//    _page ++;
//    __weak UITableView *weakTableView = _tableView;
//    
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic dm_setObject:@"DMHY300016" forKey:@"iface"];
//    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
//    [dic dm_setObject:type forKey:@"type"]; // 2:赞我的  3:我赞的
//    
//    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
//        
//        MessageZanListModel *model = [MessageZanListModel mj_objectWithKeyValues:responseObj];
//        [_tableDataArr addObjectsFromArray:model.map];
//        [weakTableView reloadData];
//        
//        if (model.map.count == 0) {
//            [weakTableView.mj_footer endRefreshingWithNoMoreData];
//        } else {
//            [weakTableView.mj_footer endRefreshing];
//        }
//    } failure:^(NSError *error) {
//        [weakTableView.mj_footer endRefreshing];
//        //        _page --;
//    }];
//}


#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableDataArr.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MessageZanModel *model = [_tableDataArr dm_objectAtIndex:indexPath.row]; // _tableDataArr.count > indexPath.row
    
    CenterZanCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CenterZanCell"];
    if (cell == nil) {
        cell = [[CenterZanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CenterZanCell"];
    }
    [cell setItemWithModel:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageZanModel *model = [_tableDataArr dm_objectAtIndex:indexPath.row];
    
    DTDetailsViewController *controller = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
    if ([model.dynType isEqualToString:@"1"]) { // 1:个人动态 2:话题动态
        controller.type = @"dt";
    } else {
        controller.type = @"talkdt";
    }
    controller.ID = model.dynId;
    [self.navigationController pushViewController:controller animated:YES];
}




- (UIButton *)getButtonWithBgcolor:(UIColor *)bgColor andTag:(NSInteger)tag andTitle:(NSString *)title andFrame:(CGRect)rect andTitleColor:(UIColor *)color andSelectColor:(UIColor *)selectColor {
    
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    button.backgroundColor = bgColor;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:selectColor forState:UIControlStateSelected];
    //    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
