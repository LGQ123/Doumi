//
//  SearchResultController.m
//  douMiApp
//
//  Created by ydz on 2016/11/25.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "SearchResultController.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import "DM_HomeCollecCell.h"
#import "HTCell.h"
#import "SearchDTMode.h"
#import "SearchHTMode.h"
#import "SearchZBMode.h"
#import "PersonageViewController.h"
#import "HTDetailsViewController.h"
#import "DTDetailsViewController.h"
#import "UMMobClick/MobClick.h"
@interface SearchResultController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,HTDelegte>

@property (assign, nonatomic) BOOL isOpen;
@property (assign, nonatomic) NSInteger hPage;
@property (assign, nonatomic) NSInteger wPage;
@property (strong, nonatomic) SearchDTMode *dtMode;
@property (strong, nonatomic) SearchHTMode *htMode;
@property (strong, nonatomic) SearchZBMode *zbMode;
@property (strong, nonatomic) NSMutableArray <SearchZBResults *>*zbDataArr;
@property (strong, nonatomic) NSMutableArray <SearchResults *>*dtDataArr;

@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;

@property (strong, nonatomic) UICollectionView  *myCollec;

@property (strong, nonatomic) UIView *noSearchView;

@end

@implementation SearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//- (void)setSearchStr:(NSString *)searchStr {
//    
//    [self.searchTableView reloadData];
//    
//}

- (void)request_Api {
    
    NSDictionary *dict = @{@"searchHot":_searchStr};
    [MobClick event:@"search" attributes:dict];
    
    
    if (_searchStr.length == 0) {
        [LCProgressHUD showMessage:@"关键词不能为空"];
    } else {
    
    _hPage = 1;
    _wPage = 1;
    _dtDataArr = [[NSMutableArray alloc] init];
    _zbDataArr = [[NSMutableArray alloc] init];
    __weak UITableView *tableView = self.searchTableView;
    //
    NSDictionary *dic = @{@"iface":@"DMHY200018",@"keyWords":_searchStr,@"pageNo":@"1"};//主播信息
    NSDictionary *dic1 = @{@"iface":@"DMHY200003",@"keyWords":_searchStr};//话题
    NSDictionary *dic2 = @{@"iface":@"DMHY200019",@"keyWords":_searchStr,@"pageNo":@"1"};//主播动态
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        //主播信息[MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        _zbMode = [SearchZBMode mj_objectWithKeyValues:responseObj];
        [_zbDataArr addObjectsFromArray:_zbMode.results];
        
        [NetworkRequest post:serVerIP params:dic1 success:^(id responseObj) {
          //话题[MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            _htMode = [SearchHTMode mj_objectWithKeyValues:responseObj];
            
            [NetworkRequest post:serVerIP params:dic2 success:^(id responseObj) {
            //主播动态[MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                 _dtMode = [SearchDTMode mj_objectWithKeyValues:responseObj];
                if (_zbMode.results.count == 0 && _htMode.talkList.count == 0 && _dtMode.results.count == 0) {
                    self.noSearchView.hidden = NO;
                    [tableView.mj_header endRefreshing];
                } else {
                    self.noSearchView.hidden = YES;
               
                [_dtDataArr addObjectsFromArray:_dtMode.results];
                [tableView reloadData];
                if (_dtMode.results.count < 5) {
                    [tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [tableView.mj_footer endRefreshing];
                }
                [tableView.mj_header endRefreshing];
                
                }
            } failure:^(NSError *error) {
                 [tableView.mj_header endRefreshing];
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            }];
            
        } failure:^(NSError *error) {
             [tableView.mj_header endRefreshing];
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        }];
        
    } failure:^(NSError *error) {
         [tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        
    }];
    
    
    
        [self.searchTableView reloadData];
    }
    
}

- (void)requestMoreZB_Api {
    
    _myCollec.frame = CGRectMake(14, 0, SCREEN_WIDTH-14, 100);
    [self.indicatorView stopAnimating];
}

- (void)requestMoreDT_Api {
    __weak UITableView *tableView = _searchTableView;
    _hPage++;
    NSDictionary *dic2 = @{@"iface":@"DMHY200019",@"keyWords":_searchStr,@"pageNo":[NSString stringWithFormat:@"%ld",(long)_hPage]};//主播动态
    [NetworkRequest post:serVerIP params:dic2 success:^(id responseObj) {
        _dtMode = [SearchDTMode mj_objectWithKeyValues:responseObj];
        [_dtDataArr addObjectsFromArray:_dtMode.results];
        [tableView reloadData];
        if (_dtMode.results.count < 5) {
            [tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        [tableView.mj_footer endRefreshing];
    }];
    
}

- (UITableView *)searchTableView {
    
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _searchTableView.backgroundColor = RGBA(247, 247, 247, 1);
        [_searchTableView addSubview:self.noSearchView];
        _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        [_searchTableView registerClass:[HTCell class] forCellReuseIdentifier:@"HTCell"];
        __weak __typeof(self) weakSelf = self;
        _searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf request_Api];
        }];
        
        _searchTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestMoreDT_Api];
        }];
        
    }
    return _searchTableView;
}


