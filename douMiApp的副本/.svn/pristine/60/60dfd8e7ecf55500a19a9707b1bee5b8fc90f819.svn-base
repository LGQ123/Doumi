//
//  DM_DisplayController.m
//  douMiApp
//
//  Created by ydz on 2016/11/18.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_DisplayController.h"
#import "DM_AnchorListController.h"


@interface DM_DisplayController ()
@property (strong, nonatomic)UIView *navigationView;
@property (strong, nonatomic)UILabel *lable;
@end

@implementation DM_DisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(14, 34, 22, 20);
    [btn addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    
    
    self.navigationController.navigationBar.topItem.title = @"";
    
    self.navigationController.navigationBar.backItem.title = @"";
    
    
    _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
    //        _lable.backgroundColor = [UIColor redColor];
    _lable.textAlignment = NSTextAlignmentCenter;
_lable.textColor = RGBA(40, 40, 40, 1);
    _lable.font = [UIFont systemFontOfSize:17];
            _lable.text = @"豆蜜主播";
    self.navigationItem.titleView = _lable;
    
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    
    // 设置标题字体
    /*
     方式一：
     self.titleFont = [UIFont systemFontOfSize:20];
     */
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        
        // 设置标题字体
        *titleFont = [UIFont systemFontOfSize:14];
        *titleHeight = 30;
        *titleScrollViewColor = [UIColor whiteColor];
        *norColor = RGBA(126, 126, 126, 1);
        *selColor = [UIColor blackColor];
        
        
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = [UIColor blackColor];
        
        
        
    }];
    
    // 设置全屏显示
    self.isfullScreen = YES;
    NSLog(@"%d",self.page);
    self.selectIndex = self.page;
    
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
        _lable.textColor = RGBA(126, 126, 126, 1);
        _lable.font = [UIFont systemFontOfSize:17];
    }
    return _lable;
    
}


- (void)setUpAllViewController {
    

    DM_AnchorListController *wordVc1 = [[DM_AnchorListController alloc] init];
    wordVc1.title = @"全部";
    [self addChildViewController:wordVc1];
    DM_AnchorListController *wordVc2 = [[DM_AnchorListController alloc] init];
    wordVc2.title = @"热门";
    [self addChildViewController:wordVc2];
    DM_AnchorListController *wordVc3 = [[DM_AnchorListController alloc] init];
    wordVc3.title = @"最新";
    [self addChildViewController:wordVc3];
    DM_AnchorListController *wordVc4 = [[DM_AnchorListController alloc] init];
    wordVc4.title = @"游戏";
    [self addChildViewController:wordVc4];
    DM_AnchorListController *wordVc5 = [[DM_AnchorListController alloc] init];
    wordVc5.title = @"明星";
    [self addChildViewController:wordVc5];
    DM_AnchorListController *wordVc6 = [[DM_AnchorListController alloc] init];
    wordVc6.title = @"脱口秀";
    [self addChildViewController:wordVc6];
    DM_AnchorListController *wordVc7 = [[DM_AnchorListController alloc] init];
    wordVc7.title = @"娱乐";
    [self addChildViewController:wordVc7];
    DM_AnchorListController *wordVc8 = [[DM_AnchorListController alloc] init];
    wordVc8.title = @"户外";
    [self addChildViewController:wordVc8];
    DM_AnchorListController *wordVc9 = [[DM_AnchorListController alloc] init];
    wordVc9.title = @"YY直播";
    [self addChildViewController:wordVc9];
    DM_AnchorListController *wordVc10 = [[DM_AnchorListController alloc] init];
    wordVc10.title = @"熊猫直播";
    [self addChildViewController:wordVc10];
}

- (void)showLeft {
    
    if ([self.type isEqualToString:@"side"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
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
