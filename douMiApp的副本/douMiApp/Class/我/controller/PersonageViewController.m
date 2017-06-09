//
//  PersonageViewController.m
//  douMiApp
//
//  Created by ydz on 2016/11/23.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "PersonageViewController.h"
#import "InteractViewController.h"
#import "PersonalFileController.h"
#import "IssueViewController.h"
#import "PersonageCell.h"
#import "FenSiCell.h"
#import "ZuiXinHFCell.h"
#import "HTCell.h"
#import "HTPLCell.h"
#import "GDPLCell.h"
#import "ZDPLCell.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import "PersonalMode.h"
#import "UIButton+WebCache.h"
#import "DTDetailsViewController.h"
#import "InteractViewController.h"
#import "DM_LoginController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <IQKeyboardManager.h>
#import <UShareUI/UMSocialUIManager.h>
#import "DTRewardViewController.h"
#import "UGCViewController.h"
#import "HTDetailsViewController.h"
@interface PersonageViewController ()<UITableViewDataSource,UITableViewDelegate,ZDPLDelegate,HTDelegte,fenSiDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *function_Btn;
/** 导航条View */
@property (nonatomic, weak) UIView *navBarView;

@property (nonatomic, strong) PersonalMode *mode;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray <Dynamiclist*>*dataArr;

@property (copy, nonatomic) NSString *sharecontent;

@property (copy, nonatomic) NSString *shareID;

@end

@implementation PersonageViewController

- (UIView *)navBarView {
    if (!_navBarView) {
        UIView *navBarView = [[UIView alloc] init];
        navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        [self.view addSubview:navBarView];
        self.navBarView = navBarView;
    }
    return _navBarView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > 10) {
        
        self.navBarView.backgroundColor = RGBA(0, 0, 0, 0.8);
        
    } else {
        self.navBarView.backgroundColor = RGBA(0, 0, 0, 0);
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.hidesBackButton = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    __weak __typeof(self) weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf request_Api];
    });
    [MobClick beginLogPageView:@"个人展示页"];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    [MobClick endLogPageView:@"个人展示页"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
    [self addItem:nitem_left btnTitleArr:@[@"BackW"]];
    self.lable.text = _mode.nickName;
    _mode.replyInfo.replyTotalSize = 0;
    [_myTableView registerNib:[UINib nibWithNibName:@"PersonageCell" bundle:nil] forCellReuseIdentifier:@"PersonageCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"FenSiCell" bundle:nil] forCellReuseIdentifier:@"FenSiCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"ZuiXinHFCell" bundle:nil] forCellReuseIdentifier:@"ZuiXinHFCell"];
    [_myTableView registerClass:[HTCell class] forCellReuseIdentifier:@"HTCell"];
    [_myTableView registerClass:[HTPLCell class] forCellReuseIdentifier:@"HTPLCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"GDPLCell" bundle:nil] forCellReuseIdentifier:@"GDPLCell"];
    [_myTableView registerClass:[ZDPLCell class] forCellReuseIdentifier:@"ZDPLCell"];
    
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    __weak __typeof(self) weakSelf = self;
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf request_Api];
    }];
    
    //_myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
      //  [weakSelf request_MoreApi];
    //}];
   
     MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(request_MoreApi)];
    [footer setTitle:@"已经没有更多了哦~" forState:MJRefreshStateNoMoreData];
    // 设置footer
    _myTableView.mj_footer = footer;
    
    if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
        self.function_Btn.hidden = NO;
    } else {
        self.function_Btn.hidden = YES;
    }
    
    
    
    
    
}

- (void)request_Api {
    __weak UITableView *tableView = _myTableView;
    _page = 1;
    _dataArr = [[NSMutableArray alloc] init];
    NSDictionary *dic;
    if ([BusinessLogic uuid].length == 0) {
        dic = @{@"iface":@"DMHY200007",@"anchorId":_UUID,@"current":[NSString stringWithFormat:@"%ld",(long)_page]};
    } else {
        dic = @{@"iface":@"DMHY200007",@"userId":[BusinessLogic uuid],@"anchorId":_UUID,@"current":[NSString stringWithFormat:@"%ld",(long)_page]};
    }
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [PersonalMode mj_objectWithKeyValues:responseObj];
        NSLog(@"%@",responseObj);
        self.lable.text = _mode.nickName;
        if ([_mode.role isEqualToString:@"1"]) {
            if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
                
            } else {
                [self addItem:nitem_right btnTitleArr:@[@"xiaoxi2"]];
            }
        }
        
        [_dataArr addObjectsFromArray:_mode.dynamicList];
        [tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
        if (_mode.dynamicList.count < 5) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    }];
    
    

}

