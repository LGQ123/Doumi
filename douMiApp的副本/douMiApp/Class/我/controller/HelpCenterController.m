//
//  HelpCenterController.m
//  douMiApp
//
//  Created by ydz on 2016/12/10.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "HelpCenterController.h"
#import "FoundHTCell.h"
#import "MyQuizViewController.h"
#import "wenTiMode.h"
#import "IssueDetailsController.h"
@interface HelpCenterController ()<UITableViewDelegate,UITableViewDataSource,HTFoundDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) wenTiMode *mode;
@end

@implementation HelpCenterController

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
    
    
    
    
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"帮助中心";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    [_myTableView registerNib:[UINib nibWithNibName:@"FoundHTCell" bundle:nil] forCellReuseIdentifier:@"FoundHTCell"];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    UIView *view = [[UIView alloc] initWithFrame:headerView.frame];
    view.backgroundColor = RGBA(247, 247, 247, 1);
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 40, 100, 100)];
    iv.image = [UIImage imageNamed:@"dog3"];
    [view addSubview:iv];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 13)];
    lable.text = @"HUANGBO您好!";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont boldSystemFontOfSize:12];
    [view addSubview:lable];
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 13)];
    lable1.text = @"欢迎来到豆蜜帮助中心,请问您遇到了什么问题？";
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.font = [UIFont boldSystemFontOfSize:12];
    [view addSubview:lable1];
    [headerView addSubview:view];
    _myTableView.tableHeaderView = headerView;
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self request_Api];
    
}

- (void)request_Api {
    __weak UITableView *tableView = _myTableView;
    if (isEmpty(_childrenType)) {
        _childrenType = @"4";
    }
    NSDictionary *dic = @{@"iface":@"DMHY400037",@"userId":[BusinessLogic uuid],@"type":@"1",@"childrenType":_childrenType};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [wenTiMode mj_objectWithKeyValues:responseObj];
        [tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if (section == 1) {
    return 1;
    } else {
        return _mode.questions.count;
        
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section!=1) {
        return 50;
    } else {
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section !=1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = RGBA(40, 40, 40, 1);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section == 0) {
            cell.textLabel.text = @"如需人工服务：点击此处查看我的提问";
        } else {
            cell.textLabel.text = _mode.questions[indexPath.row].name;
        }
        
        return cell;
    } else {
        FoundHTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoundHTCell"];
        [cell.hotHT1 setTitle:@"常见问题" forState:UIControlStateNormal];
         [cell.hotHT2 setTitle:@"账户相关问题" forState:UIControlStateNormal];
         [cell.hotHT3 setTitle:@"蜜豆荚相关问题" forState:UIControlStateNormal];
         [cell.hotHT4 setTitle:@"蜜分期相关问题" forState:UIControlStateNormal];
        [cell.hotHT1 setTitleColor:RGBA(40, 40, 40, 1) forState:UIControlStateNormal];
        [cell.hotHT2 setTitleColor:RGBA(40, 40, 40, 1) forState:UIControlStateNormal];
        [cell.hotHT3 setTitleColor:RGBA(40, 40, 40, 1) forState:UIControlStateNormal];
        [cell.hotHT4 setTitleColor:RGBA(40, 40, 40, 1) forState:UIControlStateNormal];
        cell.delegate = self;
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        MyQuizViewController *myQVC = [[MyQuizViewController alloc] initWithNibName:@"MyQuizViewController" bundle:nil];
        [self.navigationController pushViewController:myQVC animated:YES];
    } else {
        IssueDetailsController *issueDVC = [[IssueDetailsController alloc] initWithNibName:@"IssueDetailsController" bundle:nil];
        issueDVC.ID = [NSString stringWithFormat:@"%ld",(long)_mode.questions[indexPath.row].Id];
        [self.navigationController pushViewController:issueDVC animated:YES];
    }

}


- (void)HotHTDelegate:(UIButton *)ID {
    __weak UITableView *tableView = _myTableView;
    NSDictionary *dic = @{@"iface":@"DMHY400037",@"userId":[BusinessLogic uuid],@"type":@"1",@"childrenType":[NSString stringWithFormat:@"%ld",(long)ID.tag-20000]};
    
   [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
       _mode = [wenTiMode mj_objectWithKeyValues:responseObj];
       [tableView reloadData];
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
