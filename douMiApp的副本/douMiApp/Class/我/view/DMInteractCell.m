//
//  DMInteractCell.m
//  douMiApp
//
//  Created by ydz on 2016/12/30.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DMInteractCell.h"
#import "UIView+WHC_AutoLayout.h"
#import "InteractMode.h"
@interface DMInteractCell ()

@property (strong, nonatomic) UIImageView *icImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *contentLable;
@property (strong, nonatomic) UILabel *daShanLable;
@property (strong, nonatomic) UILabel *timeLable;
@end


@implementation DMInteractCell


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
    [self.icImageView whc_Height:60];
    [self.icImageView whc_Width:60];
    self.icImageView.layer.cornerRadius = 30;
    self.icImageView.layer.masksToBounds = YES;
    self.icImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *icTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(icTap:)];
    [self.icImageView addGestureRecognizer:icTap];
    
    
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.font = [UIFont boldSystemFontOfSize:12];
    self.nameLable.textColor = RGBA(40, 40, 40, 1);
    [self.contentView addSubview:self.nameLable];
    [self.nameLable whc_TopSpace:14];
    [self.nameLable whc_LeftSpace:10 relativeView:self.icImageView];
    [self.nameLable whc_Width:120];
    [self.nameLable whc_Height:12];
    
    self.daShanLable = [[UILabel alloc] init];
    self.daShanLable.font = [UIFont systemFontOfSize:12];
    self.daShanLable.textAlignment = NSTextAlignmentRight;
    self.daShanLable.textColor = RGBA(255, 42, 80, 1);
    [self.contentView addSubview:self.daShanLable];
    [self.daShanLable whc_RightSpace:15];
    [self.daShanLable whc_TopSpace:14];
    [self.daShanLable whc_LeftSpace:10 relativeView:self.nameLable];
    [self.daShanLable whc_Height:12];
    
    self.timeLable = [[UILabel alloc] init];
    self.timeLable.font = [UIFont systemFontOfSize:10];
    self.timeLable.textAlignment = NSTextAlignmentLeft;
    self.timeLable.textColor = RGBA(140, 140, 140, 1);
    [self.contentView addSubview:self.timeLable];
    [self.timeLable whc_TopSpace:10 relativeView:self.nameLable];
    [self.timeLable whc_LeftSpace:10 relativeView:self.icImageView];
    [self.timeLable whc_Width:220];
    [self.timeLable whc_Height:12];
    
    
    self.contentLable = [[UILabel alloc] init];
    self.contentLable.font = [UIFont systemFontOfSize:12];
    self.contentLable.textColor = RGBA(40, 40, 40, 1);
    [self.contentView addSubview:self.contentLable];
    [self.contentLable whc_LeftSpace:10 relativeView:self.icImageView];
    [self.contentLable whc_TopSpace:10 relativeView:self.timeLable];
    [self.contentLable whc_RightSpace:15];
    [self.contentLable whc_Height:12];
    
    /*UIView *v = [[UIView alloc] init];
    v.backgroundColor = RGBA(160, 160, 160, 1);
    v.alpha = 0.5;
    [self.contentView addSubview:v];
    [v whc_LeftSpace:15];
    [v whc_TopSpace:10 relativeView:self.contentLable];
    [v whc_RightSpace:0];
    [v whc_Height:1];*/
    
    self.icImageView.image = [UIImage imageNamed:@"ask"];
    self.nameLable.text = @"www";
    self.contentLable.text = @"烦烦烦烦烦福福福福福福福福福";
    self.timeLable.text = @"111";
}


- (void)icTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(DMInteractTouch:)]) {
        [self.delegate DMInteractTouch:self.ID];
    }
}

- (void)setMode:(Map *)mode {
    
    [self.icImageView sd_setImageWithURL:[NSURL URLWithString:mode.imgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    self.nameLable.text = mode.uname;
    self.timeLable.text = mode.createTime;
    if ([mode.commentId isEqualToString:@"0"]) {
        self.contentLable.text = @"♡";
    } else {
        self.contentLable.text = mode.comment;
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
