//
//  DM_FoundController.m
//  douMiApp
//
//  Created by ydz on 2016/11/16.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_FoundController.h"
#import "noAttentionMode.h"
#import <UIImageView+WebCache.h>
#import "DM_LoginController.h"
#import "InteractViewController.h"
#import "PersonageViewController.h"
#import "TFoundSmallCell.h"
#import "TFoundTableCell.h"
#import "ZuiXinHFCell.h"
#import "FoundHTCell.h"
#import "HTCell.h"
#import "HTPLCell.h"
#import "GDPLCell.h"
#import "ZDPLCell.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import "FoundTuiJianCell.h"

#import "AnchorActionMode.h"
#import "DynamicListMode.h"



#import "DTDetailsViewController.h"
#import "HTListViewController.h"
#import "HTDetailsViewController.h"

#import <UMSocialCore/UMSocialCore.h>

#import <UShareUI/UMSocialUIManager.h>
#import "DTRewardViewController.h"

#import "InteractViewController.h"

@interface DM_FoundController ()<UITableViewDelegate,UITableViewDataSource,ZDPLDelegate,smallCellTouchDelegate,HTFoundDelegate,HTDelegte>
@property (weak, nonatomic) IBOutlet UIImageView *imgBtn1;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtn2;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtn3;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtn4;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtn5;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtn6;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtn7;


@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;



@property (strong, nonatomic)noAttentionMode *mode;

@property (strong, nonatomic)UITableView *myTableView;

@property (assign, nonatomic)NSInteger DynamicPage;

@property (strong, nonatomic)AnchorActionMode *AnchorActionMode;
@property (strong, nonatomic)DynamicListMode *DynamicListMode;

@property (strong, nonatomic) NSMutableArray <Results *>*DynamicListArr;

@property (copy, nonatomic) NSString *sharecontent;

@property (copy, nonatomic) NSString *shareID;

@property (assign, nonatomic) BOOL isThreeM;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSMutableArray *imageArr;

@property (assign, nonatomic) NSInteger zhidin;

@property (copy, nonatomic) NSString *showYBState;

@end

@implementation DM_FoundController


- (void)viewWillAppear:(BOOL)animated {
    [MobClick beginLogPageView:@"发现"];

    
    _DynamicListMode.replyInfo.replyTotalSize = 0;
    if ([BusinessLogic uuid].length == 0) {
        self.myTableView.hidden=YES;
        _btn1.selected = NO;
        _btn2.selected = NO;
        _btn3.selected = NO;
        _btn4.selected = NO;
        _btn5.selected = NO;
        _btn6.selected = NO;
        _btn7.selected = NO;
        [self request_Api];
        
    } else {
        
        NSDictionary *dic = @{@"iface":@"DMHY100012",@"mobile":[BusinessLogic getPhoneNo]};
        [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
            _showYBState = responseObj[@"showYBState"];
            [BusinessLogic setPower:_showYBState];
            
        } failure:^(NSError *error) {
            
        }];
        
        [self request_Attention];
        
    }

    

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"发现"];
}

- (void)request_Attention {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY300014",@"userId":[BusinessLogic uuid]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj[@"attention"]);
        if ([@"1" isEqualToString:responseObj[@"attention"]]) {
            
            self.myTableView.hidden = NO;
            [self createTableView];
            
            
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.myTableView.hidden = YES;
            [self request_Api];
            
        }
        
    } failure:^(NSError *error) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addTite:@"发现"];
//
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    
    _isThreeM = YES;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(action) userInfo:nil repeats:NO];
    
    _imageArr= [[NSMutableArray alloc] init];
    
    for (int i = 1; i<=10; i++) {
        [_imageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"b%d",i]]];
    }
    
}


