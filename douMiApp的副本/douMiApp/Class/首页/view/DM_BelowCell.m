//
//  DM_BelowCell.m
//  douMiApp
//
//  Created by ydz on 2016/11/8.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_BelowCell.h"

@implementation DM_BelowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = RGBA(247, 247, 247, 1);
    _messageImg.userInteractionEnabled = YES;
    _messageImg2.userInteractionEnabled = YES;
    _messageImg3.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageImageTap:)];
    [_messageImg addGestureRecognizer:imageTap];
    UITapGestureRecognizer *textTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messagetextTap:)];
    [_messageView addGestureRecognizer:textTap];
    UITapGestureRecognizer *imageTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageImageTap:)];
    UITapGestureRecognizer *imageTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageImageTap:)];
    [_messageImg2 addGestureRecognizer:imageTap2];
    [_messageImg3 addGestureRecognizer:imageTap3];
    
    [_douJiaBtn addTarget:self action:@selector(doujiaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_fenQiBtn addTarget:self action:@selector(fenqiButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (IBAction)messageTouch:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(check:)]) {
        [self.delegate check:self];
    }
}

- (void)messageImageTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(details:)]) {
        [self.delegate details:self];
    }
}

- (void)messagetextTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(details:)]) {
        [self.delegate details:self];
    }
}

- (void)messageImageTap2:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(details:)]) {
        [self.delegate details:self];
    }
}
- (void)messageImageTap3:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(details:)]) {
        [self.delegate details:self];
    }
}


- (void)doujiaButtonClick {
    if ([self.delegate respondsToSelector:@selector(meDoujiaButtonClick)]) {
        [self.delegate meDoujiaButtonClick];
    }
}


- (void)fenqiButtonClick {
    if ([self.delegate respondsToSelector:@selector(fenQiButtonClick)]) {
        [self.delegate fenQiButtonClick];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
