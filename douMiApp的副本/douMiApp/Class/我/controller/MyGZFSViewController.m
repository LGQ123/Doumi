//
//  MyGZFSViewController.m
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MyGZFSViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "GZFSCell.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"
#import "FSAndZDMode.h"
#import "PersonageViewController.h"
#import "DM_DisplayController.h"
@interface MyGZFSViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (copy, nonatomic) NSString *type;
@property (strong, nonatomic) NSMutableArray <FSZBList*>*dataArr;
@property (strong, nonatomic) FSAndZDMode *mode;
@property (weak, nonatomic) IBOutlet UIImageView *dog1;
@property (weak, nonatomic) IBOutlet UILabel *mylable;
@property (weak, nonatomic) IBOutlet UIButton *mybtn;
@property (assign, nonatomic) NSInteger Page;
@end

@implementation MyGZFSViewController


- ( void)viewWillDisappear:(BOOL)animated {
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
//    self.fd_interactivePopDisabled = NO;
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideViewController=[delegate LeftSlideController];
    sideViewController.needSwipeShowMenu=YES;//默认开启的可滑动展示
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
    self.fd_interactivePopDisabled = YES;
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideViewController=[delegate LeftSlideController];
    sideViewController.needSwipeShowMenu=NO;//默认开启的可滑动展示
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = _titleStr;
    self.lable.textColor = RGBA(40, 40, 40, 1);
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    if ([_titleStr isEqualToString:@"我的关注"]) {
        _type = @"2";
    } else {
        _type = @"1";
    }
    
    [_myTableView registerNib:[UINib nibWithNibName:@"GZFSCell" bundle:nil] forCellReuseIdentifier:@"GZFSCell"];
    __weak __typeof(self) weakSelf = self;
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf request_Api];
    }];
    
    _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf request_MoreApi];
    }];
    [self request_Api];
    
}

- (void)request_Api {
    __weak UITableView *tableView = _myTableView;
    _Page = 1;
    _dataArr = [[NSMutableArray alloc] init];
    NSDictionary *dic = @{@"iface":@"DMHY400014",@"userId":[BusinessLogic uuid],@"current":[NSString stringWithFormat:@"%ld",(long)_Page],@"type":_type};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [FSAndZDMode mj_objectWithKeyValues:responseObj];
        
        if (_mode.list.count == 0) {
            _dog1.hidden = NO;
            _myTableView.hidden = YES;
            _mylable.hidden = NO;
            if ([_type isEqualToString:@"2"]) {
                _mybtn.hidden = NO;
                _mylable.text = @"还没有关注的主播";
            } else {
                _mybtn.hidden = YES;
                _mylable.text = @"还没有粉丝关注您";
            }
            
        } else {
            _myTableView.hidden = NO;
            _mylable.hidden = YES;
            _mybtn.hidden = YES;
            _dog1.hidden = YES;
            [_dataArr addObjectsFromArray:_mode.list];
            [_myTableView reloadData];
            [tableView.mj_header endRefreshing];
        }
        
        
        
    } failure:^(NSError *error) {
        [tableView.mj_header endRefreshing];
    }];
    
}

- (void)request_MoreApi {
    __weak UITableView *tableView = _myTableView;
    _Page++;
    NSDictionary *dic = @{@"iface":@"DMHY400014",@"userId":[BusinessLogic uuid],@"current":[NSString stringWithFormat:@"%ld",(long)_Page],@"type":_type};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [FSAndZDMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.list];
        [_myTableView reloadData];
        if (_mode.list.count == 0) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
       [tableView.mj_footer endRefreshing];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;

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
    GZFSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GZFSCell"];
    cell.mode = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PersonageViewController *personageVC = [[PersonageViewController alloc] initWithNibName:@"PersonageViewController" bundle:nil];
    personageVC.UUID = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.row].mId];
    [self.navigationController pushViewController:personageVC animated:YES];
    

}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    //如果是删除
    
    if(editingStyle==UITableViewCellEditingStyleDelete)
        
    {
        
        //点击删除按钮调用这里的代码
        
        //        1.数据源删除
        
//                @[indexPath]=[NSArray arrayWithObjects:indexPath,nil];
        
        
        
        //        2.UI上删除
        
        //删除表视图的某个cell
        
        /*
         
         第一个参数：将要删除的所有的cell的indexPath组成的数组
         
         第二个参数：动画
         
         */
        
//        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //将整个表格视图刷新也可以实现在UI上删除的效果，只不过它要重新执行一遍所有的方法，效率很低
        
        //        [tableView reloadData];
        
        
        [self requestDelegate_Api:indexPath.row];
        
        
    }
    
}

//修改删除按钮为中文的删除

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return @"删除";
    
}

//是否允许编辑行，默认是YES

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return YES;
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//设置cell可移动

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;

}

- (void)requestDelegate_Api:(NSInteger)row {
    
    NSDictionary *dic;
    if ([_type isEqualToString:@"2"]) {
       dic = @{@"iface":@"DMHY400015",@"userId":[BusinessLogic uuid],@"anchored":[NSString stringWithFormat:@"%ld",(long)_dataArr[row].mId]};
    } else {
       dic = @{@"iface":@"DMHY400015",@"userId":[BusinessLogic uuid],@"fansId":[NSString stringWithFormat:@"%ld",(long)_dataArr[row].mId]};
        
    }
    
    
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        [_dataArr removeObjectAtIndex:row];
        [_myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}
- (IBAction)mybtnTouch:(UIButton *)sender {
    DM_DisplayController *displayVC = [[DM_DisplayController alloc] init];
    [self.navigationController pushViewController:displayVC animated:YES];
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