- (void)request_Api {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = [[NSDictionary alloc] init];
    if (![BusinessLogic uuid]) {
        dic = @{@"iface":@"DMHY300011"};
    } else {
        dic = @{@"iface":@"DMHY300011",@"userId":[BusinessLogic uuid]};
    }
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
//         [MBProgressHUD hideHUDForView:self.view animated:YES];
        _mode = [noAttentionMode  mj_objectWithKeyValues:responseObj];
        [self updateUI];
        
    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)requestFound_Api {
    
    //请求发现数据
    NSDictionary *dic = @{@"iface":@"DMHY300012",@"userId":[BusinessLogic uuid],@"pageNo":@"1"};
    
    
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        _AnchorActionMode = [AnchorActionMode mj_objectWithKeyValues:responseObj];
        
        [self requestDynamic_Api];
    
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
}

- (void)requestDynamic_Api {
    __weak UITableView *tableView = _myTableView;
    
    _DynamicPage = 1;
    _DynamicListArr = [[NSMutableArray alloc] init];
    NSDictionary *dic1 = @{@"iface":@"DMHY300002",@"userId":[BusinessLogic uuid],@"pageNo":@"1"};
    [NetworkRequest post1:serVerIP params:dic1 success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _DynamicListMode = [DynamicListMode mj_objectWithKeyValues:responseObj];
        [_DynamicListArr addObjectsFromArray:_DynamicListMode.effectResults];
        _zhidin = _DynamicListMode.effectResults.count;
        [_DynamicListArr addObjectsFromArray:_DynamicListMode.results];
        [tableView reloadData];
        if (_DynamicListMode.results.count < _DynamicListMode.pageSize) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            // 拿到当前的下拉刷新控件，结束刷新状态
            [tableView.mj_footer endRefreshing];
            
        }
        [tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [tableView.mj_header endRefreshing];
    }];
}

- (void)requestMoreDynamic_Api {
    __weak UITableView *tableView = _myTableView;
    _DynamicPage++;
    NSDictionary *dic1 = @{@"iface":@"DMHY300002",@"userId":[BusinessLogic uuid],@"pageNo":[NSString stringWithFormat:@"%ld",(long)_DynamicPage]};
    [NetworkRequest post1:serVerIP params:dic1 success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        _DynamicListMode = [DynamicListMode mj_objectWithKeyValues:responseObj];
        [_DynamicListArr addObjectsFromArray:_DynamicListMode.results];
        [tableView reloadData];
        if (_DynamicListMode.results.count < _DynamicListMode.pageSize) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            // 拿到当前的下拉刷新控件，结束刷新状态
            [tableView.mj_footer endRefreshing];
            
        }
    } failure:^(NSError *error) {
        
         [tableView.mj_footer endRefreshing];
    }];
    
}

