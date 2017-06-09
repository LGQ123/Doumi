//
//  QuizCell.m
//  douMiApp
//
//  Created by ydz on 2016/12/10.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "QuizCell.h"
#import "UIView+WHC_AutoLayout.h"



@implementation QuizCell


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
    self.titleLable.font = [UIFont boldSystemFontOfSize:12];
    self.titleLable.textColor = RGBA(40, 40, 40, 1);
    [self.contentView addSubview:self.titleLable];
    [self.titleLable whc_LeftSpace:15];
    [self.titleLable whc_TopSpace:20];
    [self.titleLable whc_RightSpace:15];
    [self.titleLable whc_HeightAuto];
    
    self.contentLable = [[UILabel alloc] init];
    self.contentLable.font = [UIFont systemFontOfSize:12];
    self.contentLable.textColor = RGBA(139, 139, 139, 1);
    [self.contentView addSubview:self.contentLable];
    [self.contentLable whc_LeftSpace:15];
    [self.contentLable whc_TopSpace:20 relativeView:self.titleLable];
    [self.contentLable whc_RightSpace:15];
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
