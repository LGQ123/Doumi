//
//  DM_AnchorListController.m
//  douMiApp
//
//  Created by ydz on 2016/11/18.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_AnchorListController.h"
#import "AnchorCollecCell.h"
#import "YZDisplayViewHeader.h"
#import "PersonageViewController.h"
#import "AnchorMode.h"
@interface DM_AnchorListController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)UICollectionView *myCollectionView;

@property (strong, nonatomic)AnchorMode *mode;

@property (strong, nonatomic) NSMutableArray <Anchorlist *>*dataArr;

@property (assign, nonatomic) NSInteger page;

@property (copy, nonatomic) NSString *type;;


@end

@implementation DM_AnchorListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBA(247, 247, 247, 1);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(request_Api) name:YZDisplayViewClickOrScrollDidFinshNote object:self];
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"AnchorCollecCell" bundle:nil] forCellWithReuseIdentifier:@"AnchorCollecCell"];
    
    __weak __typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.myCollectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{

            // 结束刷新
            [weakSelf request_Api];
        
    }];
//    [self.myCollectionView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.myCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
       [weakSelf requestMore_Api];
    }];
    // 默认先隐藏footer
//    self.myCollectionView.mj_footer.hidden = YES;
    
}


- (void)request_Api {
    _page = 1;
    _dataArr = [[NSMutableArray alloc] init];
    
    if ([self.title isEqualToString:@"全部"]) {
        _type = @"all";
    }
    if ([self.title isEqualToString:@"热门"]) {
        _type = @"hot";
    }
    if ([self.title isEqualToString:@"全部"]) {
        _type = @"all";
    }
    if ([self.title isEqualToString:@"游戏"]) {
        _type = @"0";
    }
    if ([self.title isEqualToString:@"明星"]) {
        _type = @"1";
    }
    if ([self.title isEqualToString:@"脱口秀"]) {
        _type = @"2";
    }
    if ([self.title isEqualToString:@"娱乐"]) {
        _type = @"3";
    }
    if ([self.title isEqualToString:@"户外"]) {
        _type = @"4";
    }
    if ([self.title isEqualToString:@"熊猫直播"]) {
        _type = @"panda";
    }
    if ([self.title isEqualToString:@"YY直播"]) {
        _type = @"yy";
    }
    if ([self.title isEqualToString:@"最新"]) {
        _type = @"new";
    }
    __weak UICollectionView *collectionView = _myCollectionView;
    NSDictionary *dic;
    
    if ([BusinessLogic uuid].length == 0) {
        dic = @{@"iface":@"DMHY200006",@"type":_type,@"current":[NSString stringWithFormat:@"%ld",(long)_page]};
    } else {
    dic = @{@"iface":@"DMHY200006",@"userId":[BusinessLogic uuid],@"type":_type,@"current":[NSString stringWithFormat:@"%ld",(long)_page]};
    }
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [AnchorMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.anchorList];
        [collectionView reloadData];
        [collectionView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [collectionView.mj_header endRefreshing];
    }];
    

}

- (void)requestMore_Api {
    _page++;
    __weak UICollectionView *collectionView = _myCollectionView;
    NSDictionary *dic;
    
    if ([BusinessLogic uuid].length == 0) {
        dic = @{@"iface":@"DMHY200006",@"type":_type,@"current":[NSString stringWithFormat:@"%ld",(long)_page]};
    } else {
        dic = @{@"iface":@"DMHY200006",@"userId":[BusinessLogic uuid],@"type":_type,@"current":[NSString stringWithFormat:@"%ld",(long)_page]};
    }
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [AnchorMode mj_objectWithKeyValues:responseObj];
        [_dataArr addObjectsFromArray:_mode.anchorList];
        [collectionView reloadData];
        [collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [collectionView.mj_footer endRefreshing];
    }];
    
}

#pragma mark -UICollectionViewDataSource
//指定组的个数 ，一个大组！！不是一排，是N多排组成的一个大组(与下面区分)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//指定单元格的个数 ，这个是一个组里面有多少单元格，e.g : 一个单元格就是一张图片
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}

//构建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AnchorCollecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnchorCollecCell" forIndexPath:indexPath];
    cell.mode = _dataArr[indexPath.row];
    return cell;
}

//定义每个UICollectionView 的边距

//-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section
//
//{
//
//    return UIEdgeInsetsMake ( 1 , 1 , 0.1, 0.1 );
//
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//
//{
//    
//    return 10;
//    
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//
//{
//    
//    return 0;
//    
//}


//UICollectionView被选中时调用的方法

-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    
    PersonageViewController *personageVC = [[PersonageViewController alloc] initWithNibName:@"PersonageViewController" bundle:nil];
    personageVC.UUID = [NSString stringWithFormat:@"%ld",(long)_dataArr[indexPath.row].anchorId];
    [self.navigationController pushViewController:personageVC animated:YES];
    
}

//返回这个UICollectionViewCell是否可以被选择

-( BOOL )collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return YES ;
    
}


- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //设置单元格的尺寸
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-38)/2, (SCREEN_WIDTH-38)/2);
        //flowlaout的属性，
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 10;
        //接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
        _myCollectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(14, 99, SCREEN_WIDTH-28, SCREEN_HEIGHT-99) collectionViewLayout:flowLayout];
        _myCollectionView.tag = 200;
        _myCollectionView.backgroundColor = RGBA(247, 247, 247, 1);
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.showsVerticalScrollIndicator = NO;
//        _myCollectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        //添加到主页面上去
        [self.view addSubview:_myCollectionView];
    }
    return _myCollectionView;
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
