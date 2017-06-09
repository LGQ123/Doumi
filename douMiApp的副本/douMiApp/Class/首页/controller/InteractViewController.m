//
//  InteractViewController.m
//  douMiApp
//
//  Created by ydz on 2016/11/23.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "InteractViewController.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import "DMInteractCell.h"
#import "CheckEarlierCell.h"
#import "InteractMode.h"
#import "DTDetailsViewController.h"
@interface InteractViewController ()<UITableViewDelegate,UITableViewDataSource,DMInteractDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (assign, nonatomic) BOOL isOld;

@property (strong, nonatomic) InteractMode *mode;
@property (strong, nonatomic) InteractMode *mode1;
@property (strong, nonatomic) NSMutableArray <Map *>*dataArr;
@property (strong, nonatomic) NSMutableArray <Map *>*dataArr1;

@end

@implementation InteractViewController

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    NSDictionary *dic = @{@"iface":@"DMHY300018",@"userId":[BusinessLogic uuid]};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        
    } failure:^(NSError *error) {
        
    }];

}

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
    _isOld = NO;
    _dataArr = [[NSMutableArray alloc] init];
    _dataArr1 = [[NSMutableArray alloc] init];
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"互动";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    [_myTableView registerClass:[DMInteractCell class] forCellReuseIdentifier:@"DMInteractCell"];
    [_myTableView registerClass:[CheckEarlierCell class] forCellReuseIdentifier:@"CheckEarlierCell"];
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
//    __weak __typeof(self) weakSelf = self;
//    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf request_Api];
//    }];
//    
//    _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf requestMore_Api];
//    }];
    [self request_Api];
    
    
    
}

- (void)request_Api {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY300017",@"userId":[BusinessLogic uuid],@"type":@"0"};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        _mode = [InteractMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.map];
        [_dataArr1 addObjectsFromArray:_mode.map];
        [self requestMore_Api];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    
}

- (void)requestMore_Api {
    NSDictionary *dic = @{@"iface":@"DMHY300017",@"userId":[BusinessLogic uuid],@"type":@"1"};
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _mode1 = [InteractMode mj_objectWithKeyValues:responseObj];
         [_dataArr1 addObjectsFromArray:_mode1.map];
        [_myTableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}


#pragma mark- tab;eViewDelegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isOld) {
        return _dataArr1.count;
    } else {
        if (_mode1.map.count == 0) {
            return _dataArr.count;
        } else {
            return _dataArr.count+1;
        }
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [DMInteractCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isOld) {
        DMInteractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMInteractCell"];
        cell.delegate = self;
        cell.mode = _dataArr1[indexPath.row];
        return cell;
        
        
    } else {
        if (_mode1.map.count == 0) {
            DMInteractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMInteractCell"];
            cell.delegate = self;
            cell.mode = _dataArr[indexPath.row];
            return cell;
        } else {
            if (indexPath.row == _dataArr.count) {
                CheckEarlierCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckEarlierCell"];
                return cell;
            } else {
                DMInteractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMInteractCell"];
                cell.delegate = self;
                cell.mode = _dataArr[indexPath.row];
                return cell;
            }
        
        }
    
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_isOld) {
       
        [self DTDetails:_dataArr1[indexPath.row].dynId];
        
    } else {
        if (_mode1.map.count == 0) {
            [self DTDetails:_dataArr[indexPath.row].dynId];
        } else {
            if (indexPath.row == _dataArr.count) {
                _isOld = YES;
                [_myTableView reloadData];
            } else {
                [self DTDetails:_dataArr[indexPath.row].dynId];
            }
        }
        
    }

}

- (void)DTDetails:(NSString *)ID {
    DTDetailsViewController *dtVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
    dtVC.ID = ID;
    dtVC.type = @"dt";
    [self.navigationController pushViewController:dtVC animated:YES];
    
}

- (void)DMInteractTouch:(NSString *)ID {
    

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
