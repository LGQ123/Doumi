//
//  DM_MeYuECell.m
//  douMiApp
//
//  Created by ydz on 2016/11/21.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_MeYuECell.h"
#import "Me_YuECollecCell.h"

@implementation DM_MeYuECell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self createUI];
}

- (void)createUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的尺寸
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3, 50);
    //flowlaout的属性，横向滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
    _myCollecTV= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) collectionViewLayout:flowLayout];
    _myCollecTV.backgroundColor = [UIColor whiteColor];
    _myCollecTV.delegate = self;
    _myCollecTV.dataSource = self;
    _myCollecTV.showsHorizontalScrollIndicator = NO;
    //添加到主页面上去
    [_myCollecTV registerNib:[UINib nibWithNibName:@"Me_YuECollecCell" bundle:nil] forCellWithReuseIdentifier:@"Me_YuECollecCell"];
    [self.contentView addSubview:_myCollecTV];
    
}


#pragma mark -UICollectionViewDataSource

//定义每个UICollectionView 的边距

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    
    return UIEdgeInsetsMake ( 0 , 0 , 0, 0 );
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
    
}

//指定组的个数 ，一个大组！！不是一排，是N多排组成的一个大组(与下面区分)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//指定单元格的个数 ，这个是一个组里面有多少单元格，e.g : 一个单元格就是一张图片
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

//构建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Me_YuECollecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Me_YuECollecCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.titleLable.text = @"余额";
        cell.lineView.hidden = NO;
        [cell.logoImage setImage:[UIImage imageNamed:@"money"]];
    }
    if (indexPath.row == 1) {
        cell.titleLable.text = @"蜜豆荚";
        cell.lineView.hidden = NO;
        [cell.logoImage setImage:[UIImage imageNamed:@"蜜豆荚"]];
    }
    if (indexPath.row == 2) {
        cell.titleLable.text = @"蜜分期";
        cell.lineView.hidden = YES;
        [cell.logoImage setImage:[UIImage imageNamed:@"蜜分期"]];
    }
    if (_dataArr.count == 0) {
        
    } else {
    if (indexPath.row < 2) {
        cell.numberLable.text = _dataArr[indexPath.row];
    } else {
        if ([_dataArr[indexPath.row] isEqualToString:@"-1"]) {
            cell.numberLable.text = @"未开通";
        } else {
            cell.numberLable.text = _dataArr[indexPath.row];
        }
    
    }
    }
    return cell;
}

//UICollectionView被选中时调用的方法

-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    //    UICollectionViewCell * cell = ( UICollectionViewCell *)[collectionView cellForItemAtIndexPath :indexPath];
    //
    //    cell. backgroundColor = [ UIColor colorWithRed :(( arc4random ()% 255 )/ 255.0 ) green :(( arc4random ()% 255 )/ 255.0 ) blue :(( arc4random ()% 255 )/ 255.0 ) alpha : 1.0f ];
    if ([self.delegate respondsToSelector:@selector(touchYuECollec:)]) {
        [self.delegate touchYuECollec:indexPath.row];
    }
    
}

//返回这个UICollectionViewCell是否可以被选择

-( BOOL )collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return YES ;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
