//
//  MyQuizViewController.m
//  douMiApp
//
//  Created by ydz on 2016/12/10.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MyQuizViewController.h"
#import "QuizCell.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import "wenTiMode.h"
@interface MyQuizViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *placeholderLable;
@property (weak, nonatomic) IBOutlet UILabel *ResidueLable;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) wenTiMode *mode;
@end

@implementation MyQuizViewController
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
    self.lable.text = @"我的提问";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    [_myTableView registerClass:[QuizCell class] forCellReuseIdentifier:@"QuizCell"];
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self request_Api];
}


- (void)request_Api {
    __weak UITableView *tableView = _myTableView;
    NSDictionary *dic = @{@"iface":@"DMHY400040",@"userId":[BusinessLogic uuid],@"type":@"1",@"childrenType":@"4"};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [wenTiMode mj_objectWithKeyValues:responseObj];
        [tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];

}

- (IBAction)quizClick:(UIButton *)sender {
    if (_myTextView.text.length == 0) {
        [LCProgressHUD showMessage:@"输入不能为空"];
    } else {
        [self request_TWApi];
    }
    
}

- (void)request_TWApi {
    NSDictionary *dic = @{@"iface":@"DMHY400039",@"name":_myTextView.text,@"userId":[BusinessLogic uuid],@"type":@"1",@"childrenType":@"4"};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        [LCProgressHUD showMessage:@"问题提交成功"];
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{    if (![text isEqualToString:@""])
    
    {
    
    _placeholderLable.hidden = YES;
    
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        
        _placeholderLable.hidden = NO;
    
        
    }
    
    
    
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    
    
        if (textView.text.length > 200) {
            textView.text = [textView.text substringToIndex:200];
        }
    _ResidueLable.text = [NSString stringWithFormat:@"还剩%d字",200-textView.text.length];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mode.mIdList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [QuizCell whc_CellHeightForIndexPath:indexPath tableView:tableView]+20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuizCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuizCell"];
    cell.titleLable.text = _mode.mIdList[indexPath.row].name;
    cell.contentLable.text = _mode.mIdList[indexPath.row].content;
    return cell;

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
