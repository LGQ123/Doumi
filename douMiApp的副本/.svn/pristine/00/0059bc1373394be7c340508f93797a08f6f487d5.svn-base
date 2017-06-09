//
//  MyInformationController.m
//  douMiApp
//
//  Created by ydz on 2016/12/12.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MyInformationController.h"
#import "ZiLiaoCell.h"
#import "ZiLiao1Cell.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import "MaterialZhuBoMode.h"
#import "WriteInforController.h"
#import "GQSexView.h"
#import "GQLoveSexView.h"
#import "GQBloodTypeView.h"
#import "DQBirthDateView.h"
#import "DQconstellationView.h"
#import "DQAgeModel.h"
#import "LoveSexMode.h"
@interface MyInformationController ()<UITableViewDelegate,UITableViewDataSource,writeInforDelegate,DQBirthDateViewDelegate,DQconstellationViewDelegate,GQSEXDelegate,GQBloodDelegate,GQLoveSexDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray <NSArray *>*dataArr;
@property (strong, nonatomic) MaterialZhuBoMode *mode;

@property (strong, nonatomic)GQSexView *sexView;
@property (strong, nonatomic)GQLoveSexView *loveSex;
@property (strong, nonatomic)GQBloodTypeView *bloodTypeView;
@property (strong, nonatomic)DQconstellationView *constellation;
@property (strong, nonatomic)DQBirthDateView *birthView;
@end

@implementation MyInformationController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"我的资料";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    [_myTableView registerClass:[ZiLiaoCell class] forCellReuseIdentifier:@"ZiLiaoCell"];
    [_myTableView registerClass:[ZiLiao1Cell class] forCellReuseIdentifier:@"ZiLiao1Cell"];
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    [self request_Api];
}

- (void)request_Api {
    
    __weak UITableView *tableView = _myTableView;
    NSDictionary *dic = @{@"iface":@"DMHY400004",@"userId":[BusinessLogic uuid]};
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [MaterialZhuBoMode mj_objectWithKeyValues:responseObj];
        [tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr[section].count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section < 4) {
        return 50;
    } else {
    
        return [ZiLiaoCell whc_CellHeightForIndexPath:indexPath tableView:tableView]+20;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section < 4 ) {
        ZiLiao1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZiLiao1Cell"];
        
        cell.titleLable.text =self.dataArr[indexPath.section][indexPath.row];
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.contentLable.text = _mode.platName;
            }
            if (indexPath.row == 1) {
                
                cell.contentLable.text = _mode.channel;
            }
            if (indexPath.row == 2) {
               cell.contentLable.text = _mode.stageName;
            }
            if (indexPath.row == 3) {
                
                 cell.contentLable.text = _mode.yyAcount;
            }
            if (indexPath.row == 4) {
                cell.contentLable.text = _mode.roomNum;
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.contentLable.text = [_mode.sex isEqualToString:@"0"]?@"女":@"男";
            }
            if (indexPath.row == 1) {
                cell.contentLable.text = _mode.birthday;
            }
//            if (indexPath.row == 2) {
//                cell.contentLable.text = _mode.bloodType;
//            }
            if (indexPath.row == 2) {
                cell.contentLable.text = _mode.constellation;
            }
            if (indexPath.row == 3) {
                cell.contentLable.text = _mode.loveSex;
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.contentLable.text = _mode.weixinNum;
            }
            if (indexPath.row == 1) {
                cell.contentLable.text = _mode.weiboName;
            }
            
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                cell.contentLable.text = _mode.hobby;
            }
            if (indexPath.row == 1) {
                cell.contentLable.text = _mode.radioType;
            }
            
        }
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0 || indexPath.row ==1) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            
        } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        
        return cell;
    } else {
    
    
    ZiLiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZiLiaoCell"];
        if (indexPath.section == 4) {
            cell.contentLable.text = _mode.dream;
        }
        if (indexPath.section == 5) {
            cell.contentLable.text = _mode.introduction;
        }
        
    cell.titleLable.text = self.dataArr[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section != 1) {
        if (indexPath.section < 4) {
            ZiLiao1Cell *cell = (ZiLiao1Cell *)[tableView cellForRowAtIndexPath:indexPath];
            
            
            if (indexPath.section == 0 && indexPath.row == 0) {
                
            } else if(indexPath.section == 0 && indexPath.row == 1) {
            
            } else{
                if (indexPath.section != 2 && indexPath.section != 3) {
                    [self pushWriteVC:cell.titleLable.text isGongKai:YES];
                } else {
                    [self pushWriteVC:cell.titleLable.text isGongKai:NO];
                }
            }
            
        } else {
            ZiLiaoCell *cell = (ZiLiaoCell *)[tableView cellForRowAtIndexPath:indexPath];
            [self pushWriteVC:cell.titleLable.text isGongKai:YES];
        }
    } else {
        if (indexPath.row == 0) {
            self.sexView = [GQSexView new];
            self.sexView.delegate = self;
            [self.sexView startAnimationFunction];
        }
        if (indexPath.row == 1) {
            self.birthView = [DQBirthDateView new];
            self.birthView.delegate = self;
            [self.birthView startAnimationFunction];
        }
//        if (indexPath.row == 2) {
//            self.bloodTypeView = [GQBloodTypeView new];
//            self.bloodTypeView.delegate = self;
//            [self.bloodTypeView startAnimationFunction];
//            
//        }
        if (indexPath.row == 2) {
            self.constellation = [DQconstellationView new];
            self.constellation.delegate =self;
            [self.constellation startAnimationFunction];
        }
        if (indexPath.row == 3) {
            self.loveSex = [GQLoveSexView new];
            self.loveSex.delegate = self;
            [self.loveSex startAnimationFunction];
        }
    }
}

