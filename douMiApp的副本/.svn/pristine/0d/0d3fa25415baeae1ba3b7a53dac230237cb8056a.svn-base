//
//  FoundTuiJianCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/29.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "FoundTuiJianCell.h"
#import "DM_HomeCollecCell.h"
@implementation FoundTuiJianCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的尺寸
    flowLayout.itemSize = CGSizeMake(60, 75);
    //flowlaout的属性，横向滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
    _myCollec= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 75) collectionViewLayout:flowLayout];
    _myCollec.backgroundColor = [UIColor whiteColor];
    _myCollec.delegate = self;
    _myCollec.dataSource = self;
    _myCollec.showsHorizontalScrollIndicator = NO;
    //添加到主页面上去
    [_myCollec registerNib:[UINib nibWithNibName:@"DM_HomeCollecCell" bundle:nil] forCellWithReuseIdentifier:@"dm_homeC"];
    [self.contentView addSubview:_myCollec];
}

#pragma mark -UICollectionViewDataSource

//定义每个UICollectionView 的边距

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    
    return UIEdgeInsetsMake ( 0 , 15 , 0, 15 );
    
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 25;
//
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (SCREEN_WIDTH-30-240)/3;
    
}

//指定组的个数 ，一个大组！！不是一排，是N多排组成的一个大组(与下面区分)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//指定单元格的个数 ，这个是一个组里面有多少单元格，e.g : 一个单元格就是一张图片
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

//构建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DM_HomeCollecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dm_homeC" forIndexPath:indexPath];
    return cell;
}

//UICollectionView被选中时调用的方法

-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    //    UICollectionViewCell * cell = ( UICollectionViewCell *)[collectionView cellForItemAtIndexPath :indexPath];
    //
    //    cell. backgroundColor = [ UIColor colorWithRed :(( arc4random ()% 255 )/ 255.0 ) green :(( arc4random ()% 255 )/ 255.0 ) blue :(( arc4random ()% 255 )/ 255.0 ) alpha : 1.0f ];
    
}

//返回这个UICollectionViewCell是否可以被选择

-( BOOL )collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return YES ;
    
}
- (IBAction)closeTouch:(UIButton *)sender {
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
