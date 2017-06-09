//
//  HTCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/22.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "HTCell.h"
#import "UIView+WHC_AutoLayout.h"
#import "UIImageView+WebCache.h"
#import "SearchDTMode.h"
#import "DynamicListMode.h"
#import "HTDetailsMode.h"
#import "PersonalMode.h"
#import "XHWebImageAutoSize.h"
#import <YYCache.h>

NSString * const GQCache = @"GQCache";
@interface HTCell ()
@property (strong, nonatomic) UIImageView *icImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) UILabel *contentLable;
@property (strong, nonatomic) UIImageView *contengImageView;

@property (strong, nonatomic) UIView *talkView;
@property (strong, nonatomic) UIImageView *picMinImage;
@property (strong, nonatomic) UILabel *talkTtile;
@property (strong, nonatomic) UILabel *talkContent;
@property (strong, nonatomic) UILabel *hotLable;
@property (strong, nonatomic) UIImageView *hotIV;

@end

@implementation HTCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createCellView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)createCellView {
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
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.btn1.backgroundColor = [UIColor yellowColor];
    [self.btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btn1];
    [self.btn1 whc_TopSpace:20];
    [self.btn1 whc_LeftSpace:SCREEN_WIDTH-14-30];
    [self.btn1 whc_Width:30];
    [self.btn1 whc_Height:30];
//    self.btn1.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
//    self.btn2.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.btn2];
    [self.btn2 whc_TopSpace:20];
    [self.btn2 whc_LeftSpace:SCREEN_WIDTH-54-30];
    [self.btn2 whc_Width:30];
    [self.btn2 whc_Height:30];
//    self.btn2.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.font = [UIFont boldSystemFontOfSize:12];
    
    self.nameLable.textColor = RGBA(40, 40, 40, 1);
    [self.contentView addSubview:self.nameLable];
    [self.nameLable whc_TopSpace:25];
    [self.nameLable whc_LeftSpace:10 relativeView:self.icImageView];
    [self.nameLable whc_RightSpace:15];
    [self.nameLable whc_Height:12];
    
    
    self.timeLable = [[UILabel alloc] init];
    self.timeLable.font = [UIFont systemFontOfSize:12];
    self.timeLable.textColor = RGBA(140, 140, 140, 1);
    [self.contentView addSubview:self.timeLable];
    [self.timeLable whc_LeftSpace:10 relativeView:self.icImageView];
    [self.timeLable whc_TopSpace:10 relativeView:self.nameLable];
    [self.timeLable whc_RightSpace:15];
    [self.timeLable whc_Height:10];
    
    
    
    self.contentLable = [[UILabel alloc] init];
    self.contentLable.font = [UIFont systemFontOfSize:12];
    self.contentLable.textColor = RGBA(39, 39, 39, 1);
     UITapGestureRecognizer *conlableTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(conlableTap:)];
    [self.contentLable addGestureRecognizer:conlableTap];
    [self.contentView addSubview:self.contentLable];
    [self.contentLable whc_LeftSpace:15];
    [self.contentLable whc_TopSpace:20 relativeView:self.icImageView];
    [self.contentLable whc_RightSpace:15];
    [self.contentLable whc_HeightAuto];
    
    
    self.talkView = [[UIView alloc] init];
    self.talkView.backgroundColor = RGBA(240, 240, 240, 1);
    [self.contentView addSubview:self.talkView];
    UITapGestureRecognizer *talkTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(talkTap:)];
    [self.talkView addGestureRecognizer:talkTap];
    [self.talkView whc_LeftSpace:15];
    [self.talkView whc_TopSpace:10 relativeView:self.contentLable];
    [self.talkView whc_RightSpace:15];
    
    self.picMinImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [self.talkView addSubview:self.picMinImage];
    
    self.talkTtile = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, SCREEN_WIDTH-125, 10)];
    self.talkTtile.textColor = RGBA(40, 40, 40, 1);
    self.talkTtile.font = [UIFont boldSystemFontOfSize:10];
    self.talkTtile.textAlignment = NSTextAlignmentLeft;
    [self.talkView addSubview:self.talkTtile];
    
    self.talkContent = [[UILabel alloc] initWithFrame:CGRectMake(90, 35,SCREEN_WIDTH-125, 10)];
    self.talkContent.textColor = [UIColor lightGrayColor];
    self.talkContent.font = [UIFont systemFontOfSize:10];
    self.talkContent.textAlignment = NSTextAlignmentLeft;
    [self.talkView addSubview:self.talkContent];
    
    self.hotIV = [[UIImageView alloc] initWithFrame:CGRectMake(90, 55, 6, 10)];
    self.hotIV.image = [UIImage imageNamed:@"thermograph"];
    [self.talkView addSubview:self.hotIV];
    
    self.hotLable = [[UILabel alloc] initWithFrame:CGRectMake(105, 55, SCREEN_WIDTH-140, 10)];
    self.hotLable.textColor = RGBA(40, 40, 40, 1);
    self.hotLable.font = [UIFont systemFontOfSize:10];
    self.hotLable.textAlignment = NSTextAlignmentLeft;
    [self.talkView addSubview:self.hotLable];
    
    self.picMinImage.hidden = YES;
    self.talkTtile.hidden = YES;
    self.talkContent.hidden =YES;
    self.hotIV.hidden = YES;
    self.hotLable.hidden = YES;
    
    
    self.contengImageView = [[UIImageView alloc] init];
     UITapGestureRecognizer *conImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(conImageTap:)];
    [self.contengImageView addGestureRecognizer:conImageTap];
    [self.contentView addSubview:self.contengImageView];
    [self.contengImageView whc_LeftSpace:0];
    [self.contengImageView whc_RightSpace:0];
    [self.contengImageView whc_TopSpace:20 relativeView:self.talkView];
