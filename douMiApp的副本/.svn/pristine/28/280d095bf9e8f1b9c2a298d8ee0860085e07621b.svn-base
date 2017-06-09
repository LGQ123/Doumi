//
//  IssueDetailsController.m
//  douMiApp
//
//  Created by ydz on 2016/12/12.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "IssueDetailsController.h"
#import "MyQuizViewController.h"
@interface IssueDetailsController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *contenLable;

@end

@implementation IssueDetailsController
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
    self.lable.text = @"问题详情";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    [self request_Api];
}
- (IBAction)myWenTi:(UIButton *)sender {
    MyQuizViewController *myQVC = [[MyQuizViewController alloc] initWithNibName:@"MyQuizViewController" bundle:nil];
    [self.navigationController pushViewController:myQVC animated:YES];
}

- (void)request_Api {
    NSDictionary *dic = @{@"iface":@"DMHY400038",@"id":self.ID};
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        self.titleLable.text = responseObj[@"name"];
        self.contenLable.text = responseObj[@"content"];
        
        
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