- (UIView *)noSearchView {
    if (!_noSearchView) {
        _noSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _noSearchView.backgroundColor = [UIColor whiteColor];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 164, SCREEN_WIDTH, 17)];
        lable.text = @"暂无搜索结果";
        lable.font = [UIFont systemFontOfSize:16];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = RGBA(140, 140, 140, 1);
        [_noSearchView addSubview:lable];
        _noSearchView.hidden =  YES;
    }
    return _noSearchView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_zbMode.results.count > 0 ) {
            return 1;
        } else {
            if (_htMode.talkList.count >= 3) {
                if (_isOpen) {
                    return _htMode.talkList.count;
                } else {
                    return 3;
                }
            } else {
                if (_htMode.talkList.count <= 0) {
                    return 1;
                } else {
                    return _htMode.talkList.count;
                }
                
            }
        }
        
    } else if (section == 1) {
        if (_zbMode.results.count > 0 ) {
            
            if (_htMode.talkList.count > 3) {
                if (_isOpen) {
                    return _htMode.talkList.count;
                } else {
                    return 3;
                }
            } else {
                if (_htMode.talkList.count <= 0) {
                    return 1;
                } else {
                    return _htMode.talkList.count;
                }
            }
        } else {
            return 1;
        }
        
    } else {
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_zbMode.results.count > 0) {
        if (_htMode.talkList.count >0) {
            return _dtDataArr.count +2;
        } else {
            return _dtDataArr.count +1;
        }
    } else {
        if (_htMode.talkList.count >0) {
            return _dtDataArr.count +1;
        } else {
            return _dtDataArr.count;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        if (_zbMode.results.count > 0 ) {
            return 0.01;
        } else {
            if (_htMode.talkList.count > 3) {
                return 20;
            } else {
                return 0.01;
            }
        }
        
    } else if (section == 1) {
        if (_zbMode.results.count > 0 ) {
            
            if (_htMode.talkList.count > 3) {
                return 20;
            } else {
                return 0.01;
            }
        } else {
            return 0.01;
        }
        
    } else {
        return 0.01;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        if (_zbMode.results.count > 0 ) {
            return 100;
        } else {
            if (_htMode.talkList.count > 0) {
                return 40;
            } else {
                return [HTCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
            }
        }
        
    } else if (indexPath.section == 1) {
        if (_zbMode.results.count > 0 ) {
            
            if (_htMode.talkList.count > 0) {
                return 40;
            } else {
                return [HTCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
            }
        } else {
            return [HTCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
        }
        
    } else {
        return [HTCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
    }

    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    footView.backgroundColor = RGBA(220, 220, 220, 1);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"bottom2"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH/2-11, 0, 22, 22);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    
    if (_isOpen) {
        btn.transform=CGAffineTransformMakeRotation(M_PI);
    } else {
        btn.transform=CGAffineTransformMakeRotation(M_PI*2);
    }
    
    if (section == 0) {
        if (_zbMode.results.count > 0 ) {
            return [[UIView alloc] init];
        } else {
            if (_htMode.talkList.count > 3) {
                return footView;
            } else {
                return [[UIView alloc] init];
            }
        }
        
    } else if (section == 1) {
        if (_zbMode.results.count > 0 ) {
            
            if (_htMode.talkList.count > 3) {
                return footView;
            } else {
                return [[UIView alloc] init];
            }
        } else {
            return [[UIView alloc] init];
        }
        
    } else {
        return [[UIView alloc] init];
    }


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0) {
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collecCell"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collecCell"];
//            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//            //设置单元格的尺寸
//            flowLayout.itemSize = CGSizeMake(60, 75);
//            //flowlaout的属性，横向滑动
//            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//            //接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
//            UICollectionView  *_myCollec= [[UICollectionView alloc] initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH, 100) collectionViewLayout:flowLayout];
//            _myCollec.backgroundColor = [UIColor whiteColor];
//            _myCollec.delegate = self;
//            _myCollec.dataSource = self;
//            _myCollec.showsHorizontalScrollIndicator = NO;
//            //添加到主页面上去
//            [_myCollec registerNib:[UINib nibWithNibName:@"DM_HomeCollecCell" bundle:nil] forCellWithReuseIdentifier:@"dm_homeC"];
//            [cell.contentView addSubview:_myCollec];
////            cell.backgroundColor = [UIColor yellowColor];
//            
//            
//        }
//        return cell;
//        
//    } else if (indexPath.section == 1) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchHTID"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchHTID"];
//        }
//        
//        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 39)];
//        lable.text = _htMode.talkList[indexPath.row].title;
//        lable.textAlignment = NSTextAlignmentCenter;
//        lable.font = [UIFont systemFontOfSize:12];
//        lable.textColor = RGBA(40, 40, 40, 1);
//        [cell.contentView addSubview:lable];
//        
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14, 39, SCREEN_WIDTH-14, 1)];
//        line.backgroundColor = RGBA(160, 160, 160, 1);
//        [cell.contentView addSubview:line];
//        return cell;
//    
//    } else {
//        HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
//        cell.searchMode = _dtDataArr[indexPath.section-2];
//        return cell;
//    }
    
    
    if (_zbMode.results.count > 0) {
        if (_htMode.talkList.count >0) {
            if (indexPath.section == 0) {
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collecCell"];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collecCell"];
                    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
                    //设置单元格的尺寸
                    flowLayout.itemSize = CGSizeMake(60, 75);
                    //flowlaout的属性，横向滑动
                    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
                    //接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
                    _myCollec= [[UICollectionView alloc] initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH-14, 100) collectionViewLayout:flowLayout];
                    _myCollec.backgroundColor = [UIColor whiteColor];
                    _myCollec.delegate = self;
                    _myCollec.dataSource = self;
                    _myCollec.showsHorizontalScrollIndicator = NO;
                    //添加到主页面上去
                    [_myCollec registerNib:[UINib nibWithNibName:@"DM_HomeCollecCell" bundle:nil] forCellWithReuseIdentifier:@"dm_homeC"];
                    [cell.contentView addSubview:_myCollec];
                    //            cell.backgroundColor = [UIColor yellowColor];
                    
                }
                return cell;
                
            } else if (indexPath.section == 1) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchHTID"];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchHTID"];
                }
                
                UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 39)];
                lable.text = _htMode.talkList[indexPath.row].title;
                lable.textAlignment = NSTextAlignmentCenter;
                lable.font = [UIFont systemFontOfSize:12];
                lable.textColor = RGBA(40, 40, 40, 1);
                [cell.contentView addSubview:lable];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14, 39, SCREEN_WIDTH-14, 1)];
                line.backgroundColor = RGBA(160, 160, 160, 1);
                line.alpha = 0.5;
                [cell.contentView addSubview:line];
                return cell;
                
            } else {
                HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
                cell.searchMode = _dtDataArr[indexPath.section-2];
                cell.ID = indexPath.section-2;
                cell.delegate = self;
                return cell;
            }
        } else {
            if (indexPath.section == 0) {
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collecCell"];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collecCell"];
                    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
                    //设置单元格的尺寸
                    flowLayout.itemSize = CGSizeMake(60, 75);
                    //flowlaout的属性，横向滑动
                    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
                    //接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
                    _myCollec= [[UICollectionView alloc] initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH-14, 100) collectionViewLayout:flowLayout];
                    _myCollec.backgroundColor = [UIColor whiteColor];
                    _myCollec.delegate = self;
                    _myCollec.dataSource = self;
                    _myCollec.showsHorizontalScrollIndicator = NO;
                    //添加到主页面上去
                    [_myCollec registerNib:[UINib nibWithNibName:@"DM_HomeCollecCell" bundle:nil] forCellWithReuseIdentifier:@"dm_homeC"];
                    [cell.contentView addSubview:_myCollec];
                    //            cell.backgroundColor = [UIColor yellowColor];
                    

                    
                }
                return cell;
                
            } else {
                HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
                cell.searchMode = _dtDataArr[indexPath.section-1];
                cell.ID = indexPath.section-1;
                cell.delegate = self;
                return cell;
                
                }
            
            
        }
    } else {
        if (_htMode.talkList.count >0) {
            if (indexPath.section == 0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchHTID"];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchHTID"];
                }
                
                UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 39)];
                lable.text = _htMode.talkList[indexPath.row].title;
                lable.textAlignment = NSTextAlignmentCenter;
                lable.font = [UIFont systemFontOfSize:12];
                lable.textColor = RGBA(40, 40, 40, 1);
                [cell.contentView addSubview:lable];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14, 39, SCREEN_WIDTH-14, 1)];
                line.backgroundColor = RGBA(160, 160, 160, 1);
                line.alpha = 0.5;
                [cell.contentView addSubview:line];
                return cell;
            } else {
                HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
                cell.searchMode = _dtDataArr[indexPath.section-1];
                cell.ID = indexPath.section-1;
                cell.delegate = self;
                return cell;
            }
        } else {
            HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
            cell.searchMode = _dtDataArr[indexPath.section];
            cell.ID = indexPath.section;
            cell.delegate = self;
            return cell;
        }
        
    }
    
    
    
}

