//
//  ZDPLCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/23.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "ZDPLCell.h"
#import "ZDPLCollecCell.h"
#import "UMMobClick/MobClick.h"
@implementation ZDPLCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;

}

- (void)createUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的尺寸
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3, 32);
    //flowlaout的属性
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
    _myCollec= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 32) collectionViewLayout:flowLayout];
    _myCollec.backgroundColor = [UIColor whiteColor];
    _myCollec.delegate = self;
    _myCollec.dataSource = self;
    _myCollec.showsHorizontalScrollIndicator = NO;
    //添加到主页面上去
    _myCollec.scrollEnabled = NO;
    [_myCollec registerNib:[UINib nibWithNibName:@"ZDPLCollecCell" bundle:nil] forCellWithReuseIdentifier:@"ZDPLCollecCell"];
    [self.contentView addSubview:_myCollec];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

#pragma mark -UICollectionViewDataSource

//定义每个UICollectionView 的边距

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    
    return UIEdgeInsetsMake ( 10 , 0 , 0, 0 );
    
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
    
    ZDPLCollecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZDPLCollecCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        if (self.ifZan == 0) {
            cell.titleLable.textColor = RGBA(40, 40, 40, 1);
        } else {
            cell.titleLable.textColor = RGBA(255, 42, 80, 1);
        }
        cell.titleLable.text = [NSString stringWithFormat:@"赞(%@)",_zanNumber];
        cell.view.hidden = NO;
    }
    if (indexPath.row == 1) {
        
        if ([BusinessLogic power].length == 0) {
            cell.titleLable.text = @"详情";
        } else {
            if ([[BusinessLogic power] isEqualToString:@"Y"]) {
                cell.titleLable.text = @"打赏";
            } else {
                cell.titleLable.text = @"详情";
            }
            
        }
        
         cell.titleLable.textColor = RGBA(40, 40, 40, 1);
        cell.view.hidden = NO;
    }
    if (indexPath.row == 2) {
        if (_plNumber) {
            cell.titleLable.text = [NSString stringWithFormat:@"评论(%@)",_plNumber];
        } else {
            cell.titleLable.text = @"评论";
        }
        
        cell.view.hidden = YES;
         cell.titleLable.textColor = RGBA(40, 40, 40, 1);
    }
   
    return cell;
}

//UICollectionView被选中时调用的方法

-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
//        UICollectionViewCell * cell = ( UICollectionViewCell *)[collectionView cellForItemAtIndexPath :indexPath];
//    
//        cell. backgroundColor = [ UIColor colorWithRed :(( arc4random ()% 255 )/ 255.0 ) green :(( arc4random ()% 255 )/ 255.0 ) blue :(( arc4random ()% 255 )/ 255.0 ) alpha : 1.0f ];
    
    if (indexPath.row == 1) {
        [MobClick event:@"baskNum"];
    }
    
    if ([self.delegate respondsToSelector:@selector(CollecIndex:ID:)]) {
        
        [self.delegate CollecIndex:indexPath.row ID:_Id];
        
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