- (void)updateUI {
    [_imgBtn1 sd_setImageWithURL:[NSURL URLWithString:_mode.anchors[0].headImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    [_imgBtn2 sd_setImageWithURL:[NSURL URLWithString:_mode.anchors[1].headImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    [_imgBtn3 sd_setImageWithURL:[NSURL URLWithString:_mode.anchors[2].headImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    [_imgBtn4 sd_setImageWithURL:[NSURL URLWithString:_mode.anchors[3].headImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    [_imgBtn5 sd_setImageWithURL:[NSURL URLWithString:_mode.anchors[4].headImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    [_imgBtn6 sd_setImageWithURL:[NSURL URLWithString:_mode.anchors[5].headImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    [_imgBtn7 sd_setImageWithURL:[NSURL URLWithString:_mode.anchors[6].headImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    _imgBtn1.layer.cornerRadius = 30;
    _imgBtn1.layer.masksToBounds = YES;
    _imgBtn2.layer.cornerRadius = 30;
    _imgBtn2.layer.masksToBounds = YES;
    _imgBtn3.layer.cornerRadius = 30;
    _imgBtn3.layer.masksToBounds = YES;
    _imgBtn4.layer.cornerRadius = 30;
    _imgBtn4.layer.masksToBounds = YES;
    _imgBtn5.layer.cornerRadius = 30;
    _imgBtn5.layer.masksToBounds = YES;
    _imgBtn6.layer.cornerRadius = 30;
    _imgBtn6.layer.masksToBounds = YES;
    _imgBtn7.layer.cornerRadius = 30;
    _imgBtn7.layer.masksToBounds = YES;
    
    [_btn1 setTitle:_mode.anchors[0].uname forState:UIControlStateNormal];
    [_btn2 setTitle:_mode.anchors[1].uname forState:UIControlStateNormal];
    [_btn3 setTitle:_mode.anchors[2].uname forState:UIControlStateNormal];
    [_btn4 setTitle:_mode.anchors[3].uname forState:UIControlStateNormal];
    [_btn5 setTitle:_mode.anchors[4].uname forState:UIControlStateNormal];
    [_btn6 setTitle:_mode.anchors[5].uname forState:UIControlStateNormal];
    [_btn7 setTitle:_mode.anchors[6].uname forState:UIControlStateNormal];
}

- (IBAction)AttentionTouch:(UIButton *)sender {
    
    if ([BusinessLogic uuid].length == 0) {
        [self.navigationController pushViewController:[[DM_LoginController alloc]init] animated:YES];
    } else {
    
        [self requestAttention_Api];
    }
    
}

- (void)requestAttention_Api{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY300001",@"userId":[BusinessLogic uuid],@"anchorIds":[NSString stringWithFormat:@"%li,%li,%li,%li,%li,%li,%li",(long)_mode.anchors[0].Id,(long)_mode.anchors[1].Id,(long)_mode.anchors[2].Id,(long)_mode.anchors[3].Id,(long)_mode.anchors[4].Id,(long)_mode.anchors[5].Id,(long)_mode.anchors[6].Id]};
    
    
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.myTableView.hidden = NO;
        [self createTableView];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (IBAction)tagTouch:(UIButton *)sender {
    
    if ([BusinessLogic uuid].length == 0) {
        [self.navigationController pushViewController:[[DM_LoginController alloc]init] animated:YES];
    } else {
        if (!sender.selected) {
            [self requestTag_Api:sender];
        } else {
            [self request_Quxiao:sender];
        }
    }
    
    
}

- (void)request_Quxiao:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY400015",@"userId":[BusinessLogic uuid],@"anchored":[NSString stringWithFormat:@"%li",(long)_mode.anchors[sender.tag-10].Id]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@",responseObj);
        sender.selected = NO;
        //        [LCProgressHUD showMessage:responseObj[@"resmsg"]];
    } failure:^(NSError *error) {
        //        sender.selected = YES;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)requestTag_Api:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY300001",@"userId":[BusinessLogic uuid],@"anchorIds":[NSString stringWithFormat:@"%li",(long)_mode.anchors[sender.tag-10].Id]};
    NSLog(@"%li",(long)_mode.anchors[sender.tag-10].Id);
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@",responseObj);
        sender.selected = YES;
//        [LCProgressHUD showMessage:responseObj[@"resmsg"]];
    } failure:^(NSError *error) {
//        sender.selected = YES;
          [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

}


- (void)createTableView {
    [self.view addSubview:self.myTableView];
    [self requestFound_Api];
    
    
}


- (void)action{
    _isThreeM = NO;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [_myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-60) style:UITableViewStyleGrouped];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerNib:[UINib nibWithNibName:@"TFoundTableCell" bundle:nil] forCellReuseIdentifier:@"TFoundTableCell"];    [_myTableView registerNib:[UINib nibWithNibName:@"FoundHTCell" bundle:nil] forCellReuseIdentifier:@"FoundHTCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"ZuiXinHFCell" bundle:nil] forCellReuseIdentifier:@"ZuiXinHFCell"];
        [_myTableView registerClass:[HTCell class] forCellReuseIdentifier:@"HTCell"];
        [_myTableView registerClass:[HTPLCell class] forCellReuseIdentifier:@"HTPLCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"GDPLCell" bundle:nil] forCellReuseIdentifier:@"GDPLCell"];
        [_myTableView registerClass:[ZDPLCell class] forCellReuseIdentifier:@"ZDPLCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"FoundTuiJianCell" bundle:nil] forCellReuseIdentifier:@"FoundTuiJianCell"];
        
        __weak __typeof(self) weakSelf = self;
//        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf requestDynamic_Api];
//        }];
        
        _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestMoreDynamic_Api];
        }];
        
    }
    return _myTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 3){
        return 1;
    } else {
        return _DynamicListArr[section-3].comments.count+2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _DynamicListArr.count+3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section==2) {
        return 0.01;
    } else {
    return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (_isThreeM) {
            if (_AnchorActionMode.results.count<=3) {
                return 40+_AnchorActionMode.results.count*80;
            } else {
                return 280;
            }
        } else {
            return 40;
        }
        
    } else if (indexPath.section == 1){
        return 100;
    } else if (indexPath.section == 2) {
        if (_DynamicListMode.replyInfo.replyTotalSize == 0) {
          return 0.01;
        }else {
            return 80;
        }
        
    } else {
        if (indexPath.row == 0) {
            return [HTCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
        } else if (indexPath.row < _DynamicListArr[indexPath.section-3].comments.count+1) {
            return [HTPLCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
        } else {
            return 32;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TFoundTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TFoundTableCell"];
//        [cell request_Api];
        cell.dataArr = [[NSMutableArray alloc] init];
        [cell.dataArr addObjectsFromArray:_AnchorActionMode.results];;
        cell.zhiboNumber.text = [NSString stringWithFormat:@"正在直播中(%ld)",(long)_AnchorActionMode.totalRecord];
        
        
        cell.liveImage.animationImages = _imageArr; //动画图片数组
        cell.liveImage.animationDuration = 1; //执行一次完整动画所需的时长
        cell.liveImage.animationRepeatCount = 10000000;  //动画重复次数
        [cell.liveImage startAnimating];
        
        [cell.myTableView reloadData];
        if (_AnchorActionMode.results.count < _AnchorActionMode.pageSize) {
            [cell.myTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            // 拿到当前的下拉刷新控件，结束刷新状态
            [cell.myTableView.mj_footer endRefreshing];
            
        }
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 1) {
        FoundHTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoundHTCell"];
        if (_DynamicListMode.talkList.count > 0) {
            
            [cell.hotHT1 setTitle:_DynamicListMode.talkList[0].talkTitle forState:UIControlStateNormal];
        }
        if (_DynamicListMode.talkList.count > 1) {
            [cell.hotHT2 setTitle:_DynamicListMode.talkList[1].talkTitle forState:UIControlStateNormal];
        }
        if (_DynamicListMode.talkList.count > 2) {
            [cell.hotHT3 setTitle:_DynamicListMode.talkList[2].talkTitle forState:UIControlStateNormal];
        }
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 2) {
        ZuiXinHFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZuiXinHFCell"];
        if (_DynamicListMode.replyInfo.replyTotalSize == 0) {
            cell.backView.hidden = YES;
        } else {
            cell.backView.hidden = NO;
        }
        cell.numberLable.text = [NSString stringWithFormat:@"%ld条最新回复",(long)_DynamicListMode.replyInfo.replyTotalSize];
        [cell.icImage sd_setImageWithURL:[NSURL URLWithString:_DynamicListMode.replyInfo.lastHeadImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
        return cell;
    } else {
        if (indexPath.row == 0) {
            HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
//             [cell.btn1 setImage:[[UIImage imageNamed:@"find_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"操作"] forState:UIControlStateNormal];
            cell.resultsMode = _DynamicListArr[indexPath.section-3];
            cell.ID = indexPath.section-3;
            cell.delegate = self;
            return cell;
        } else if (indexPath.row < _DynamicListArr[indexPath.section-3].comments.count) {
            HTPLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTPLCell"];
            cell.mode = _DynamicListArr[indexPath.section-3].comments[indexPath.row-1];
            
            return cell;
        } else  {
            ZDPLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDPLCell"];
            cell.zanNumber = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[indexPath.section-3].thumbUpNum];
            cell.plNumber = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[indexPath.section-3].commentTotalSize];
            cell.Id = indexPath.section-3;
            cell.ifZan =_DynamicListArr[indexPath.section-3].thumbUpStatus;
            [cell.myCollec reloadData];
            cell.delegate = self;
            return cell;
        }

    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        _isThreeM = !_isThreeM;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [_myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    
    if (indexPath.section == 2) {
        InteractViewController *interactVC = [[InteractViewController alloc] initWithNibName:@"InteractViewController" bundle:nil];
        [self.navigationController pushViewController:interactVC animated:YES];
    }
    
    
    if (indexPath.section >= 3) {
        DTDetailsViewController *dtDetailsVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
        dtDetailsVC.type = @"dt";
        dtDetailsVC.ID = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[indexPath.section-3].Id];
        dtDetailsVC.zanNumber = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[indexPath.section-3].thumbUpNum];
        dtDetailsVC.commentNumber =[NSString stringWithFormat:@"%ld",(long)_DynamicListArr[indexPath.section-3].commentTotalSize];
        [self.navigationController pushViewController:dtDetailsVC animated:YES];
    }
    
}

//分享
- (void)btn1Delegate:(NSInteger)ID {
    [self showActionSheet:ID];
    
    
}

- (void)showActionSheet:(NSInteger)ID {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"您好" message:@"可以进行如下操作" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        //分享
        __weak typeof(self) weakSelf = self;
        //显示分享面板
        _sharecontent = _DynamicListArr[ID].content;
        _shareID = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[ID].Id];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            [weakSelf shareWebPageToPlatformType:platformType];
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
        }else {
        
        [NetworkRequest post1:serVerIP params:@{@"iface":@"DMHY100019",@"articleId":[NSString stringWithFormat:@"%ld",(long)_DynamicListArr[ID].Id],@"articleSource":@"0",@"reporterId":[BusinessLogic uuid]} success:^(id responseObj) {
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
    
    // 添加按钮 将按钮添加到UIAlertController对象上
    [actionSheet addAction:shareAction];
    [actionSheet addAction:reportAction];
    [actionSheet addAction:cancelAction];
    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}


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

//正在直播
- (void)smallTouchID:(NSInteger)ID {
    
    
    
    PersonageViewController *PersonageVC = [[PersonageViewController alloc] initWithNibName:@"PersonageViewController" bundle:nil];
    PersonageVC.UUID = [NSString stringWithFormat:@"%ld",(long)ID];
        [self.navigationController pushViewController:PersonageVC animated:YES];
   
    
}

- (void)icDelegate:(NSInteger)ID {
//    if (ID < _zhidin) {
//        
//    } else {
    PersonageViewController *PersonageVC = [[PersonageViewController alloc] initWithNibName:@"PersonageViewController" bundle:nil];
    PersonageVC.UUID = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[ID].anchorId];
    [self.navigationController pushViewController:PersonageVC animated:YES];
// }
}

//热门话题
- (void)HotHTDelegate:(UIButton *)ID {
    if (ID.tag == 20003) {
        HTListViewController *htListVC = [[HTListViewController alloc] initWithNibName:@"HTListViewController" bundle:nil];
        [self.navigationController pushViewController:htListVC animated:YES];
    } else {
        if (ID.tag == 20000) {
            if (_DynamicListMode.talkList.count > 0) {
                [self pushHTDetails:_DynamicListMode.talkList[0].talkId];
            } else {
                
            }
        }
        if (ID.tag == 20001) {
            if (_DynamicListMode.talkList.count > 1) {
                [self pushHTDetails:_DynamicListMode.talkList[1].talkId];
            } else {
                
            }
        }
        if (ID.tag == 20002) {
            if (_DynamicListMode.talkList.count > 2) {
                [self pushHTDetails:_DynamicListMode.talkList[2].talkId];
            } else {
                
            }
        }
    
    }

}

- (void)pushHTDetails:(NSString *)talkId {
    
    HTDetailsViewController *htDetailsVC = [[HTDetailsViewController alloc] initWithNibName:@"HTDetailsViewController" bundle:nil];
    htDetailsVC.talkId = talkId;
    [self.navigationController pushViewController:htDetailsVC animated:YES];
}

//点赞 打赏 评论
- (void)CollecIndex:(NSInteger)index ID:(NSInteger)Id{
    if (index == 0) {//点赞
        [MobClick event:@"dynamicLike"];
        if ([BusinessLogic uuid].length == 0) {
            DM_LoginController *logVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
            [self.navigationController pushViewController:logVC animated:YES];
        } else {
            __weak UITableView *tableView = _myTableView;
            NSDictionary *dic = @{@"iface":@"DMHY300003",@"userId":[BusinessLogic uuid],@"dynId":[NSString stringWithFormat:@"%ld",(long)_DynamicListArr[Id].Id],@"type":@"1"};
            if (_DynamicListArr[Id].thumbUpStatus == 0) {
                [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
                    _DynamicListArr[Id].thumbUpStatus = 1;
                    _DynamicListArr[Id].thumbUpNum++;
                    [tableView reloadData];
                    if ([[BusinessLogic isAllow] isEqualToString:@"Y"]) {
                        if ([[BusinessLogic isFirst] isEqualToString:@"Y"]) {
                            [NetworkRequest post1:serVerIP params:@{@"iface":@"DMHY100013",@"userId":[BusinessLogic uuid],@"apptime":[BusinessLogic openNum]} success:^(id responseObj) {
                                if ([responseObj[@"play"] isEqualToString:@"1"]) {
                                    [self showTeaseAlert];
                                } else {
                                    NSLog(@"不弹");
                                }
                            } failure:^(NSError *error) {
                                NSLog(@"不弹");
                            }];
                            
                            
                        }
                    }
                    
                    
                    
                } failure:^(NSError *error) {
                    
                }];
            } else {
                [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
                    _DynamicListArr[Id].thumbUpStatus = 0;
                    _DynamicListArr[Id].thumbUpNum--;
                    [tableView reloadData];
                } failure:^(NSError *error) {
                    
                }];
            }
            
        }
        
        
        
        
    }
    if (index == 2) {//评论
        
        DTDetailsViewController *dtDetailsVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
        dtDetailsVC.type = @"dt";
        dtDetailsVC.ID = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[Id].Id];
        dtDetailsVC.zanNumber = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[Id].thumbUpNum];
        dtDetailsVC.commentNumber =[NSString stringWithFormat:@"%ld",(long)_DynamicListArr[Id].commentTotalSize];
        [self.navigationController pushViewController:dtDetailsVC animated:YES];
    }
    
    if (index == 1) { // 打赏
//        [self showAlertWithTitle:@"温馨提示" message:@"此功能暂未开通" handler:nil];
        
        if ([BusinessLogic uuid].length == 0) {
            DM_LoginController *logVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
            [self.navigationController pushViewController:logVC animated:YES];
            
        } else {
            
            if ([[BusinessLogic power] isEqualToString:@"Y"]) {
                DTRewardViewController *controller = [[DTRewardViewController alloc] init];
                controller.anchorId = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[Id].anchorId];
                controller.dynId = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[Id].Id];
                controller.channel = @"0";
                [self presentViewController:controller animated:YES completion:nil];
            } else {
                DTDetailsViewController *dtDetailsVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
                dtDetailsVC.type = @"dt";
                dtDetailsVC.ID = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[Id].Id];
                dtDetailsVC.zanNumber = [NSString stringWithFormat:@"%ld",(long)_DynamicListArr[Id].thumbUpNum];
                dtDetailsVC.commentNumber =[NSString stringWithFormat:@"%ld",(long)_DynamicListArr[Id].commentTotalSize];
                [self.navigationController pushViewController:dtDetailsVC animated:YES];
            }
            
            
//            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}


//话题标签
- (void)talkDelegate:(NSInteger)ID {
    HTDetailsViewController *htDetailsVC = [[HTDetailsViewController alloc] initWithNibName:@"HTDetailsViewController" bundle:nil];
    htDetailsVC.talkId = _DynamicListArr[ID].talkDetail.talkId;
    [self.navigationController pushViewController:htDetailsVC animated:YES];
    
}


- (void)showTeaseAlert;
{
    [BusinessLogic setIsFirst:@"N"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"豆蜜好用吗?快来吐槽吧" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"我要吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/%E8%B1%86%E8%9C%9C/id1186113028?mt=8"];
        [[UIApplication sharedApplication] openURL:url];
        [BusinessLogic setIsAllow:@"N"];
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"再用用看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BusinessLogic setIsAllow:@"Y"];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"不再提示" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BusinessLogic setIsAllow:@"N"];
        
    }];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
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
