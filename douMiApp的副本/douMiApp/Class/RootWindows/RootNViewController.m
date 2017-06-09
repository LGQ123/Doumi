//
//  RootNViewController.m
//  douMiApp
//
//  Created by ydz on 2016/11/8.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "RootNViewController.h"

@interface RootNViewController ()

{
     UIImageView *navBarHairlineImageView;
}

@property (strong, nonatomic)NSMutableArray *dataArr;

@end



@implementation RootNViewController


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


//同样的在界面出现时候开启隐藏
-(void)viewWillAppear:(BOOL)animated
{
    navBarHairlineImageView.hidden = YES;
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;
    self.navigationController.navigationBar.topItem.title = @"";
    
    self.navigationController.navigationBar.backItem.title = @"";
    self.view.backgroundColor = RGBA(247, 247, 247, 1);
}

- (void)addItem:(nitem_location)location btnTitleArr:(NSArray<NSString *> *)titleArr {
    if (location == nitem_left) {
        if (titleArr.count == 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(0, 0, 20, 20);
            [btn setBackgroundImage:[UIImage imageNamed:titleArr[0]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(showLeftView:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
            self.navigationItem.leftBarButtonItem = item;
        } else {
            
            for (int i = 0; i<titleArr.count; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = CGRectMake(0, 0, 20, 20);
                btn.tag = i;
                [btn setBackgroundImage:[UIImage imageNamed:titleArr[i]] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(showLeftView:) forControlEvents:UIControlEventTouchUpInside];
                UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
                [self.dataArr addObject:item];
            }
            
            self.navigationItem.leftBarButtonItems = self.dataArr;
        }
    } else {
        if (titleArr.count == 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(0, 0, 20, 20);
            [btn setBackgroundImage:[UIImage imageNamed:titleArr[0]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(showRightView:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
            self.navigationItem.rightBarButtonItem = item;
        } else {
            
            for (int i = 0; i<titleArr.count; i++) {
                if ([titleArr[i] isEqualToString:@"1"]) {
                    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
                    //将宽度设为负值
                    spaceItem.width = 20;
                    [self.dataArr addObject:spaceItem];
                } else {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    if (i == 0) {
                        if ([titleArr[i] isEqualToString:@"new"]) {
                           [btn setBackgroundImage:[UIImage imageNamed:@"news"] forState:UIControlStateSelected];
                        } else if([titleArr[i] isEqualToString:@"xiaoxi"]){
                            [btn setBackgroundImage:[UIImage imageNamed:@"xiaoxis"] forState:UIControlStateSelected];
                        }
                        
                        self.redbtn = btn;
                    } else {
                        [btn setBackgroundImage:[UIImage imageNamed:@"play3"] forState:UIControlStateSelected];
                        self.playBtn = btn;
                        self.playBtn.hidden = YES;
                    
                    }
                btn.frame = CGRectMake(0, 0, 20, 20);
                btn.tag = i;
                [btn setBackgroundImage:[UIImage imageNamed:titleArr[i]] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(showRightView:) forControlEvents:UIControlEventTouchUpInside];
                UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
                [self.dataArr addObject:item];
                }
            }
            
            self.navigationItem.rightBarButtonItems = self.dataArr;
        }
    }
    
    
}

- (void)showLeftView:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showRightView:(UIButton *)btn {
    
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (UILabel *)lable {
    if (!_lable) {
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
//        _lable.backgroundColor = [UIColor redColor];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.textColor = [UIColor whiteColor];
        _lable.font = [UIFont systemFontOfSize:17];
//        _lable.text = _titleStr;
        self.navigationItem.titleView = _lable;
    }
    return _lable;
    
}


- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^) (UIAlertAction *action))handler;
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showTeaseAlert;
{
    [BusinessLogic setIsFirst:@"N"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"豆蜜好用吗?快来吐槽吧" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"我要吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/%E8%B1%86%E8%9C%9C/id1186113028?mt=8"];
        [[UIApplication sharedApplication] openURL:url];
        [BusinessLogic setIsAllow:@"N"];
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"再用用看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BusinessLogic setIsAllow:@"Y"];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"不再提示" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BusinessLogic setIsAllow:@"N"];
        
    }];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)leadAleat {
    
    if ([[BusinessLogic isAllow] isEqualToString:@"Y"]) {
        if ([[BusinessLogic isFirst] isEqualToString:@"Y"]) {
            [NetworkRequest post1:serVerIP params:@{@"iface":@"DMHY100013",@"userId":[BusinessLogic uuid],@"apptime":[BusinessLogic openNum]} success:^(id responseObj) {
                if ([responseObj[@"play"] isEqualToString:@"1"]) {
                    
                    [self showTeaseAlert];
                } else {
                    
                    NSLog(@"不弹");
                }
                
            } failure:^(NSError *error) {
                NSLog(@"不弹");
            }];
            
            
        }
    }
    
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