//    [self.contengImageView whc_Height:SCREEN_WIDTH*200/375];
    
    
}

- (void)setSearchMode:(SearchResults *)searchMode {
    [self.icImageView sd_setImageWithURL:[NSURL URLWithString:searchMode.imgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    self.nameLable.text = searchMode.uname;
    self.timeLable.text = searchMode.createTime;
    self.contentLable.text = searchMode.content;
    self.contengImageView.image = [UIImage imageNamed:@"ask"];
    if (searchMode.contentType== 0) {
        //纯文本
        [self.contengImageView whc_Height:0];
    } else if (searchMode.contentType == 1) {
        //图片
       
        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:searchMode.imgVideoUrl] placeholderImage:nil];
        [self.contengImageView whc_Height:[[self cacheApiKey:searchMode.imgVideoUrl] floatValue]];
        
        
//        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:searchMode.imgVideoUrl]]];
//        
//        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:searchMode.imgVideoUrl] placeholderImage:nil];
//        if (!image) {
//            [self.contengImageView whc_Height:0];
//            
//        } else {
//            
//            [self.contengImageView whc_Height:SCREEN_WIDTH*image.size.height/image.size.width];
//            
//        }
    } else {
        
        if (searchMode.videoCover.length == 0) {
            
        } else {
            [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:searchMode.videoCover] placeholderImage:nil];
            [self.contengImageView whc_Height:[[self cacheApiKey:searchMode.videoCover] floatValue]];
        //视频
//        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:searchMode.videoCover]]];
//        
//        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:searchMode.videoCover] placeholderImage:nil];
//        if (!image) {
//            [self.contengImageView whc_Height:0];
//            
//        } else {
//            
//            [self.contengImageView whc_Height:SCREEN_WIDTH*image.size.height/image.size.width];
//        }
        }
    }

}