- (void)request_MoreApi {
    __weak UITableView *tableView = _myTableView;
    _page++;
    NSDictionary *dic;
    if ([BusinessLogic uuid].length == 0) {
        dic = @{@"iface":@"DMHY200007",@"anchorId":_UUID,@"current":[NSString stringWithFormat:@"%ld",(long)_page]};
    } else {
        dic = @{@"iface":@"DMHY200007",@"userId":[BusinessLogic uuid],@"anchorId":_UUID,@"current":[NSString stringWithFormat:@"%ld",(long)_page]};
    }
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [PersonalMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.dynamicList];
        [tableView reloadData];
        if (_mode.dynamicList.count < 5) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        
    }];

}

#pragma tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        if ([_mode.role isEqualToString:@"0"]) {
            if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
                return 1;
            } else {
                return 2;
            }
        } else {
            return 1;
        }
        
    } else if (section == 2) {
        
        if ([_mode.role isEqualToString:@"0"]) {
            return 2;
        } else {
            if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
                return 1;
            } else {
                return 2;
            }
        }
    
    } else {
        return 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([_mode.role isEqualToString:@"0"]) {
        if ([[BusinessLogic uuid] isEqualToString:_UUID] ) {
            return _dataArr.count+2;
        } else {
            return _dataArr.count+1;
        }
    } else {
        if ([[BusinessLogic uuid] isEqualToString:_UUID] ) {
            return _dataArr.count+3;
        } else {
            return _dataArr.count+2;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
//    if (section == 1) {
//        if ([_mode.role isEqualToString:@"1"]) {
//            return 0.01;
//        } else {
//            return 10;
//        }
//    } else {
        return 10;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return SCREEN_WIDTH*280/375;
    } else if(indexPath.section == 1){
        if ([_mode.role isEqualToString:@"0"]) {
            if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
                if (_mode.replyInfo.replyTotalSize == 0) {
                    return 0.01;
                } else {
                    return 60;
                }
                
            } else {
                if (indexPath.row == 0) {
                    return [HTCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
                } else {
                    return 32;
                }
            }
        } else {
            return 100;
        }
    } else if(indexPath.section == 2) {
        if ([_mode.role isEqualToString:@"0"]) {
                if (indexPath.row == 0) {
                    return [HTCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
                } else {
                    return 32;
                }
        } else {
            if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
                if (_mode.replyInfo.replyTotalSize == 0) {
                    return 0.01;
                } else {
                    return 60;
                }
            } else {
                if (indexPath.row == 0) {
                    return [HTCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
                } else {
                    return 32;
                }
            }
        }
    } else {
        if (indexPath.row == 0) {
            return [HTCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
        } else {
            return 32;
        }
    
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        PersonageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonageCell"];
        if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
            cell.GXText.editable = YES;
            cell.juBaoBtn.hidden = YES;
        } else {
            cell.GXText.editable = NO;
            
            if ([[BusinessLogic getPhoneNo] isEqualToString:@"18611648317"]) {
                cell.juBaoBtn.hidden = NO;
            } else {
                cell.juBaoBtn.hidden = YES;
            }
            
        }
        [cell.juBaoBtn addTarget:self action:@selector(juBaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        cell.GXText.delegate = self;
        if ([_mode.role isEqualToString:@"0"]) {
            cell.isZhiBoBtn.hidden = YES;
            cell.isZhiBoLAble.hidden = YES;
            cell.YYHome.hidden = YES;
            cell.lineView.hidden = YES;
            [cell.icimage sd_setBackgroundImageWithURL:[NSURL URLWithString:_mode.imgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userdog"]];
        } else {
            cell.isZhiBoLAble.hidden = NO;
            cell.isZhiBoBtn.hidden = NO;
            cell.YYHome.hidden = NO;
            cell.lineView.hidden = NO;
            if ([_mode.isOnline isEqualToString:@"0"]) {
                cell.isZhiBoLAble.text = @"未直播";
                [cell.isZhiBoBtn setBackgroundImage:[UIImage imageNamed:@"zhubo_unplay"] forState:UIControlStateNormal];
            } else {
                cell.isZhiBoLAble.text = @"直播中";
                [cell.isZhiBoBtn setBackgroundImage:[UIImage imageNamed:@"play3"] forState:UIControlStateNormal];
            }
            cell.YYHome.text = [NSString stringWithFormat:@"YY直播号:%@",_mode.yyAcount];
            [cell.icimage sd_setBackgroundImageWithURL:[NSURL URLWithString:_mode.imgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userdog"]];
            
        }
        if ([_mode.isGuanZhu isEqualToString:@"0"]) {
            cell.isGuanZhuBtn.selected = NO;
        } else {
            cell.isGuanZhuBtn.selected = YES;
        }
//        if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
//            cell.isGuanZhuBtn.enabled = NO;
//        } else {
//            cell.isGuanZhuBtn.enabled = YES;
//        }
        [cell.isGuanZhuBtn addTarget:self action:@selector(isGuanZhuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.isGuanZhuLable.text = _mode.likeNum;
        cell.GXText.text = _mode.introduction.length == 0?@"这个人很懒，什么都没有留下":_mode.introduction;
        return cell;
    } else if (indexPath.section == 1) {
        if ([_mode.role isEqualToString:@"0"]) {
            if ([[BusinessLogic uuid] isEqualToString:_UUID] ) {
                ZuiXinHFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZuiXinHFCell"];
                if (_mode.replyInfo.replyTotalSize == 0) {
                    cell.backView.hidden = YES;
                } else {
                    cell.backView.hidden = NO;
                }
                [cell.icImage sd_setImageWithURL:[NSURL URLWithString:_mode.replyInfo.lastHeadImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
                cell.numberLable.text = [NSString stringWithFormat:@"%ld条最新回复",(long)_mode.replyInfo.replyTotalSize];
                return cell;
            } else {
                if (indexPath.row == 0) {
                    HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
//                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"find_share"] forState:UIControlStateNormal];
//                    [cell.btn1 setImage:[[UIImage imageNamed:@"分享"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"操作"] forState:UIControlStateNormal];
                    cell.dynamicMode = _dataArr[indexPath.section-1];
                    cell.ID = indexPath.section-1;
                    cell.delegate = self;
                    return cell;
                } else {
                    ZDPLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDPLCell"];
                    cell.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-1].zanCount];
                    cell.plNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-1].commentCount];
                    cell.ifZan = _dataArr[indexPath.section-1].ifZan;
                    cell.Id = indexPath.section-1;
                    [cell.myCollec reloadData];
                    cell.delegate = self;
                    return cell;
                }
            }
        } else {
            FenSiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FenSiCell"];
            cell.delegate = self;
            cell.dataArr = _mode.UserImgUrlLsit;
            NSLog(@"%d",cell.dataArr.count);
            [cell.myCollec reloadData];
            return cell;
        }
        
    } else if (indexPath.section == 2){
        
        if ([_mode.role isEqualToString:@"0"]) {
            if (indexPath.row == 0) {
                HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
                if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
//                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
//                    [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"find_share"] forState:UIControlStateNormal];
                    
//                    [cell.btn1 setImage:[[UIImage imageNamed:@"垃圾桶"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//                    [cell.btn2 setImage:[[UIImage imageNamed:@"分享"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"操作"] forState:UIControlStateNormal];
                    
//                    [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
                    cell.dynamicMode = _dataArr[indexPath.section-2];
                    cell.ID = indexPath.section-2;
                } else {
//                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"find_share"] forState:UIControlStateNormal];
//                    [cell.btn1 setImage:[[UIImage imageNamed:@"分享"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                    
                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"操作"] forState:UIControlStateNormal];
                    
                    
                    
                    cell.dynamicMode = _dataArr[indexPath.section-1];
                    cell.ID = indexPath.section-1;
                }
                cell.delegate = self;
                return cell;
            } else {
                ZDPLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDPLCell"];
                if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
                    cell.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].zanCount];
                    cell.plNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].commentCount];
                    cell.Id = indexPath.section-2;
                    cell.ifZan = _dataArr[indexPath.section-2].ifZan;
                    
                } else {
                    cell.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-1].zanCount];
                    cell.plNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-1].commentCount];
                    cell.Id = indexPath.section-1;
                    cell.ifZan = _dataArr[indexPath.section-1].ifZan;
                }
                [cell.myCollec reloadData];
                cell.delegate = self;
                return cell;
            }
        } else {
            if ([[BusinessLogic uuid] isEqualToString:_UUID] ) {
                ZuiXinHFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZuiXinHFCell"];
                if (_mode.replyInfo.replyTotalSize == 0) {
                    cell.backView.hidden = YES;
                } else {
                    cell.backView.hidden = NO;
                }
                [cell.icImage sd_setImageWithURL:[NSURL URLWithString:_mode.replyInfo.lastHeadImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
                cell.numberLable.text = [NSString stringWithFormat:@"%ld条最新回复",(long)_mode.replyInfo.replyTotalSize];
                return cell;
            } else {
                if (indexPath.row == 0) {
                    HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
//                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"find_share"] forState:UIControlStateNormal];
//                    [cell.btn1 setImage:[[UIImage imageNamed:@"分享"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"操作"] forState:UIControlStateNormal];
                    
                    cell.dynamicMode = _dataArr[indexPath.section-2];
                    cell.ID = indexPath.section-2;
                    cell.delegate = self;
                    return cell;
                } else {
                    ZDPLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDPLCell"];
                    cell.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].zanCount];
                    cell.plNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].commentCount];
                    cell.Id = indexPath.section-2;
                    cell.ifZan = _dataArr[indexPath.section-2].ifZan;
                    [cell.myCollec reloadData];
                    cell.delegate = self;
                    return cell;
                }
            }
        }
        
        } else {
        if (indexPath.row == 0) {
            HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
            
            if ([_mode.role isEqualToString:@"0"]) {
                if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
//                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
//                    [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"find_share"] forState:UIControlStateNormal];
//                    [cell.btn1 setImage:[[UIImage imageNamed:@"垃圾桶"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//                    [cell.btn2 setImage:[[UIImage imageNamed:@"分享"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                    
                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"操作"] forState:UIControlStateNormal];
                    
//                    [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
                    cell.dynamicMode = _dataArr[indexPath.section-2];
                    cell.ID = indexPath.section-2;
                } else {
//                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"find_share"] forState:UIControlStateNormal];
//                    [cell.btn1 setImage:[[UIImage imageNamed:@"分享"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                    
                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"操作"] forState:UIControlStateNormal];
                    
                    
                    
                    cell.dynamicMode = _dataArr[indexPath.section-1];
                    cell.ID = indexPath.section-1;
                }
                
                
            } else {
                
                if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
//                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
//                    [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"find_share"] forState:UIControlStateNormal];
//                    
//                    [cell.btn1 setImage:[[UIImage imageNamed:@"垃圾桶"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//                    [cell.btn2 setImage:[[UIImage imageNamed:@"分享"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                   [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"操作"] forState:UIControlStateNormal];
                    
//                    [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
                    cell.dynamicMode = _dataArr[indexPath.section-3];
                    cell.ID = indexPath.section-3;
                } else {
//                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"find_share"] forState:UIControlStateNormal];
//                    [cell.btn1 setImage:[[UIImage imageNamed:@"分享"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                   [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"操作"] forState:UIControlStateNormal];
                    
                
                    cell.dynamicMode = _dataArr[indexPath.section-2];
                    cell.ID = indexPath.section-2;
                }
            }
            
            
            
            cell.delegate = self;
            return cell;
        } else {
            ZDPLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDPLCell"];
            
            if ([_mode.role isEqualToString:@"0"]) {
                
                if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
                    cell.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].zanCount];
                    cell.plNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].commentCount];
                    cell.Id = indexPath.section-2;
                    cell.ifZan = _dataArr[indexPath.section-2].ifZan;
                    
                } else {
                    cell.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-1].zanCount];
                    cell.plNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-1].commentCount];
                    cell.Id = indexPath.section-1;
                    cell.ifZan = _dataArr[indexPath.section-1].ifZan;
                }
                
            } else {
            
            if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
                cell.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-3].zanCount];
                cell.plNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-3].commentCount];
                cell.Id = indexPath.section-3;
                cell.ifZan = _dataArr[indexPath.section-3].ifZan;
            } else {
                cell.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].zanCount];
                cell.plNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].commentCount];
                cell.Id = indexPath.section-2;
                cell.ifZan = _dataArr[indexPath.section-2].ifZan;
            }
            }
            [cell.myCollec reloadData];
            cell.delegate = self;
            return cell;
        }
    
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (indexPath.section != 0) {
//        if (indexPath.row == 4) {
//            
//            InteractViewController *interactVC = [[InteractViewController alloc] initWithNibName:@"InteractViewController" bundle:nil];
//            [self.navigationController pushViewController:interactVC animated:YES];
//        }
        
        if ([_mode.role isEqualToString:@"0"]) {
            if ([[BusinessLogic uuid] isEqualToString:_UUID] ) {
                if (indexPath.section == 1) {
                    //回复列表
                    InteractViewController *interactVC = [[InteractViewController alloc] initWithNibName:@"InteractViewController" bundle:nil];
                    [self.navigationController pushViewController:interactVC animated:YES];
                    
                } else {
                    DTDetailsViewController *dtDetailsVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
                    dtDetailsVC.type = @"dt";
                    dtDetailsVC.ID = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].dynId];
                    dtDetailsVC.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].zanCount];
                    dtDetailsVC.commentNumber =[NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].commentCount];
                    [self.navigationController pushViewController:dtDetailsVC animated:YES];
                
                
                }
                
            } else {
                DTDetailsViewController *dtDetailsVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
                dtDetailsVC.type = @"dt";
                dtDetailsVC.ID = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-1].dynId];
                dtDetailsVC.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-1].zanCount];
                dtDetailsVC.commentNumber =[NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-1].commentCount];
                [self.navigationController pushViewController:dtDetailsVC animated:YES];
                
                
            }
        } else {
            if ([[BusinessLogic uuid] isEqualToString:_UUID] ) {
                
                if (indexPath.section == 2) {
                    //回复列表
                    InteractViewController *interactVC = [[InteractViewController alloc] initWithNibName:@"InteractViewController" bundle:nil];
                    [self.navigationController pushViewController:interactVC animated:YES];
                } else if(indexPath.section == 1) {
                    
                    
                } else {
                    DTDetailsViewController *dtDetailsVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
                    dtDetailsVC.type = @"dt";
                    dtDetailsVC.ID = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-3].dynId];
                    dtDetailsVC.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-3].zanCount];
                    dtDetailsVC.commentNumber =[NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-3].commentCount];
                    [self.navigationController pushViewController:dtDetailsVC animated:YES];
                }
                
                
            } else {
                
                if (indexPath.section == 1) {
                    
                } else {
                
                DTDetailsViewController *dtDetailsVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
                dtDetailsVC.type = @"dt";
                dtDetailsVC.ID = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].dynId];
                dtDetailsVC.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].zanCount];
                dtDetailsVC.commentNumber =[NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.section-2].commentCount];
                    [self.navigationController pushViewController:dtDetailsVC animated:YES];
                }
                
            }
        }
        
        
    }
    
}

