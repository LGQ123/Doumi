//
//  HTPLCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "HTPLCell.h"
#import "UIView+WHC_AutoLayout.h"
#import "UIImageView+WebCache.h"
#import "DynamicListMode.h"
@interface HTPLCell ()

@property (strong, nonatomic) UIImageView *icImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *contentLable;
@property (strong, nonatomic) UILabel *daShanLable;
@end

@implementation HTPLCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createCellView];
    }
    return self;
}

- (void)createCellView{
    
    self.icImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.icImageView];
    [self.icImageView whc_LeftSpace:14];
    [self.icImageView whc_TopSpace:10];
    [self.icImageView whc_Height:30];
    [self.icImageView whc_Width:30];
    self.icImageView.layer.cornerRadius = 15;
    self.icImageView.layer.masksToBounds = YES;
    self.icImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *icTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(icTap:)];
    [self.icImageView addGestureRecognizer:icTap];
    
    
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.font = [UIFont boldSystemFontOfSize:12];
    self.nameLable.textColor = RGBA(40, 40, 40, 1);
    [self.contentView addSubview:self.nameLable];
    [self.nameLable whc_TopSpace:20];
    [self.nameLable whc_LeftSpace:10 relativeView:self.icImageView];
    [self.nameLable whc_Width:120];
    [self.nameLable whc_Height:12];
    
    self.daShanLable = [[UILabel alloc] init];
    self.daShanLable.font = [UIFont systemFontOfSize:12];
    self.daShanLable.textAlignment = NSTextAlignmentRight;
    self.daShanLable.textColor = RGBA(255, 42, 80, 1);
    [self.contentView addSubview:self.daShanLable];
    [self.daShanLable whc_RightSpace:15];
    [self.daShanLable whc_TopSpace:20];
    [self.daShanLable whc_LeftSpace:10 relativeView:self.nameLable];
    [self.daShanLable whc_Height:12];
    
    self.contentLable = [[UILabel alloc] init];
    self.contentLable.font = [UIFont systemFontOfSize:12];
    self.contentLable.textColor = RGBA(140, 140, 140, 1);
    [self.contentView addSubview:self.contentLable];
    [self.contentLable whc_LeftSpace:15];
    [self.contentLable whc_TopSpace:10 relativeView:self.icImageView];
    [self.contentLable whc_RightSpace:15];
    [self.contentLable whc_HeightAuto];
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = RGBA(160, 160, 160, 1);
    v.alpha = 0.5;
    [self.contentView addSubview:v];
    [v whc_LeftSpace:15];
    [v whc_TopSpace:10 relativeView:self.contentLable];
    [v whc_RightSpace:0];
    [v whc_Height:1];
    
    self.icImageView.image = [UIImage imageNamed:@"ask"];
    self.nameLable.text = @"www";
    self.contentLable.text = @"烦烦烦烦烦福福福福福福福福福";
    
}

- (void)setMode:(Comments *)mode {
    [self.icImageView sd_setImageWithURL:[NSURL URLWithString:mode.headImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    self.nameLable.text = mode.uname;
    if (mode.type == 0) {
        self.contentLable.text = mode.comment;
    } else {
        self.contentLable.text = [NSString stringWithFormat:@"回复%@:%@",mode.buname,mode.comment];
    }
    if ([[NSString stringWithFormat:@"%.2f",mode.money] isEqualToString:@"0.00"] || [[BusinessLogic power] isEqualToString:@"N"]) {
        self.daShanLable.hidden = YES;
    } else {
        self.daShanLable.text = [NSString stringWithFormat:@"打赏%.2f",mode.money];
        self.daShanLable.hidden = NO;
        
    }
    
    
    
}

- (void)icTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(htplIcTouch:)]) {
        [self.delegate htplIcTouch:self.ID];
    }
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