- (void)setResultsMode:(Results *)resultsMode {
    [self.icImageView sd_setImageWithURL:[NSURL URLWithString:resultsMode.headImgUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    self.nameLable.text = resultsMode.anchorUName;
    self.timeLable.text = resultsMode.createTime;
    self.contentLable.text = resultsMode.content;
    if (resultsMode.talkDetail.picMinUrl.length == 0) {
        [self.talkView whc_Height:0];
        self.picMinImage.hidden = YES;
        self.talkContent.hidden = YES;
        self.talkTtile.hidden = YES;
        self.hotLable.hidden = YES;
        _hotIV.hidden = YES;
    } else {
        [self.talkView whc_Height:80];
        [self.picMinImage sd_setImageWithURL:[NSURL URLWithString:resultsMode.talkDetail.picMinUrl] placeholderImage:[UIImage imageNamed:@"ask"]];
        self.talkTtile.text = resultsMode.talkDetail.talkTitle;
        self.talkContent.text = resultsMode.talkDetail.talkContent;
        self.hotLable.text = resultsMode.talkDetail.hotNum;
        self.picMinImage.hidden = NO;
        self.talkContent.hidden = NO;
        self.talkTtile.hidden = NO;
        self.hotLable.hidden = NO;
        _hotIV.hidden = NO;
    }
    
    self.contengImageView.image = [UIImage imageNamed:@"ask"];
    if (resultsMode.contentType== 0) {
        //纯文本
        [self.contengImageView whc_Height:0];
    } else if (resultsMode.contentType == 1) {
        //图片
//        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:resultsMode.imgOrVideoUrl]]];
//        
        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:resultsMode.imgOrVideoUrl] placeholderImage:nil];
        [self.contengImageView whc_Height:[[self cacheApiKey:resultsMode.imgOrVideoUrl] floatValue]];
    } else {
        //视频
//        NSLog(@"%@",resultsMode.videoCover);
//        if (resultsMode.videoCover.length == 0) {
        
//        } else {
//        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:resultsMode.videoCover]]];
        [self.contengImageView whc_Height:[[self cacheApiKey:resultsMode.videoCover] floatValue]];
            [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:resultsMode.videoCover] placeholderImage:nil];
//        }
        
        
        
    }

}

- (void)setTalkdynamicMode:(Talkdynamiclist *)talkdynamicMode {
    [self.icImageView sd_setImageWithURL:[NSURL URLWithString:talkdynamicMode.headUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    self.nameLable.text = talkdynamicMode.nickName;
    self.timeLable.text = talkdynamicMode.createTime;
    self.contentLable.text = talkdynamicMode.content;
    self.contengImageView.image = [UIImage imageNamed:@"ask"];
    if (talkdynamicMode.contentType== 0) {
        //纯文本
        [self.contengImageView whc_Height:0];
    } else if (talkdynamicMode.contentType == 1) {
//        图片
        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:talkdynamicMode.imgVideoUrl] placeholderImage:nil];
        [self.contengImageView whc_Height:[[self cacheApiKey:talkdynamicMode.imgVideoUrl] floatValue]];
        
        
//        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:talkdynamicMode.imgVideoUrl]]];
//        
//        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:talkdynamicMode.imgVideoUrl] placeholderImage:nil];
//        if (!image) {
//            [self.contengImageView whc_Height:0];
//            
//        } else {
//            
//            [self.contengImageView whc_Height:SCREEN_WIDTH*image.size.height/image.size.width];
//        }
    } else {
        //视频
//        if (<#condition#>) {
//            <#statements#>
//        }
        
        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:talkdynamicMode.imgVideoUrl] placeholderImage:nil];
        [self.contengImageView whc_Height:[[self cacheApiKey:talkdynamicMode.imgVideoUrl] floatValue]];
        
//        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:talkdynamicMode.imgVideoUrl]]];
//        
//        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:talkdynamicMode.imgVideoUrl] placeholderImage:nil];
//        if (!image) {
//            [self.contengImageView whc_Height:0];
//            
//        } else {
//            
//            [self.contengImageView whc_Height:SCREEN_WIDTH*image.size.height/image.size.width];
//        }
    }
    
}