- (void)icDelegate:(NSInteger)ID {
    PersonageViewController *personageVC = [[PersonageViewController alloc] initWithNibName:@"PersonageViewController" bundle:nil];
    personageVC.UUID = [NSString stringWithFormat:@"%ld",(long)_dtDataArr[ID].userId];
    
    [self.navigationController pushViewController:personageVC animated:YES];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",[tableView cellForRowAtIndexPath:indexPath].class);
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[HTCell class]]) {
        HTCell *cell = (HTCell *)[tableView cellForRowAtIndexPath:indexPath];
        DTDetailsViewController *dtDVC = [[DTDetailsViewController alloc] initWithNibName:@"DTDetailsViewController" bundle:nil];
        dtDVC.type = @"dt";
        dtDVC.ID = [NSString stringWithFormat:@"%ld",(long)_dtDataArr[cell.ID].Id];
        [self.navigationController pushViewController:dtDVC animated:YES];
        
    } else {
       
        NSLog(@"123");
        HTDetailsViewController *htDVC = [[HTDetailsViewController alloc] initWithNibName:@"HTDetailsViewController" bundle:nil];
        htDVC.talkId = [NSString stringWithFormat:@"%ld",(long)_htMode.talkList[indexPath.row].Id];
        [self.navigationController pushViewController:htDVC animated:YES];
        
    }
    
}