// 点赞 打赏 评论

- (void)CollecIndex:(NSInteger)index ID:(NSInteger)Id{
    if (index == 0) {
        NSLog(@"赞");
        [MobClick event:@"dynamicLike"];
        if ([BusinessLogic uuid].length == 0) {
            DM_LoginController *dmLoginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
            [self.navigationController pushViewController:dmLoginVC animated:YES];
        } else {
        __weak UITableView *tableView = _myTableView;
        NSDictionary *dic = @{@"iface":@"DMHY300003",@"userId":[BusinessLogic uuid],@"dynId":[NSString stringWithFormat:@"%ld",(long)_dataArr[Id].dynId],@"type":@"1"};
        if (_dataArr[Id].ifZan == 0) {
            [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
                _dataArr[Id].ifZan = 1;
                _dataArr[Id].zanCount++;
                [tableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        } else {
            [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
                _dataArr[Id].ifZan = 0;
                _dataArr[Id].zanCount--;
               [tableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        }
            [self leadAleat];
        }
        
    }
    if (index == 1) { // 打赏
//        [self showAlertWithTitle:@"温馨提示" message:@"此功能暂未开通iopllkjhkjh" handler:nil];
        
        if ([[BusinessLogic power] isEqualToString:@"Y"]) {
            DTRewardViewController *controller = [[DTRewardViewController alloc] init];
            controller.anchorId = [NSString stringWithFormat:@"%ld",(long)_dataArr[Id].anchorId];
            controller.dynId = [NSString stringWithFormat:@"%ld",(long)_dataArr[Id].dynId];
            controller.channel = @"0";
            [self presentViewController:controller animated:YES completion:nil];
        } else {
            DTDetailsViewController *dtDetailsVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
            dtDetailsVC.type = @"dt";
            dtDetailsVC.ID = [NSString stringWithFormat:@"%ld",(long)_dataArr[Id].dynId];
            dtDetailsVC.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[Id].zanCount];
            dtDetailsVC.commentNumber =[NSString stringWithFormat:@"%ld",(long)_dataArr[Id].commentCount];
            [self.navigationController pushViewController:dtDetailsVC animated:YES];
            
        }
    }
    if (index == 2) {
        NSLog(@"评论");
        
        DTDetailsViewController *dtDetailsVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
        dtDetailsVC.type = @"dt";
        dtDetailsVC.ID = [NSString stringWithFormat:@"%ld",(long)_dataArr[Id].dynId];
        dtDetailsVC.zanNumber = [NSString stringWithFormat:@"%ld",(long)_dataArr[Id].zanCount];
        dtDetailsVC.commentNumber =[NSString stringWithFormat:@"%ld",(long)_dataArr[Id].commentCount];
        [self.navigationController pushViewController:dtDetailsVC animated:YES];
        
    }
    
}




- (void)showRightView:(UIButton *)btn {
    
    PersonalFileController *pFileVC = [[PersonalFileController alloc] initWithNibName:@"PersonalFileController" bundle:nil];
    pFileVC.ID = _mode.anchorId;
    [self.navigationController pushViewController:pFileVC animated:YES];
    
}
- (IBAction)functionTouch:(UIButton *)sender {
    [MobClick event:@"dynamicNum"];
    if ([BusinessLogic uuid].length == 0) {
        DM_LoginController *dmLoginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
        [self.navigationController pushViewController:dmLoginVC animated:YES];
    } else {
    
        if ([BusinessLogic UGC].length == 0) {
            if ([[BusinessLogic power] isEqualToString:@"Y"]) {
                IssueViewController *issueVC = [[IssueViewController alloc] initWithNibName:@"IssueViewController" bundle:nil];
                issueVC.type = @"dt";
                [self.navigationController pushViewController:issueVC animated:YES];
            } else {
                UGCViewController *ugc = [[UGCViewController alloc] init];
                [self presentViewController:ugc animated:YES completion:nil];
            }
        } else {
            
            IssueViewController *issueVC = [[IssueViewController alloc] initWithNibName:@"IssueViewController" bundle:nil];
            issueVC.type = @"dt";
            [self.navigationController pushViewController:issueVC animated:YES];
        }
    }
    
}

//分享 删除

//分享 删除

- (void)btn1Delegate:(NSInteger )ID {
    
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"您好" message:@"可以进行如下操作" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        //分享
        __weak typeof(self) weakSelf = self;
        //显示分享面板
        _sharecontent = _dataArr[ID].content;
        _shareID = [NSString stringWithFormat:@"%ld",(long)_dataArr[ID].dynId];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            [weakSelf shareWebPageToPlatformType:platformType];
        }];
        
    }];
    
    
    UIAlertAction *delegateAction = [UIAlertAction actionWithTitle:@"删除" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        //删除
        [self showAlertWithTitle:@"确认删除这条动态" message:nil handler:^(UIAlertAction *action) {
            [self request_DelegateApi:ID];
        }];
        
        
    }];
    
    
    
    UIAlertAction *reportAction = [UIAlertAction actionWithTitle:@"举报" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if ([BusinessLogic uuid].length == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"已举报，受理中" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                
            });
        } else {
        [NetworkRequest post1:serVerIP params:@{@"iface":@"DMHY100019",@"articleId":[NSString stringWithFormat:@"%ld",(long)_dataArr[ID].dynId],@"articleSource":@"0",@"reporterId":[BusinessLogic uuid]} success:^(id responseObj) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"已举报，受理中" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            NSLog(@"%@",responseObj);
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        // 点击按钮后的方法直接在这里面写
    }];
    
    
    
    if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
        //删除
        // 添加按钮 将按钮添加到UIAlertController对象上
        [actionSheet addAction:shareAction];
        [actionSheet addAction:delegateAction];
        [actionSheet addAction:reportAction];
        [actionSheet addAction:cancelAction];
    } else {
        // 添加按钮 将按钮添加到UIAlertController对象上
        [actionSheet addAction:shareAction];
        [actionSheet addAction:reportAction];
        [actionSheet addAction:cancelAction];
    }
    
    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
    [self presentViewController:actionSheet animated:YES completion:nil];
}

