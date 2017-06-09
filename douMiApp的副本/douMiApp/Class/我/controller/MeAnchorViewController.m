//
//  MeAnchorViewController.m
//  douMiApp
//
//  Created by ydz on 2016/12/12.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MeAnchorViewController.h"
#import "MyInformationController.h"
#import "TuiJianFenMianController.h"
@interface MeAnchorViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MeAnchorViewController
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
    self.lable.text = @"我是主播";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qqq"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qqq"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"主播资料";
    } else {
        cell.textLabel.text = @"推荐位封面";
    }
    cell.textLabel.textColor = RGBA(40, 40, 40, 1);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        MyInformationController *myIVC = [[MyInformationController alloc] initWithNibName:@"MyInformationController" bundle:nil];
        [self.navigationController pushViewController:myIVC animated:YES];
    }
    
    if (indexPath.row == 1) {
        TuiJianFenMianController *tuiJianFMVC = [[TuiJianFenMianController alloc] initWithNibName:@"TuiJianFenMianController" bundle:nil];
        tuiJianFMVC.FenmianUrl = self.fenMianUrl;
        [self.navigationController pushViewController:tuiJianFMVC animated:YES];
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
