//
//  GloryListController.m
//  douMiApp
//
//  Created by ydz on 2016/11/14.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "GloryListController.h"
#import "GloryCell.h"
#import "GloryThreeCell.h"
#import "GloryMode.h"

#define GloryCell1 @"GloryCell"
#define GloryThreeCell1 @"GloryThreeCell"

@interface GloryListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) UIButton *oldBtn;
@property (copy, nonatomic) NSString *flag;
@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSMutableArray <List *>*dataArr;
@property (strong, nonatomic) GloryMode *mode;
@end

@implementation GloryListController

- (void)viewWillAppear:(BOOL)animated {
    [MobClick beginLogPageView:@"荣耀榜"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"荣耀榜"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArr = [[NSMutableArray alloc] init];
    [self addItem:item_left btnTitle:nil viewTitle:nil];
//    [self addItem:item_right btnTitle:@"ask" viewTitle:nil];
    [_myTableView registerNib:[UINib nibWithNibName:GloryCell1 bundle:nil] forCellReuseIdentifier:GloryCell1];
    [_myTableView registerNib:[UINib nibWithNibName:GloryThreeCell1 bundle:nil] forCellReuseIdentifier:GloryThreeCell1];
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    _flag = @"0";
    _page = 1;
    [self createTitleView];
    
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
    
    _page = 1;
    [_dataArr removeAllObjects];
    __weak UITableView *tableView = self.myTableView;
    NSDictionary *dic = @{@"iface":@"DMHY200005",@"flag":_flag,@"pageNo":[NSString stringWithFormat:@"%li",(long)_page]};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [GloryMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.results];
        [tableView reloadData];
        if (_mode.results.count < 20) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            // 拿到当前的下拉刷新控件，结束刷新状态
            [tableView.mj_footer endRefreshing];

        }
        [tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    }];

    
}

- (void)request_MoreApi {
    
    __weak UITableView *tableView = self.myTableView;
    _page++;
    NSDictionary *dic = @{@"iface":@"DMHY200005",@"flag":_flag,@"pageNo":[NSString stringWithFormat:@"%li",(long)_page]};
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [GloryMode mj_objectWithKeyValues:responseObj];
        
        if (_mode.results.count < 20) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [_dataArr addObjectsFromArray:_mode.results];
            [tableView reloadData];
            [tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        [tableView.mj_footer endRefreshing];
    }];
    
}

- (void)createTitleView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-90, 32, 180, 25)];
//    view.backgroundColor = [UIColor redColor];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(view), HEIGTH(view))];
    iv.image = [UIImage imageNamed:@"back2"];
    iv.userInteractionEnabled = YES;
    [view addSubview:iv];
    NSArray *arr = @[@"日榜",@"周榜",@"月榜"];
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (i!=2) {
            btn.frame = CGRectMake(i*70-i*15, 0, 70, 24);
        } else {
            btn.frame = CGRectMake(110, 0, 70, 24);
        }
        [btn setTitleColor:RGBA(60, 60, 60, 1) forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"back1"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.tag = 10000+i;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        if (i == 0) {
            btn.selected = YES;
            _oldBtn = btn;
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [iv addSubview:btn];
        
    }
    [self.navigationView addSubview:view];
    
    
    
}

- (void)btnClick:(UIButton *)sender {
    _oldBtn.selected = NO;
    sender.selected = YES;
    _oldBtn = sender;
    _flag = [NSString stringWithFormat:@"%ld",sender.tag-10000];
    [self request_Api];

}

#pragma tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20-2+((_page-1)*20);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 340;
    } else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        GloryThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:GloryThreeCell1];
        
        if (_dataArr.count >0) {
            
            if (_dataArr.count >= 3) {
                [cell.oneImage sd_setImageWithURL:[NSURL URLWithString:_dataArr[0].imgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
                cell.oneName.text = _dataArr[0].nickName;
                cell.oneNumber.text = _dataArr[0].amounts;
                [cell.twoImage sd_setImageWithURL:[NSURL URLWithString:_dataArr[1].imgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
                cell.twoName.text = _dataArr[1].nickName;
                cell.twoNumber.text =_dataArr[1].amounts;
                [cell.threeImage sd_setImageWithURL:[NSURL URLWithString:_dataArr[2].imgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
                cell.threeName.text =_dataArr[2].nickName;
                cell.threeNumber.text = _dataArr[2].amounts;
            } else {
                if (_dataArr.count == 1) {
                    [cell.oneImage sd_setImageWithURL:[NSURL URLWithString:_dataArr[0].imgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
                    cell.oneName.text = _dataArr[0].nickName;
                    cell.oneNumber.text =_dataArr[0].amounts;
                    [cell.twoImage setImage:[UIImage imageNamed:@"askB-1"]];
                    cell.twoName.text = @"虚位以待";
                    cell.twoNumber.text =@"";
                    [cell.threeImage setImage:[UIImage imageNamed:@"askB-1"]];
                    cell.threeName.text = @"虚位以待";
                    cell.threeNumber.text = @"";
                } else {
                    [cell.oneImage sd_setImageWithURL:[NSURL URLWithString:_dataArr[0].imgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
                    cell.oneName.text = _dataArr[0].nickName;
                    cell.oneNumber.text = _dataArr[0].amounts;
                    [cell.twoImage sd_setImageWithURL:[NSURL URLWithString:_dataArr[1].imgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
                    cell.twoName.text = _dataArr[1].nickName;
                    cell.twoNumber.text = _dataArr[1].amounts;
                    [cell.threeImage setImage:[UIImage imageNamed:@"askB-1"]];
                    cell.threeName.text = @"虚位以待";
                    cell.threeNumber.text = @"";
                    
                }
                
            }
            
        } else {
            [cell.oneImage setImage:[UIImage imageNamed:@"askB-1"]];
            cell.oneName.text = @"虚位以待";
            cell.oneNumber.text =@"";
            
            [cell.twoImage setImage:[UIImage imageNamed:@"askB-1"]];
            cell.twoName.text = @"虚位以待";
            cell.twoNumber.text =@"";
            [cell.threeImage setImage:[UIImage imageNamed:@"askB-1"]];
            cell.threeName.text = @"虚位以待";
            cell.threeNumber.text = @"";
        
        }
        
        
        return cell;
    } else {
        GloryCell *cell = [tableView dequeueReusableCellWithIdentifier:GloryCell1];
        cell.indexLable.text = [NSString stringWithFormat:@"%ld",indexPath.row+3];
        cell.nameLable.text = @"虚位以待";
        cell.nmberLable.text = @"";
        [cell.icimage setImage:[UIImage imageNamed:@"ask"]];
        if (_dataArr.count >0) {
            if (indexPath.row+2 <= _dataArr.count-1) {
                cell.mode = _dataArr[indexPath.row+2];
            }
        }
        return cell;
    }
    

}


- (void)showRight {
    

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