//全部展开
- (void)btnClick:(UIButton *)sender {
    _isOpen = !_isOpen;
    if (_isOpen) {
       sender.transform=CGAffineTransformMakeRotation(M_PI);
    } else {
     sender.transform=CGAffineTransformMakeRotation(M_PI*2);
    }
    [_searchTableView reloadData];
    
    
}

#pragma mark -UICollectionViewDataSource

//定义每个UICollectionView 的边距

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    
    return UIEdgeInsetsMake ( 20 , 0 , 0, 0 );
    
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 25;
//
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 25;
    
}

//指定组的个数 ，一个大组！！不是一排，是N多排组成的一个大组(与下面区分)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//指定单元格的个数 ，这个是一个组里面有多少单元格，e.g : 一个单元格就是一张图片
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _zbDataArr.count;
}

//构建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DM_HomeCollecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dm_homeC" forIndexPath:indexPath];
    [cell.icimage sd_setImageWithURL:[NSURL URLWithString:_zbDataArr[indexPath.row].imgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    cell.nameLable.text = _zbDataArr[indexPath.row].uname;
    return cell;
}

//UICollectionView被选中时调用的方法

-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    PersonageViewController *personageVC = [[PersonageViewController alloc] initWithNibName:@"PersonageViewController" bundle:nil];
    personageVC.UUID = [NSString stringWithFormat:@"%ld",(long)_zbMode.results[indexPath.row].Id];
    
    [self.navigationController pushViewController:personageVC animated:YES];
    
}

//返回这个UICollectionViewCell是否可以被选择

-( BOOL )collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return YES ;
    
}

#pragma mark 访客记录数据加载
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if(scrollView == _myCollec){
//        //检测左测滑动,开始加载更多
//        if(scrollView.contentOffset.x +SCREEN_WIDTH-14 - scrollView.contentSize.width >30){
//            NSLog(@"scrollview.contentOffset.x-->%f,scrollview.width-->%f,scrollview.contentsize.width--%f",scrollView.contentOffset.x,SCREEN_WIDTH-14,scrollView.contentSize.width);
//            
//            if (_indicatorView == nil) {
//                UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-14 - 20, 0 + 100/2 - 10, 20, 20)];
//                indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//                indicatorView.hidesWhenStopped = YES;
//                indicatorView.backgroundColor = [UIColor redColor];
//                self.indicatorView = indicatorView;
//                [self.indicatorView stopAnimating];
//                [scrollView addSubview:self.indicatorView];
//                
//            }
//            if (!self.indicatorView.isAnimating) {
//                scrollView.frame = CGRectMake(-30, 0, SCREEN_WIDTH-14, 100);
//                [self.indicatorView startAnimating];
//                [self requestMoreZB_Api];
//            }
//            
//        }
//        
//    }
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
