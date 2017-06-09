//
//  RootViewController.m
//  douMiApp
//
//  Created by ydz on 2016/11/4.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewWillAppear:(BOOL)animated {

    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.topItem.title = @"";
    
    self.navigationController.navigationBar.backItem.title = @"";
    
    self.view.backgroundColor = RGBA(247, 247, 247, 1);
}


- (void)addItem:(item_location)location btnTitle:(NSString *)title viewTitle:(NSString *)str{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    if (location == item_left) {
        btn.frame = CGRectMake(14, 34, 62, 20);
        [btn addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
        if (!title) {
            [btn setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
        } else {
            [btn setImage:[[UIImage imageNamed:title] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
        }
    } else if (location == item_right) {
        btn.frame = CGRectMake(SCREEN_WIDTH-14-16, 34, 20, 20);
        [btn addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
        if (!title) {
            [btn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        } else {
            [btn setBackgroundImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
        }
    } else {
        btn.frame = CGRectMake(SCREEN_WIDTH-14-16-15-22, 34, 22, 20);
        [btn addTarget:self action:@selector(showCenter) forControlEvents:UIControlEventTouchUpInside];
        if (!title) {
            [btn setBackgroundImage:[UIImage imageNamed:@"backarrow4040new"] forState:UIControlStateNormal];
        } else {
            [btn setBackgroundImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
        }
    }

    [self.navigationView addSubview:btn];
    
    if (!str) {
        
    } else {
        self.lable.text = str;
        [self.navigationView addSubview:self.lable];
    }
}

- (void)addTite:(NSString *)str {
    if (!str) {
        
    } else {
        self.lable.text = str;
        [self.navigationView addSubview:self.lable];
    }
    
}

- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _navigationView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_navigationView];
    }
    return _navigationView;
}

- (UILabel *)lable {
    if (!_lable) {
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(45, 20, SCREEN_WIDTH-90, 44)];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.textColor = RGBA(40, 40, 40, 1);
        _lable.font = [UIFont systemFontOfSize:17];
    }
    return _lable;

}

- (void)showLeft {
    
    [self.navigationController popViewControllerAnimated:YES];

    
}

- (void)showRight {

    
}

- (void)showCenter {

    
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^) (UIAlertAction *action))handler;
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
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
