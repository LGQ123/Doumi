//
//  RevisePwdController.m
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "RevisePwdController.h"
#import "ReviseLoginController.h"
#import "ForgetLoginController.h"
#import "RevisePayPawController.h"
@interface RevisePwdController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation RevisePwdController

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
    self.lable.text = [NSString stringWithFormat:@"修改%@",self.titleStr];
    self.lable.textColor = RGBA(40, 40, 40, 1);
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
}


#pragma uitableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviseID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReviseID"];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"我记得原密码";
    } else {
        cell.textLabel.text = @"我忘记原密码了";
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = RGBA(40, 40, 40, 1);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.titleStr isEqualToString:@"登录密码"]) {
        if (indexPath.row == 0) {
            ReviseLoginController *reviseVC = [[ReviseLoginController alloc] initWithNibName:@"ReviseLoginController" bundle:nil];
            [self.navigationController pushViewController:reviseVC animated:YES];
        } else {
            ForgetLoginController *forgetLogin = [[ForgetLoginController alloc] initWithNibName:@"ForgetLoginController" bundle:nil];
            forgetLogin.type = @"4";
            forgetLogin.phone = self.phoneStr;
            [self.navigationController pushViewController:forgetLogin animated:YES];
        }
        
    } else {
        if (indexPath.row == 0) {
            RevisePayPawController *revisePawVC = [[RevisePayPawController alloc] init];
            [self.navigationController pushViewController:revisePawVC animated:YES];
        } else {
            ForgetLoginController *forgetLogin = [[ForgetLoginController alloc] initWithNibName:@"ForgetLoginController" bundle:nil];
            forgetLogin.type = @"3";
            forgetLogin.phone = self.phoneStr;
            [self.navigationController pushViewController:forgetLogin animated:YES];

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
