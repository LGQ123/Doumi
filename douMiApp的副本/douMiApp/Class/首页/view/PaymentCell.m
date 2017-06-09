//
//  PaymentCell.m
//  douMiApp
//
//  Created by ydz on 2017/1/14.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "PaymentCell.h"
#import "PaymentView.h"
@implementation PaymentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setStatus:(NSString *)status {
    self.Pay_cover.hidden  = [status isEqualToString:@"1"];

}

- (void)setMode:(UnifyMode *)mode {
    _Pay_title.text = mode.title;
    _Pay_subtitle.text = mode.subTitle;
    self.status = mode.status;
    self.payType = [NSString stringWithFormat:@"%li",(long)mode.type];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
