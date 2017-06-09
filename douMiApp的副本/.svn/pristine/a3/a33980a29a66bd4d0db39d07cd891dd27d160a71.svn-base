//
//  ZiLiaoCell.m
//  douMiApp
//
//  Created by ydz on 2016/12/12.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "ZiLiaoCell.h"
#import "UIView+WHC_AutoLayout.h"
@implementation ZiLiaoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createCellView];
    }
    return self;
}

- (void)createCellView {
    
    self.titleLable = [[UILabel alloc] init];
    self.titleLable.font = [UIFont systemFontOfSize:12];
    self.titleLable.textColor = RGBA(40, 40, 40, 1);
    self.titleLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLable];
    [self.titleLable whc_LeftSpace:15];
    [self.titleLable whc_TopSpace:19];
    [self.titleLable whc_Width:65];
    [self.titleLable whc_Height:13];
    
    self.contentLable = [[UILabel alloc] init];
    self.contentLable.font = [UIFont systemFontOfSize:12];
    self.contentLable.textAlignment = NSTextAlignmentRight;
    self.contentLable.textColor = RGBA(139, 139, 139, 1);
    [self.contentView addSubview:self.contentLable];
    [self.contentLable whc_LeftSpace:95];
    [self.contentLable whc_TopSpace:19];
    [self.contentLable whc_RightSpace:10];
    [self.contentLable whc_HeightAuto];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