//- (void)btn2Delegate:(NSInteger )ID {
//    //分享
//    //分享
//    _sharecontent = _dataArr[ID].content;
//    _shareID = [NSString stringWithFormat:@"%ld",(long)_dataArr[ID].dynId];
//    __weak typeof(self) weakSelf = self;
//    //显示分享面板
//    
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        [weakSelf shareWebPageToPlatformType:platformType];
//    }];
//    
//}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"我分享了一条动态" descr:_sharecontent thumImage:[UIImage imageNamed:@"dog"]];
    //设置网页地址
    shareObject.webpageUrl =[NSString stringWithFormat:DTShareIP,_shareID];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)request_DelegateApi:(NSInteger )ID {
    __weak UITableView *tableView = _myTableView;
    NSDictionary *dic = @{@"iface":@"DMHY300009",@"dynId":[NSString stringWithFormat:@"%ld",(long)_dataArr[ID].dynId],@"flag":@"1"};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        [_dataArr removeObjectAtIndex:ID];
        [tableView reloadData];
        [LCProgressHUD showMessage:@"删除成功"];
    } failure:^(NSError *error) {
        
    }];

}

- (void)isGuanZhuBtnClick:(UIButton *)sender {
    
    [MobClick event:@"attentionNum"];
    
    if ([[BusinessLogic uuid] isEqualToString:_UUID]) {
        
        
    } else {
        NSDictionary *dic;
        if ([BusinessLogic uuid].length == 0) {
            DM_LoginController *dmLoginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
            [self.navigationController pushViewController:dmLoginVC animated:YES];
        } else {
            
            if (sender.selected) {
                dic = @{@"iface":@"DMHY400015",@"userId":[BusinessLogic uuid],@"anchored":_UUID};
            } else {
                dic = @{@"iface":@"DMHY400048",@"userId":[BusinessLogic uuid],@"fansId":_UUID};
            }
            
            [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
                if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
                    sender.selected = !sender.selected;
                    if (sender.selected) {
                        _mode.likeNum = [NSString stringWithFormat:@"%d",[_mode.likeNum integerValue]+1];
                        _mode.isGuanZhu = @"1";
                    } else {
                        _mode.likeNum = [NSString stringWithFormat:@"%d",[_mode.likeNum integerValue]-1];
                        _mode.isGuanZhu = @"0";
                    }
                    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                    [_myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }

    }
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self.view endEditing:YES];
        [self request_FXQM:textView];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView {
    
    
    
        if (textView.text.length > 160) {
            textView.text = [textView.text substringToIndex:160];
        }
    
    

    
}

- (void)request_FXQM:(UITextView *)textView {
    NSDictionary *dic = @{@"iface":@"DMHY400005",@"userId":[BusinessLogic uuid],@"individualitySignature":textView.text};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        
    } failure:^(NSError *error) {
        
    }];
    
    

}

//粉丝点击
- (void)FSCollecIndex:(NSInteger)index {
    
    [self.view endEditing:YES];
    
    if (index < _mode.UserImgUrlLsit.count) {
        _UUID = [NSString stringWithFormat:@"%ld",(long)_mode.UserImgUrlLsit[index].userId];
        [self request_Api];
        [_myTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

//热度点击

- (void)talkDelegate:(NSInteger)ID {
    HTDetailsViewController *htDetailsVC = [[HTDetailsViewController alloc] initWithNibName:@"HTDetailsViewController" bundle:nil];
    htDetailsVC.talkId = _dataArr[ID].talkId;
    [self.navigationController pushViewController:htDetailsVC animated:YES];
    
}

- (void)juBaoBtnClick{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"已举报，受理中" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    });
    
    //    NSDictionary  *dic = @{@"userId":[BusinessLogic uuid],@"iface":@"DMHY400054",@"current":@"1"};
    //    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
    //
    //    } failure:^(NSError *error) {
    //
    //    }];
    
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
