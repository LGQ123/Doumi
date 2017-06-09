//
//  AboutWeViewController.m
//  douMiApp
//
//  Created by ydz on 2017/3/7.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "AboutWeViewController.h"

@interface AboutWeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *youxiang;
@property (weak, nonatomic) IBOutlet UILabel *banben;

@end

@implementation AboutWeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"关于我们";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    self.banben.text = [NSString stringWithFormat:@"版本号：%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"官方邮箱：kf@doume.tv"];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:@"官方邮箱："];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
    
    NSRange range2=[[hintString string]rangeOfString:@"kf@doume.tv"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range2];
    
    self.youxiang.attributedText=hintString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
