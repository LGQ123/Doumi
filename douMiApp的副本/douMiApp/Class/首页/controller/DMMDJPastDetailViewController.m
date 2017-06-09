//
//  DMMDJPastDetailViewController.m
//  douMiApp
//
//  Created by edz on 2017/1/11.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "DMMDJPastDetailViewController.h"


#define margin 14
#define labelH 53
#define imageWH 21
#define imageMargin (labelH-imageWH)/2
#define lineW 3
#define lineMargin (imageWH-lineW)/2

@interface DMMDJPastDetailViewController ()

@end

@implementation DMMDJPastDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"蜜豆荚明细";
    self.lable.textColor = RGBA(39, 39, 39, 1);
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, 221)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    
    UILabel *titleLab = [self getLabelWithFrame:CGRectMake(margin, margin, SCREEN_WIDTH/2, 15) andText:_mdjModel.remark andTextColor:RGBA(61, 61, 61, 1) andFont:DMFontBold(12)];
    [bgView addSubview:titleLab];
    
    UILabel *rollInLab = [self getLabelWithFrame:CGRectMake(SCREEN_WIDTH-margin-100, titleLab.mj_y+10, 100, titleLab.mj_h) andText:[NSString stringWithFormat:@"+%@", _mdjModel.outlay] andTextColor:RGBA(8, 145, 232, 1) andFont:DMFontBold(16)];
    rollInLab.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:rollInLab];
    
    UILabel *dateLab = [self getLabelWithFrame:CGRectMake(margin, titleLab.mj_y+titleLab.mj_h+10, SCREEN_WIDTH/2, 12) andText:_mdjModel.subTime andTextColor:RGBA(60, 60, 60, 1) andFont:DMFont(10)];
    [bgView addSubview:dateLab];
    
//    UILabel *balanceLab = [self getLabelWithFrame:CGRectMake(rollInLab.mj_x, dateLab.mj_y, 100, 12) andText:_mdjModel.balance andTextColor:RGBA(60, 60, 60, 1) andFont:DMFont(10)];
//    balanceLab.textAlignment = NSTextAlignmentRight;
//    [bgView addSubview:balanceLab];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 60.5, SCREEN_WIDTH-margin, 0.5)];
    line.backgroundColor = RGBA(200, 200, 200, 1);
    [bgView addSubview:line];
    
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"成功转入%@元", _mdjModel.outlay],
                             [NSString stringWithFormat:@"%@日产生收益", _mdjModel.subProduceTime],
                             [NSString stringWithFormat:@"%@日收益到账", _mdjModel.subEarningsTime], nil];
    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:@"红对号", @"红计算器", @"红钱币", nil];
    for (int i = 0; i < array.count; i ++) {
        UILabel *label = [self getLabelWithFrame:CGRectMake(44, 61+i*labelH, SCREEN_WIDTH-60, labelH) andText:[array dm_objectAtIndex:i] andTextColor:RGBA(39, 39, 39, 1) andFont:DMFont(12)];
        [bgView addSubview:label];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(14, label.mj_y+imageMargin, imageWH, imageWH)];
        image.image = [UIImage imageNamed:[imageArray dm_objectAtIndex:i]];
        [bgView addSubview:image];
        
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(image.mj_x+lineMargin, image.mj_y+image.mj_h, lineW, imageMargin*2)];
        lineImage.backgroundColor = RGBA(255, 42, 80, 1);
        [bgView addSubview:lineImage];
        if (i == array.count-1) {
            lineImage.hidden = YES;
        }
    }
}


- (UILabel *)getLabelWithFrame:(CGRect)frame andText:(NSString *)text andTextColor:(UIColor *)textColor andFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
