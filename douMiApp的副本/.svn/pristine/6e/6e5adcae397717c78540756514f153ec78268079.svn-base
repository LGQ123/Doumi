//
//  BrushLiRecordController.m
//  douMiApp
//
//  Created by ydz on 2017/1/11.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "BrushLiRecordController.h"
#import "brushLiRecordCell.h"
#import "RefundViewController.h"
#import "RefundMXController.h"
#import "ShuaLiMode.h"
@interface BrushLiRecordController ()<UITableViewDelegate,UITableViewDataSource,brushLiRecordDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) ShuaLiMode *mode;

@end

@implementation BrushLiRecordController

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
    self.lable.text = @"蜜分期送礼记录";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    // Do any additional setup after loading the view from its nib.
    
    [_myTableView registerNib:[UINib nibWithNibName:@"brushLiRecordCell" bundle:nil] forCellReuseIdentifier:@"brushLiRecordCell"];
    
}



- (void)request_Api {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY500011",@"userId":[BusinessLogic uuid]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _mode = [ShuaLiMode mj_objectWithKeyValues:responseObj];
        [_myTableView reloadData];
        
    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _mode.giftsInfo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_mode.giftsInfo[indexPath.section].status == 0) {
        return 168;
    } else {
        return 147;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    brushLiRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"brushLiRecordCell"];
    cell.delegate = self;
    cell.mode = _mode.giftsInfo[indexPath.section];
    return cell;
}


#pragma brushLiRecordDelegate
- (void)refundDelegate:(NSString *)bid {//还款
    RefundViewController *refubdVC = [[RefundViewController alloc] initWithNibName:@"RefundViewController" bundle:nil];
    [self.navigationController pushViewController:refubdVC animated:YES];
}

- (void)mingXiDelegate:(NSString *)bid {//明细
    RefundMXController *refundMXVC = [[RefundMXController alloc] initWithNibName:@"RefundMXController" bundle:nil];
    refundMXVC.bid = bid;
    [self.navigationController pushViewController:refundMXVC animated:YES];
}

- (void)xieYiDelegate {//协议
    
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
