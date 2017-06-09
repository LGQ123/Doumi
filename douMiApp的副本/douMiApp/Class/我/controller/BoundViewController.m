//
//  BoundViewController.m
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "BoundViewController.h"

@interface BoundViewController ()
@property (weak, nonatomic) IBOutlet UITextField *YYZHText;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *bounsLable;

@end

@implementation BoundViewController

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
    self.lable.text = [NSString stringWithFormat:@"%@账号绑定",self.titleStr];
    self.YYZHText.placeholder = [NSString stringWithFormat:@"请输入%@账号",self.titleStr];
    [self.logoImg sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:[UIImage imageNamed:@"dog"]];
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    self.bounsLable.text = [NSString stringWithFormat:@"绑定%@账号，除了能便捷的使用豆蜜功能，还能让大家都在直播平 台认识你哦~",self.titleStr];
    [_YYZHText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField.text.length > 20) {
        textField.text = [textField.text substringToIndex:20];
    }
    
    
}


- (IBAction)boundTouch:(UIButton *)sender {
    
    if (self.YYZHText.text.length == 0) {
        [LCProgressHUD showMessage:@"账号不能为空"];
    } else {
        [self request_Api];
    }
    
}

- (void)request_Api {
    NSDictionary *dic = @{@"iface":@"DMHY400031",@"userId":[BusinessLogic uuid],@"pId":self.ID,@"acounts":self.YYZHText.text};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        [LCProgressHUD showMessage:@"绑定成功"];
        
    } failure:^(NSError *error) {
        
    }];
    
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
