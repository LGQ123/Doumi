//
//  CustomBannerCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/14.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "CustomBannerCell.h"
#import "SuperBoMode.h"
@implementation CustomBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)likeTouch:(UIButton *)sender {
//    NSDictionary *dic = @{@"iface":@"DMHY100001",@"mobile":@"222"};
//    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
//        NSString *isRegFlag = responseObj[@"isRegFlag"];
//        if ([isRegFlag isEqualToString:@"0"]) {
//            [LCProgressHUD showMessage:@"手机号未注册"];
//        } else {
//            
////            [self request_Api];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//    sender.selected = !sender.selected;
    
    if ([self.delegate respondsToSelector:@selector(likeDelegate:)]) {
        [self.delegate likeDelegate:self.ID];
    }
    
    
}
- (IBAction)shareTouch:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:self.ID];
    }
}

- (void)setEntsMode:(Ents *)entsMode {
    _titleLable.text = entsMode.xname;
    _subTileLable.text = entsMode.subTitle;
    _zanNumber.text = [NSString stringWithFormat:@"%ld",(long)entsMode.theTotalNumberOf];
    [_backImage sd_setImageWithURL:[NSURL URLWithString:entsMode.videoCover] placeholderImage:[UIImage imageNamed:@"dog"]];
    if ([entsMode.thumbup isEqualToString:@"0"]) {
        _likeBtn.selected = NO;
    } else {
        _likeBtn.selected = YES;
    }

}

@end
