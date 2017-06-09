//
//  RefundMXController.m
//  douMiApp
//
//  Created by ydz on 2017/1/13.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "RefundMXController.h"
#import "MXTopCell.h"
#import "MXBelowCell.h"
#import "MingXiMode.h"
@interface RefundMXController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) MingXiMode *mode;
@end

@implementation RefundMXController

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
    self.lable.text = @"还款明细";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    // Do any additional setup after loading the view from its nib.
    
    [_myTableView registerNib:[UINib nibWithNibName:@"MXTopCell" bundle:nil] forCellReuseIdentifier:@"MXTopCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"MXBelowCell" bundle:nil] forCellReuseIdentifier:@"MXBelowCell"];
    [self request_Api];
}

- (void)request_Api {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY500012",@"bId":_bid};
    
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _mode = [MingXiMode mj_objectWithKeyValues:responseObj];
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _mode.repaymentInfo.repaymentDetails.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 220;
    } else {
        return 75;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        MXTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MXTopCell"];
        if ([_mode.repaymentInfo.status isEqualToString:@"0"]) {
            cell.titleLAble.text = @"已逾期";
            cell.titleLAble.textColor = RGBA(255, 42, 80, 1);
            cell.contentLable.textColor = RGBA(255, 42, 80, 1);
            cell.contentLable.text = [NSString stringWithFormat:@"本次违约金:%li元 逾期天数:%li天 罚息:%li元",(long)_mode.repaymentInfo.overdueAmount,(long)_mode.repaymentInfo.overdueDays,(long)_mode.repaymentInfo.overdueFine];
        } else if ([_mode.repaymentInfo.status isEqualToString:@"1"]) {
            cell.titleLAble.text = @"还款中";
            cell.titleLAble.textColor = RGBA(40, 40, 40, 1);
            cell.contentLable.textColor = RGBA(40, 40, 40, 1);
            cell.contentLable.text = @"良好的还款习惯可以提高您的蜜分期额度哦，请继续保持";
        } else {
            cell.titleLAble.text = @"已还清";
            cell.titleLAble.textColor = RGBA(40, 40, 40, 1);
            cell.contentLable.textColor = RGBA(40, 40, 40, 1);
            cell.contentLable.text = @"良好的还款习惯可以提高您的蜜分期额度哦，请继续保持";
        }
        
        return cell;
    } else {
        MXBelowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MXBelowCell"];
        cell.mode = _mode.repaymentInfo.repaymentDetails[indexPath.section - 1];
        return cell;
        
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
