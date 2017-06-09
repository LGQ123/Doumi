//
//  DM_MeController.m
//  douMiApp
//
//  Created by ydz on 2016/11/21.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_MeController.h"
#import "DM_MeHomeTCell.h"
#import "DM_MeCollecCell.h"
#import "DM_MeYuECell.h"
#import "DM_LoginController.h"
#import "PersonageViewController.h"
#import "SweepMaViewController.h"
#import "MEHomeMode.h"
#import "MyErWeiMaController.h"
#import "SafetyViewController.h"
#import "SelfSetViewController.h"
#import "MyGZFSViewController.h"
#import "MessageCenterController.h"
#import "MeAnchorViewController.h"
#import "MyAccountController.h"
#import "DMUserDouTicketViewController.h"
#import "DMMeDouJiaViewController.h"
#import "DMMiFenQiViewController.h"
#import "DMUserIdentifyViewController.h"
#import "DMMeXinModel.h"

@interface DM_MeController ()<UITableViewDelegate,UITableViewDataSource,DM_MeHomeTDelegate,MeCollecDelegate,MeYuECollecDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) MEHomeMode *mode;

@property (copy, nonatomic) NSString *showYBState;

@end

@implementation DM_MeController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.hidesBackButton = YES;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    if ([BusinessLogic uuid].length == 0) {
        [_myTableView reloadData];
        _mode = [[MEHomeMode alloc] init];
        _mode.fansNum = @"0";
        _mode.anchorNum = @"0";
        _mode.money = @"0";

    } else {
        
        NSDictionary *dic = @{@"iface":@"DMHY100012",@"mobile":[BusinessLogic getPhoneNo]};
        [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
            _showYBState = responseObj[@"showYBState"];
            [BusinessLogic setPower:_showYBState];
            
        } failure:^(NSError *error) {
            
        }];
        
        [self request_Api];
        
    }
    
    [MobClick beginLogPageView:@"我"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"我"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    
//    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];

//    self.navigationController.navigationBar.translucent = true;
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
    
    [self addItem:nitem_left btnTitleArr:@[@"shezhi"]];
    [self addItem:nitem_right btnTitleArr:@[@"xiaoxi",@"1",@"play-none"]];
    
    self.lable.text = @"个人中心";
    
    [_myTableView registerNib:[UINib nibWithNibName:@"DM_MeHomeTCell" bundle:nil] forCellReuseIdentifier:@"DM_MeHomeTCell"];
    [_myTableView registerClass:[DM_MeCollecCell class] forCellReuseIdentifier:@"DM_MeCollecCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"DM_MeYuECell" bundle:nil] forCellReuseIdentifier:@"DM_MeYuECell"];
    
}

- (void)request_Api {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak UITableView *tableView = _myTableView;
    
    NSDictionary *dic = @{@"iface":@"DMHY400001",@"userId":[BusinessLogic uuid]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _mode = [MEHomeMode mj_objectWithKeyValues:responseObj];
        if ([_mode.role isEqualToString:@"1"]) {
            self.playBtn.hidden = NO;
            if ([_mode.isOnline isEqualToString:@"1"]) {
                self.playBtn.selected = YES;
            } else {
                self.playBtn.selected = NO;
            }
        } else {
            self.playBtn.hidden = YES;
        }
        if([_mode.msgFlag isEqualToString:@"1"]) {
            self.redbtn.selected = NO;
        } else {
            self.redbtn.selected = YES;
        }

        [tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma mark-tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([BusinessLogic uuid].length == 0 || [[BusinessLogic power] isEqualToString:@"N"]) {
        return 2;
    } else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        return SCREEN_WIDTH*240/375;
    } else if(indexPath.section == 1){
        if ([BusinessLogic uuid].length == 0 || [[BusinessLogic power] isEqualToString:@"N"]) {
            return SCREEN_WIDTH/3*2;
        } else {
            return 50;
        }
    } else {
        return SCREEN_WIDTH/3*2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DM_MeHomeTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DM_MeHomeTCell"];
        cell.delegate = self;
        cell.mode = _mode;
        return cell;
    } else if (indexPath.section == 1){
        if ([BusinessLogic uuid].length == 0 || [[BusinessLogic power] isEqualToString:@"N"]) {
            DM_MeCollecCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DM_MeCollecCell"];
            cell.delegate = self;
            if ([_mode.role isEqualToString:@"1"]) {
                cell.dataArr = @[@"个人页",@"豆券",@"我是主播",@"我的二维码",@"扫一扫",@"安全中心"];
            } else {
                cell.dataArr = @[@"个人页",@"豆券",@"我的二维码",@"扫一扫",@"安全中心"];
            }
            [cell.myCollecTV reloadData];
            return cell;
        } else {
            DM_MeYuECell *cell = [tableView dequeueReusableCellWithIdentifier:@"DM_MeYuECell"];
            cell.delegate = self;
//            cell.dataArr = [NSMutableArray arrayWithObjects:_mode.usableAmount,_mode.redeemable,_mode.creditAmount, nil];
            cell.dataArr = [NSMutableArray arrayWithObjects:_mode.usableAmount,@"0.00",@"0.00", nil];
            [cell.myCollecTV reloadData];
            return cell;
        }
        
    }  else {
        DM_MeCollecCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DM_MeCollecCell"];
        cell.delegate = self;
        if ([_mode.role isEqualToString:@"1"]) {
            cell.dataArr = @[@"个人页",@"豆券",@"我是主播",@"我的二维码",@"扫一扫",@"安全中心"];
        } else {
            cell.dataArr = @[@"个人页",@"豆券",@"我的二维码",@"扫一扫",@"安全中心"];
        }
        [cell.myCollecTV reloadData];
        return cell;
    }
    
}

- (void)icTouch {//头像点击
    if ([BusinessLogic uuid].length == 0) {
        DM_LoginController *loginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:YES];
    }

}
- (void)fensiTouch {//粉丝点击
    
    if ([BusinessLogic uuid].length == 0) {
        DM_LoginController *loginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:YES];
    } else {
    MyGZFSViewController *myGZFS = [[MyGZFSViewController alloc] initWithNibName:@"MyGZFSViewController" bundle:nil];
    myGZFS.titleStr = @"我的粉丝";
        [self.navigationController pushViewController:myGZFS animated:YES];
    }
    
}
- (void)guanzhuTouch {//关注点击
    if ([BusinessLogic uuid].length == 0) {
        DM_LoginController *loginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else {
    MyGZFSViewController *myGZFS = [[MyGZFSViewController alloc] initWithNibName:@"MyGZFSViewController" bundle:nil];
    myGZFS.titleStr = @"我的关注";
        [self.navigationController pushViewController:myGZFS animated:YES];
    }
}

- (void)touchCollec:(NSInteger)index {
    
    if ([BusinessLogic uuid].length == 0) {
        DM_LoginController *loginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:YES];
    } else {
        //标签点击
        if (index == 0) {
            PersonageViewController *personageVC = [[PersonageViewController alloc] initWithNibName:@"PersonageViewController" bundle:nil];
            personageVC.UUID = [BusinessLogic uuid];
            [self.navigationController pushViewController:personageVC animated:YES];
        }
        
        if (index == 1) { // 豆券
            
//            [self showAlertWithTitle:@"温馨提示" message:@"此功能暂未开通" handler:nil];
            DMUserDouTicketViewController *controller = [[DMUserDouTicketViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            
        }
        
        if ([_mode.role isEqualToString:@"1"]) {
            if (index == 2) {
                MeAnchorViewController *meAnchorVC = [[MeAnchorViewController alloc] initWithNibName:@"MeAnchorViewController" bundle:nil];
                meAnchorVC.fenMianUrl = _mode.coverImgUrl;
                [self.navigationController pushViewController:meAnchorVC animated:YES];
                
            }
            
            
            if (index == 3) {
                MyErWeiMaController *MaVC = [[MyErWeiMaController alloc] init];//二维码
                MaVC.name = _mode.nickName;
                MaVC.icimage = _mode.imgUrl;
                MaVC.sex = _mode.sex==0?@"女":@"男";
                MaVC.sharecontent = _mode.individualitySignature;
                [self.navigationController pushViewController:MaVC animated:YES];
            }
            
            if (index == 4) {
                SweepMaViewController *sweepMaVC = [[SweepMaViewController alloc] init];//扫一扫
                [self.navigationController pushViewController:sweepMaVC animated:YES];
            }
            if (index == 5) {
                SafetyViewController *safetyVC = [[SafetyViewController alloc] init];
                [self.navigationController pushViewController:safetyVC animated:YES];

                
            }
            
            
        } else {
            if (index == 2) {
                MyErWeiMaController *MaVC = [[MyErWeiMaController alloc] init];//二维码
                MaVC.name = _mode.nickName;
                MaVC.icimage = _mode.imgUrl;
                MaVC.sex = _mode.sex==0?@"女":@"男";
                MaVC.sharecontent = _mode.individualitySignature;
                [self.navigationController pushViewController:MaVC animated:YES];
            }
            
            
            if (index == 3) {
                SweepMaViewController *sweepMaVC = [[SweepMaViewController alloc] init];
                [self.navigationController pushViewController:sweepMaVC animated:YES];
            }
            
            if (index == 4) {
                SafetyViewController *safetyVC = [[SafetyViewController alloc] init];
                [self.navigationController pushViewController:safetyVC animated:YES];
            }
        }
        
        
    }

    

}


- (void)touchYuECollec:(NSInteger)index {

    
        if ([BusinessLogic uuid].length == 0) {
            DM_LoginController *loginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
            [self.navigationController pushViewController:loginVC animated:YES];
        }else {
            if (index == 0) {//余额点击
            MyAccountController *myAccountVC = [[MyAccountController alloc] initWithNibName:@"MyAccountController" bundle:nil];
                [self.navigationController pushViewController:myAccountVC animated:YES];
            } else if (index == 1) { // 蜜豆荚点击
                [self showAlertWithTitle:@"您好" message:@"此功能暂未开通" handler:nil];
                
//                    if ([[BusinessLogic power] isEqualToString:@"Y"]) {
//                        
//                        
//                            
//                            DMMeDouJiaViewController *controller = [[DMMeDouJiaViewController alloc] init];
//                            [self.navigationController pushViewController:controller animated:YES];
//                        
//                        
//                        
//                    } else {
//                        
//                        
//                    }
                
                    
                
                

            } else {// 蜜分期点击
                [self showAlertWithTitle:@"您好" message:@"此功能暂未开通" handler:nil];
//                if ([[BusinessLogic power] isEqualToString:@"Y"]) {
//                    
//                    __weak __typeof(self) weakSelf = self;
//                    
//                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//                    [dic dm_setObject:@"DMHY500010" forKey:@"iface"];
//                    [dic dm_setObject:[BusinessLogic uuid] forKey:@"userId"];
//                    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) { // 已授信直接跳到蜜分期页面，未授信跳到用户认证页面
//                        
//                        DMMeXinModel *model = [DMMeXinModel mj_objectWithKeyValues:responseObj];
//                        NSLog(@"%@",model.creditInfo.creditStatus);
//                        if ([model.rescode isEqualToString:@"0000"]) {
//                            
//                            if ( [model.creditInfo.creditStatus isEqualToString:@"2"]) { // 已认证
//                                
//                                DMMiFenQiViewController *controller = [[DMMiFenQiViewController alloc] initWithNibName:@"DMMiFenQiViewController" bundle:nil];
//                                [weakSelf.navigationController pushViewController:controller animated:YES];
//                                
//                            } else {
//                                if ([model.creditInfo.creditStatus isEqualToString:@"3"]) {
//                                    [self showAlertWithTitle:@"抱歉" message:@"您暂不符合蜜分期开通条件" handler:nil];
//                                    
//                                    
//                                } else {
//                                    DMUserIdentifyViewController *controller = [[DMUserIdentifyViewController alloc] init];
//                                    [weakSelf.navigationController pushViewController:controller animated:YES];
//                                }
//                            }
//                            
//                        }
//                        
//                    } failure:^(NSError *error) {
//                        
//                    }];
//                    
//                    
//                } else {
//                    
//                    
//                
//                }
//            
            }
        }
    
    
    
}

- (void)showLeftView:(UIButton *)btn {
    if ([BusinessLogic uuid].length == 0) {
        DM_LoginController *loginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else {
    SelfSetViewController *selfSet = [[SelfSetViewController alloc] initWithNibName:@"SelfSetViewController" bundle:nil];
    [self.navigationController pushViewController:selfSet animated:YES];
    }
}

- (void)showRightView:(UIButton *)btn {
    
    if ([BusinessLogic uuid].length == 0) {
        DM_LoginController *dmVC= [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
        [self.navigationController pushViewController:dmVC animated:YES];
        
        
    } else {
    
    if (btn.tag == 0) {
        btn.selected = NO;
        MessageCenterController *messageCenter = [[MessageCenterController alloc] initWithNibName:@"MessageCenterController" bundle:nil];
        [self.navigationController pushViewController:messageCenter animated:YES];
    }
    
    if (btn.tag == 2) {
        // 1.创建热门搜索
        NSDictionary *dic;
        if (btn.selected) {
            dic = @{@"iface":@"DMHY400033",@"userId":[BusinessLogic uuid],@"active":@"0"};
        } else {
            dic = @{@"iface":@"DMHY400033",@"userId":[BusinessLogic uuid],@"active":@"1"};
        }
        [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
            btn.selected = !btn.selected;
        } failure:^(NSError *error) {
            
        }];
    }
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
