//
//  DM_TopCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/7.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_TopCell.h"
#import "DM_CollecCell.h"
#import "HomeMode.h"
@implementation DM_TopCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createUI];
        self.backgroundColor = RGBA(247, 247, 247, 1);
    }
    return self;


}

- (void)setBannerArr:(NSArray<Bannerlist *> *)bannerArr {
    NSMutableArray *imagesURLStrings = [[NSMutableArray alloc] init];
    for (Bannerlist *mode in bannerArr) {
        [imagesURLStrings addObject:mode.imgUrl];
    }
    _cycleScrollView.imageURLStringsGroup = imagesURLStrings;
}

- (void)createUI{
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*8/15) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    [self.contentView addSubview:_cycleScrollView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的尺寸
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/4, SCREEN_WIDTH*4/15);
    //flowlaout的属性，横向滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
    _myCollectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH*8/15+10, SCREEN_WIDTH, SCREEN_WIDTH*4/15) collectionViewLayout:flowLayout];
    _myCollectionView.tag = 200;
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    //添加到主页面上去
    [self.contentView addSubview:_myCollectionView];
    
    [_myCollectionView registerNib:[UINib nibWithNibName:@"DM_CollecCell" bundle:nil] forCellWithReuseIdentifier:@"btnCell"];
    

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
    return 4;
}

//构建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        DM_CollecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"btnCell" forIndexPath:indexPath];
    cell.icimage.image = [UIImage imageNamed:_imageArr[indexPath.row]];
    cell.title.text = _imageArr[indexPath.row];
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

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    
    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section

{
    
    return 0;
    
}


//UICollectionView被选中时调用的方法

-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
//    UICollectionViewCell * cell = ( UICollectionViewCell *)[collectionView cellForItemAtIndexPath :indexPath];
//    
//    cell. backgroundColor = [ UIColor colorWithRed :(( arc4random ()% 255 )/ 255.0 ) green :(( arc4random ()% 255 )/ 255.0 ) blue :(( arc4random ()% 255 )/ 255.0 ) alpha : 1.0f ];
    if ([self.delegate respondsToSelector:@selector(collecTouchIndes:)]) {
        [self.delegate collecTouchIndes:indexPath.row];
    }
    
}

//返回这个UICollectionViewCell是否可以被选择

-( BOOL )collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return YES ;
    
}

//点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    if ([self.delegate respondsToSelector:@selector(bannerIndex:)]) {
        [self.delegate bannerIndex:index];
    }
}



- (NSArray *)imageArr {
    if (!_imageArr) {
        _imageArr = [[NSArray alloc] init];
    }
    return _imageArr;

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // 情景二：采用网络图片实现
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