- (void)setDynamicMode:(Dynamiclist *)dynamicMode {
    [self.icImageView sd_setImageWithURL:[NSURL URLWithString:dynamicMode.headUrl] placeholderImage:[UIImage imageNamed:@"userdog"]];
    self.nameLable.text = dynamicMode.anchorName;
    self.timeLable.text = dynamicMode.createTime;
    self.contentLable.text = dynamicMode.content;
    if (dynamicMode.picMinUrl.length == 0) {
        [self.talkView whc_Height:0];
        self.picMinImage.hidden = YES;
        self.talkContent.hidden = YES;
        self.talkTtile.hidden = YES;
        self.hotLable.hidden = YES;
        _hotIV.hidden = YES;
        
    } else {
        [self.talkView whc_Height:80];
        [self.picMinImage sd_setImageWithURL:[NSURL URLWithString:dynamicMode.picMinUrl] placeholderImage:[UIImage imageNamed:@"ask"]];
        self.talkTtile.text = dynamicMode.talkTitle;
        self.talkContent.text = dynamicMode.talkContent;
        self.hotLable.text = dynamicMode.hotNum;
        self.picMinImage.hidden = NO;
        self.talkContent.hidden = NO;
        self.talkTtile.hidden = NO;
        self.hotLable.hidden = NO;
        _hotIV.hidden = NO;
    }
    
    self.contengImageView.image = [UIImage imageNamed:@"ask"];
    
    if (dynamicMode.contentType== 0) {
        //纯文本
        [self.contengImageView whc_Height:0];
    } else if (dynamicMode.contentType == 1) {
        //图片
        
        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:dynamicMode.imgVideoUrl] placeholderImage:nil];
        [self.contengImageView whc_Height:[[self cacheApiKey:dynamicMode.imgVideoUrl] floatValue]];
        
//        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dynamicMode.imgVideoUrl]]];
//        NSLog(@"%@",image);
//        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:dynamicMode.imgVideoUrl] placeholderImage:nil];
//        if (!image) {
//            [self.contengImageView whc_Height:0];
//            
//        } else {
//            
//            [self.contengImageView whc_Height:SCREEN_WIDTH*image.size.height/image.size.width];
//        }
        
        
    } else {
        
        if (dynamicMode.videoCover.length == 0) {
            
        } else {
        
            [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:dynamicMode.videoCover] placeholderImage:nil];
            [self.contengImageView whc_Height:[[self cacheApiKey:dynamicMode.videoCover] floatValue]];
            
        //视频
//        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dynamicMode.videoCover]]];
//        
//        [self.contengImageView sd_setImageWithURL:[NSURL URLWithString:dynamicMode.videoCover] placeholderImage:nil];
//        if (!image) {
//            [self.contengImageView whc_Height:0];
//            
//        } else {
//            
//            [self.contengImageView whc_Height:SCREEN_WIDTH*image.size.height/image.size.width];
//        }
       
        }
    }
    
}

- (void)btn1Click:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(btn1Delegate:)]) {
        [self.delegate btn1Delegate:self.ID];
    }
}

- (void)btn2Click:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(btn2Delegate:)]) {
        [self.delegate btn2Delegate:self.ID];
    }
    
}

- (void)icTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(icDelegate:)]) {
        [self.delegate icDelegate:self.ID];
    }
}
- (void)conlableTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(contengDelegate:)]) {
        [self.delegate contengDelegate:self];
    }
    
}
- (void)conImageTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(contengDelegate:)]) {
        [self.delegate contengDelegate:self];
    }
    
}
- (void)talkTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(talkDelegate:)]) {
        [self.delegate talkDelegate:self.ID];
    }
    
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
//    
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return  YES;
//}


- (NSString *)cacheApiKey:(NSString *)cacheKey {
    YYCache *cache = [[YYCache alloc] initWithName:GQCache];
    
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    id cacheData;
    //根据网址从Cache中取数据
    cacheData = [cache objectForKey:cacheKey];
    if (cacheData != 0) {
        return cacheData;
        
    } else {
        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cacheKey]]];
        if (!image) {
            [cache setObject:@"0" forKey:cacheKey];
            return @"0";
        } else {
            [cache setObject:[NSString stringWithFormat:@"%f",SCREEN_WIDTH*image.size.height/image.size.width] forKey:cacheKey];
            return [NSString stringWithFormat:@"%f",SCREEN_WIDTH*image.size.height/image.size.width];
        }
        
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