- (void)pushWriteVC:(NSString *)titleStr isGongKai:(BOOL )GK {
    WriteInforController *writeInfo = [[WriteInforController alloc] initWithNibName:@"WriteInforController" bundle:nil];
    writeInfo.titleStr = titleStr;
    writeInfo.isGongKai = GK;
    writeInfo.delegate = self;
    [self.navigationController pushViewController:writeInfo animated:YES];

}

//writeDelegate
- (void)writeStr:(NSString *)str title:(NSString *)title {
    if ([title isEqualToString:@"主播艺名"]) {
        
        _mode.stageName = str;
    }
    if ([title isEqualToString:@"主播平台"]) {
        
        _mode.platName = str;
    }
    if ([title isEqualToString:@"YY号"]) {
        
        _mode.yyAcount = str;
    }
    if ([title isEqualToString:@"工会频道"]) {
        
        _mode.channel = str;
    }
    if ([title isEqualToString:@"直播间号"]) {
        
        _mode.roomNum = str;
    }
    if ([title isEqualToString:@"胸围"]) {
    
        _mode.bust = str;
    }
    if ([title isEqualToString:@"腰围"]) {
        
        _mode.waist = str;
    }
    if ([title isEqualToString:@"臀围"]) {
    
        _mode.hips = str;
    }
    if ([title isEqualToString:@"微信号"]) {
        
        _mode.weixinNum = str;
    }
    if ([title isEqualToString:@"微博昵称"]) {
        
        _mode.weiboName = str;
    }
    if ([title isEqualToString:@"兴趣爱好"]) {
        
        _mode.hobby = str;
    }
    if ([title isEqualToString:@"主播关键字"]) {
        
        _mode.radioType = str;
    }
    
    if ([title isEqualToString:@"我的梦想"]) {
        
        _mode.dream = str;
    }
    if ([title isEqualToString:@"我的简介"]) {
        _mode.introduction = str;
    }
    
    

    [_myTableView reloadData];
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@[@"主播平台",@"工会频道",@"主播艺名",@"YY号",@"直播间号"],@[@"性别",@"生日",@"星座",@"性取向"],@[@"微信号",@"微博昵称"],@[@"兴趣爱好",@"主播关键字"],@[@"我的梦想"],@[@"我的简介"]];
    }
    return _dataArr;
    
}

//生日
- (void)clickDQBirthDateViewEnsureBtnActionAgeModel:(DQAgeModel *)ageModel andConstellation:(NSString *)str {
    
    _mode.birthday = [NSString stringWithFormat:@"%@/%@/%@",ageModel.year,ageModel.month,ageModel.day];
    NSDictionary *dic = @{@"iface":@"DMHY400005",@"userId":[BusinessLogic uuid],@"birthday":_mode.birthday};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}
//性别
- (void)clickDQSexStr:(NSString *)str {
    _mode.sex = [str isEqualToString:@"女"]?@"0":@"1";
    NSDictionary *dic = @{@"iface":@"DMHY400005",@"userId":[BusinessLogic uuid],@"sex":_mode.sex};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
   
}
//血型
- (void)clickGQBloodTypeStr:(NSString *)str {
    _mode.bloodType = str;
    NSDictionary *dic = @{@"iface":@"DMHY400005",@"userId":[BusinessLogic uuid],@"bloodType":_mode.bloodType};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
//星座
- (void)clickDQconstellationEnsureBtnActionConstellationStr:(NSString *)str {
    _mode.constellation = str;
    NSDictionary *dic = @{@"iface":@"DMHY400005",@"userId":[BusinessLogic uuid],@"constellation":_mode.constellation};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
//性取向
- (void)clickGQLoveSexStr:(LoveSexMode *)mode {
    _mode.loveSex = [NSString stringWithFormat:@"%@(%@)",mode.sex,mode.isGK];
    NSLog(@"%@",_mode.loveSex);
    NSDictionary *dic = @{@"iface":@"DMHY400005",@"userId":[BusinessLogic uuid],@"loveSex":mode.sex,@"loveSexStatus":[mode.isGK isEqualToString:@"公开"]?@"0":@"1"};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
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
