//
//  PersonalFileController.m
//  douMiApp
//
//  Created by ydz on 2016/11/24.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "PersonalFileController.h"

#import "DM_MeHomeTCell.h"
#import "FileCell.h"
#import "FileCollectionCell.h"
#import "PersonalFileMode.h"
#import "UIButton+WebCache.h"
@interface PersonalFileController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *dataArr;
@property (strong, nonatomic) NSArray *dataArr1;
@property (strong, nonatomic) NSArray *xiQuAihaoArr;
@property (strong, nonatomic) NSArray *guaniianZiArr;
@property (assign, nonatomic) NSInteger num;
@property (strong, nonatomic) PersonalFileMode *mode;
/** 导航条View */
@property (nonatomic, weak) UIView *navBarView;
@end

@implementation PersonalFileController

- (UIView *)navBarView {
    if (!_navBarView) {
        UIView *navBarView = [[UIView alloc] init];
        navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        [self.view addSubview:navBarView];
        self.navBarView = navBarView;
    }
    return _navBarView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > 10) {
        
        self.navBarView.backgroundColor = RGBA(0, 0, 0, 0.8);
        
    } else {
        self.navBarView.backgroundColor = RGBA(0, 0, 0, 0);
    }
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
    [MobClick beginLogPageView:@"个人档案页"];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"个人档案页"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _dataArr = @[@[@"生日",@"星座",@"梦想"],@[@"微信号",@"微博昵称"],@[@"兴趣爱好",@"主播关键字"]];
    
    [self addItem:nitem_left btnTitleArr:@[@"BackW"]];
    self.lable.text = @"个人档案";
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    [_myTableView registerNib:[UINib nibWithNibName:@"DM_MeHomeTCell" bundle:nil] forCellReuseIdentifier:@"DM_MeHomeTCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"FileCell" bundle:nil] forCellReuseIdentifier:@"FileCell"];
    [self request_Api];
}

- (void)request_Api {
    __weak UITableView *tableView = _myTableView;
    //    NSDictionary *dic;
    //    if ([BusinessLogic uuid].length == 0) {
    //      dic  = @{@"iface":@"DMHY400004"};
    //    } else {
    NSDictionary *dic  = @{@"iface":@"DMHY400004",@"userId":self.ID};
    //    }
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        _mode = [PersonalFileMode mj_objectWithKeyValues:responseObj];
        _dataArr1 = @[@[_mode.birthday,_mode.constellation,_mode.dream],@[_mode.weixinNum,_mode.weiboName],@[_mode.hobby,_mode.radioType]];
        _xiQuAihaoArr = [_mode.hobby componentsSeparatedByString:@","];
        _guaniianZiArr = [_mode.radioType componentsSeparatedByString:@","];
        [tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 2;
    } else {
        return 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return 100;
        } else {
            return 50;
        }
    } else if (indexPath.section == 0) {
        return SCREEN_WIDTH*240/375;
        
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DM_MeHomeTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DM_MeHomeTCell"];
        [cell.FensILable setTitle:@"YY号" forState:UIControlStateNormal];
        [cell.guanZhuLable setTitle:@"工会频道" forState:UIControlStateNormal];
        [cell.ronYaoLable setTitle:@"直播间号" forState:UIControlStateNormal];
        [cell.fenSiNum setTitle:_mode.yyAcount.length==0?@"未设置":_mode.yyAcount forState:UIControlStateNormal];
        [cell.guanZhuNum setTitle:_mode.channel.length==0?@"未设置":_mode.channel forState:UIControlStateNormal];
        [cell.ronYaoNum setTitle:_mode.roomNum.length==0?@"未设置":_mode.roomNum forState:UIControlStateNormal];
        [cell.icImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_mode.imgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"dog"]];
        return cell;
    } else {
        FileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileCell"];
        cell.titleLAble.text = _dataArr[indexPath.section-1][indexPath.row];
        NSString *str = _dataArr1[indexPath.section-1][indexPath.row];
        cell.contentLable.text = str.length == 0?@"未设置":str;
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                _num = 8;
            } else {
                _num = 4;
            }
            cell.contentLable.hidden = YES;
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            //设置单元格的尺寸
            flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-130)/4, 25);
            //flowlaout的属性，横向滑动
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            //接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
            UICollectionView *_myCollec= [[UICollectionView alloc] initWithFrame:CGRectMake(90, 13, SCREEN_WIDTH-100, _num/4*30) collectionViewLayout:flowLayout];
            _myCollec.backgroundColor = [UIColor whiteColor];
            _myCollec.delegate = self;
            _myCollec.dataSource = self;
            _myCollec.showsHorizontalScrollIndicator = NO;
            //添加到主页面上去
            [_myCollec registerNib:[UINib nibWithNibName:@"FileCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"FileCollectionCell"];
            [cell.contentView addSubview:_myCollec];
            
        }
        return cell;
    }
}


#pragma mark-UICollectionViewDelegate
#pragma mark -UICollectionViewDataSource

//定义每个UICollectionView 的边距

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    
    return UIEdgeInsetsMake ( 0 , 0 , 0, 0 );
    
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 13;
//
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
    
}

//指定组的个数 ，一个大组！！不是一排，是N多排组成的一个大组(与下面区分)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//指定单元格的个数 ，这个是一个组里面有多少单元格，e.g : 一个单元格就是一张图片
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _num;
}

//构建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FileCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FileCollectionCell" forIndexPath:indexPath];
    
    
    if (_num == 8) {
        if (indexPath.row < _xiQuAihaoArr.count) {
            NSString *str = _xiQuAihaoArr[indexPath.row];
            cell.cellLable.text = str.length == 0?@"未设置":str;
            cell.cellLable.layer.borderWidth = 1;
        } else {
            cell.cellLable.layer.borderWidth = 0;
        }
    } else {
        if (indexPath.row < _guaniianZiArr.count) {
            NSString *str = _guaniianZiArr[indexPath.row];
            cell.cellLable.text =  str.length == 0?@"未设置":str;
        } else {
            cell.cellLable.layer.borderWidth = 0;
        }
    }
    return cell;
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
