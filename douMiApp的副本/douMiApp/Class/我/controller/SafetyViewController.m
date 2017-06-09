//
//  SafetyViewController.m
//  douMiApp
//
//  Created by ydz on 2016/12/2.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "SafetyViewController.h"
#import "RevisePwdController.h"
#import "BoundViewController.h"
#import "SafetyMode.h"
#import "ZiLiao1Cell.h"
#import "AutonymController.h"
#import "ForgetPayController.h"
@interface SafetyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSArray *arr;

@property (strong, nonatomic) SafetyMode *mode;

@end

@implementation SafetyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self request_Api];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"安全中心";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    [_myTableView registerClass:[ZiLiao1Cell class] forCellReuseIdentifier:@"ZiLiao1Cell"];
    
}

- (void)request_Api {
    
    __weak UITableView *tableView = _myTableView;
    NSDictionary *dic = @{@"iface":@"DMHY400047",@"userId":[BusinessLogic uuid]};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [SafetyMode mj_objectWithKeyValues:responseObj];
        [tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.arr.count;
    } else {
        return _mode.platformAccount.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZiLiao1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZiLiao1Cell"];
    if (indexPath.section == 0) {
        cell.titleLable.text = self.arr[indexPath.row];
        if (indexPath.row == 0) {
            cell.contentLable.text = _mode.pwd;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 1) {
            cell.contentLable.text = _mode.payPwd;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 2) {
            cell.contentLable.text = _mode.uname;
            if ([_mode.uname isEqualToString:@"未认证"]) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        
        if (indexPath.row == 3) {
            cell.contentLable.text = _mode.phone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        
    } else {
        cell.titleLable.text = _mode.platformAccount[indexPath.row].name;
        cell.contentLable.text = _mode.platformAccount[indexPath.row].acounts.length>0?_mode.platformAccount[indexPath.row].acounts:@"未设置";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    }
    
    
    
    return cell;
    
//    static NSString *ID = @"id";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    
//    UILabel *lable = [[UILabel alloc] init];
//    lable.textColor = RGBA(140, 140, 140, 1);
////    lable.text = @"未设置";
//    lable.font = [UIFont systemFontOfSize:12];
//    lable.textAlignment = NSTextAlignmentRight;
//    
//    if (indexPath.section == 0) {
//        cell.textLabel.text = self.arr[indexPath.row];
//        if (indexPath.row == 0) {
//            lable.text = _mode.pwd;
//        }
////        if (indexPath.row == 1) {
////            lable.text = _mode.payPwd;
////        }
////        if (indexPath.row == 2) {
////            lable.text = _mode.uname;
////        }
//        
//    } else {
//        cell.textLabel.text = _mode.platformAccount[indexPath.row].name;
//        lable.text = _mode.platformAccount[indexPath.row].acounts.length>0?_mode.platformAccount[indexPath.row].acounts:@"未设置";
//        
//    }
//    
//    if (indexPath.section==0 && indexPath.row == 1) {//要改
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        lable.frame = CGRectMake(SCREEN_WIDTH-215, 0, 200, 50);
//        lable.text = _mode.phone;
//        
//    } else {
//        
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        lable.frame = CGRectMake(SCREEN_WIDTH-230, 0, 200, 50);
//    }
//    [cell.contentView addSubview:lable];
//    cell.textLabel.font = [UIFont systemFontOfSize:12];
//    cell.textLabel.textColor = RGBA(40, 40, 40, 1);
//    
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RevisePwdController *reviseVC = [[RevisePwdController alloc] initWithNibName:@"RevisePwdController" bundle:nil];
            reviseVC.titleStr = _arr[indexPath.row];
            reviseVC.phoneStr = _mode.phone;
            [self.navigationController pushViewController:reviseVC animated:YES];
        }
        if (indexPath.row == 1) {
            if ([_mode.payPwd isEqualToString:@"未设置"]) {
                ForgetPayController *forgetPay = [[ForgetPayController alloc] init];
                forgetPay.mold = @"999";
                [self.navigationController pushViewController:forgetPay animated:YES];
            } else {
            RevisePwdController *reviseVC = [[RevisePwdController alloc] initWithNibName:@"RevisePwdController" bundle:nil];
            reviseVC.titleStr = _arr[indexPath.row];
            reviseVC.phoneStr = _mode.phone;
                [self.navigationController pushViewController:reviseVC animated:YES];
            }
        }
        if (indexPath.row == 2) {
            if ([_mode.uname isEqualToString:@"未认证"]) {
                AutonymController *autonymVC = [[AutonymController alloc] initWithNibName:@"AutonymController" bundle:nil];
                [self.navigationController pushViewController:autonymVC animated:YES];
            }
            
        }
        if (indexPath.row == 3) {
            
        }
        
    }
    if (indexPath.section == 1) {
        
            BoundViewController *boundVC = [[BoundViewController alloc] initWithNibName:@"BoundViewController" bundle:nil];
            boundVC.titleStr = _mode.platformAccount[indexPath.row].name;
        boundVC.ID =_mode.platformAccount[indexPath.row].Id;
        boundVC.imgUrl = _mode.platformAccount[indexPath.row].imgUrl;
        
            [self.navigationController pushViewController:boundVC animated:YES];
        
    }
    
    
}

- (NSArray *)arr {
    if (!_arr) {
        _arr = @[@"登录密码",@"交易密码",@"账户实名",@"手机号"];
//        _arr = @[@"登录密码",@"手机号"];
    }
    return _arr;
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
