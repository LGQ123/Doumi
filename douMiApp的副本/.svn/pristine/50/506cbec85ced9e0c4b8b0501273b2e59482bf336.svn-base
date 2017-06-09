//
//  DTDetailsViewController.m
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DTDetailsViewController.h"
#import "HTCell.h"
#import "HTPLCell.h"
#import "ZDPLCell.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import "DynamicListMode.h"
#import "DMcommentView.h"
#import "DM_LoginController.h"
#import <IQKeyboardManager.h>
#import "PersonageViewController.h"
#import "DTRewardViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "HTDetailsViewController.h"
#import <UShareUI/UMSocialUIManager.h>

#import "UGCViewController.h"
@interface DTDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,ZDPLDelegate,UITextFieldDelegate,htplDelegate,HTDelegte,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) ZDPLCell *zview;

@property (strong, nonatomic) Results *mode;

@property (strong, nonatomic) DMcommentView *commentView;

@property (assign, nonatomic) CGSize kbSize;

@property (assign, nonatomic) BOOL isComment;

@property (copy, nonatomic) NSString *bcommentId;

@property (copy, nonatomic) NSString *memId;

@property (copy, nonatomic)  NSString *flag;

@property (copy, nonatomic) NSString *sharecontent;

@property (copy, nonatomic) NSString *shareID;

@property (assign, nonatomic) NSInteger delegateRow;

@end

@implementation DTDetailsViewController

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].enable = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [MobClick endLogPageView:@"全部评论页"];
}



- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}


//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    _kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",_kbSize.height);
    [self createKeyBordView:_kbSize];
    
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.3 animations:^{
        _commentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 40);
    } completion:^(BOOL finished) {
        
    }];
    
    
}


- (void)createKeyBordView:(CGSize )kbSize {
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _commentView.frame = CGRectMake(0, SCREEN_HEIGHT-40-kbSize.height, SCREEN_WIDTH, 40);
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].enable = NO;
    [self registerForKeyboardNotifications];
    [MobClick beginLogPageView:@"全部评论页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _isComment = NO;
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    [_myTableView registerClass:[HTCell class] forCellReuseIdentifier:@"HTCell"];
    [_myTableView registerClass:[HTPLCell class] forCellReuseIdentifier:@"HTPLCell"];
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    _zview = [[ZDPLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    _zview.frame = CGRectMake(0, SCREEN_HEIGHT-32, SCREEN_WIDTH, 32);
    _zview.delegate = self;
//    _zview.zanNumber = _zanNumber;
//    _zview.plNumber = @"评论";
    [self.view addSubview:_zview];
    if ([_type isEqualToString:@"dt"]) {
        _flag = @"1";
        self.lable.text = @"动态详情";
        [self request_Api];
    } else {
        _flag = @"2";
        [self request_HTApi];
    }
    
}


- (void)request_Api {
    __weak UITableView *tableView = _myTableView;
    NSDictionary *dic ;
    if ([BusinessLogic uuid].length == 0) {
        dic = @{@"iface":@"DMHY300015",@"dynId":_ID};
    } else {
        dic = @{@"iface":@"DMHY300015",@"userId":[BusinessLogic uuid],@"dynId":_ID};
    }
    
    
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [Results mj_objectWithKeyValues:responseObj];
         _zview.zanNumber = [NSString stringWithFormat:@"%ld",(long)_mode.thumbUpNum];
        _zview.ifZan = _mode.thumbUpStatus;
        [_zview.myCollec reloadData];
        
        [tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];

}

- (void)request_HTApi {
    __weak UITableView *tableView = _myTableView;
    
    
    NSDictionary *dic;
    
    if ([BusinessLogic uuid].length == 0) {
        dic = @{@"iface":@"DMHY200022",@"dynId":_ID};
    } else {
        dic = @{@"iface":@"DMHY200022",@"userId":[BusinessLogic uuid],@"dynId":_ID};
    }
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [Results mj_objectWithKeyValues:responseObj];
        _zview.zanNumber = [NSString stringWithFormat:@"%ld",(long)_mode.thumbUpNum];
        _zview.ifZan = _mode.thumbUpStatus;
        [_zview.myCollec reloadData];
        self.lable.text = [NSString stringWithFormat:@"%@的评论",_mode.anchorUName];
        [tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mode.comments.count+1;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [HTCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
    } else {
        return [HTPLCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTCell"];
//        [cell.btn1 setImage:[[UIImage imageNamed:@"find_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        cell.resultsMode = _mode;
        cell.delegate = self;
        cell.ID = indexPath.row;
        return cell;
    } else {
        HTPLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTPLCell"];
        cell.mode = _mode.comments[indexPath.row-1];
        cell.ID = indexPath.row-1;
        cell.delegate = self;
        return cell;
    }
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row > 0) {
        
        if ([_mode.comments[indexPath.row-1].isDel isEqualToString:@"0"] ) {
            
            if ([BusinessLogic uuid].length == 0) {
                
                DM_LoginController *dmLoginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
                [self.navigationController pushViewController:dmLoginVC animated:YES];
                
            } else {
                
                if ([self.commentView.inputView isFirstResponder]) {
                    self.commentView.inputView.text = @"";
                    self.commentView.inputView.placeholder = @"";
                    [self.commentView.inputView resignFirstResponder];
                } else {
                    
                    if ([BusinessLogic UGC].length == 0) {
                        if ([[BusinessLogic power] isEqualToString:@"Y"]) {
                            _isComment = NO;
                            self.commentView.inputView.text = @"";
                            self.commentView.inputView.placeholder = @"";
                            self.commentView.inputView.placeholder = [NSString stringWithFormat:@"回复%@:",_mode.comments[indexPath.row-1].uname];
                            _bcommentId = [NSString stringWithFormat:@"%ld",(long)_mode.comments[indexPath.row-1].Id];
                            _memId = [NSString stringWithFormat:@"%ld",(long)_mode.comments[indexPath.row-1].memId];
                            [self.commentView.inputView becomeFirstResponder];
                        } else {
                            UGCViewController *ugc = [[UGCViewController alloc] init];
                            [self presentViewController:ugc animated:YES completion:nil];
                        }
                    } else {
                        
                        
                        _isComment = NO;
                        self.commentView.inputView.text = @"";
                        self.commentView.inputView.placeholder = @"";
                        self.commentView.inputView.placeholder = [NSString stringWithFormat:@"回复%@:",_mode.comments[indexPath.row-1].uname];
                        _bcommentId = [NSString stringWithFormat:@"%ld",(long)_mode.comments[indexPath.row-1].Id];
                        _memId = [NSString stringWithFormat:@"%ld",(long)_mode.comments[indexPath.row-1].memId];
                        [self.commentView.inputView becomeFirstResponder];
                        
                    }
                    
                }
            }
            
            
        } else {
            [self.commentView.inputView resignFirstResponder];
            self.commentView.inputView.text = @"";
            self.commentView.inputView.placeholder = @"";
            _bcommentId = [NSString stringWithFormat:@"%ld",(long)_mode.comments[indexPath.row-1].Id];
            _delegateRow = indexPath.row-1;
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"删除我的评论" delegate:self cancelButtonTitle:@"取消删除" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
            [actionSheet showInView:self.view];
        
        }
        
        
    } else {
        self.commentView.inputView.text = @"";
        self.commentView.inputView.placeholder = @"";
        [self.commentView.inputView resignFirstResponder];
    }

}

//话题标签
- (void)talkDelegate:(NSInteger)ID {
    HTDetailsViewController *htDetailsVC = [[HTDetailsViewController alloc] initWithNibName:@"HTDetailsViewController" bundle:nil];
    htDetailsVC.talkId = _mode.talkDetail.talkId;
    [self.navigationController pushViewController:htDetailsVC animated:YES];
    
}

//设置sheetButtonAction
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        [self request_ApiDelegate];
        
    }
    else
    {
        //NSLog(@"取消");
        //        [self dismissViewController];
    }
}

- (void)request_ApiDelegate {
    NSDictionary *dic = @{@"iface":@"DMHY300013",@"commentId":_bcommentId,@"flag":_flag};
    
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            [_mode.comments removeObjectAtIndex:_delegateRow];
            [_myTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    

}

- (void)icDelegate:(NSInteger)ID {
    PersonageViewController *PersonageVC = [[PersonageViewController alloc] initWithNibName:@"PersonageViewController" bundle:nil];
    PersonageVC.UUID = [NSString stringWithFormat:@"%ld",(long)_mode.anchorId];
    [self.navigationController pushViewController:PersonageVC animated:YES];
}

- (void)htplIcTouch:(NSInteger)ID {
    PersonageViewController *PersonageVC = [[PersonageViewController alloc] initWithNibName:@"PersonageViewController" bundle:nil];
    PersonageVC.UUID = [NSString stringWithFormat:@"%ld",(long)_mode.comments[ID].memId];
    [self.navigationController pushViewController:PersonageVC animated:YES];
    
}



//点赞 打赏 评论
- (void)CollecIndex:(NSInteger)index ID:(NSInteger)Id{
    if (index == 0) {//点赞
        
        if ([BusinessLogic uuid].length == 0) {
            DM_LoginController *dmLoginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
            [self.navigationController pushViewController:dmLoginVC animated:YES];
            
        } else {
            
            
            if ([_type isEqualToString:@"dt"]) {
                [MobClick event:@"dynamicLike"];
                NSDictionary *dic = @{@"iface":@"DMHY300003",@"userId":[BusinessLogic uuid],@"dynId":[NSString stringWithFormat:@"%ld",(long)_mode.Id],@"type":@"1"};
                if ( _zview.ifZan == 0) {
                    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
                        _zview.ifZan = 1;
                        _zview.zanNumber = [NSString stringWithFormat:@"%d",[_zview.zanNumber intValue]+1];
                        [_zview.myCollec reloadData];
                        
                    } failure:^(NSError *error) {
                        
                    }];
                } else {
                     [MobClick event:@"like"];
                    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
                        _zview.ifZan = 0;
                        _zview.zanNumber = [NSString stringWithFormat:@"%d",[_zview.zanNumber intValue]-1];
                        [_zview.myCollec reloadData];
                        
                    } failure:^(NSError *error) {
                        
                    }];
                }
            } else {
                NSDictionary *dic = @{@"iface":@"DMHY300003",@"userId":[BusinessLogic uuid],@"dynId":[NSString stringWithFormat:@"%ld",(long)_mode.Id],@"type":@"4"};
                if ( _zview.ifZan == 0) {
                    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
                        _zview.ifZan = 1;
                        _zview.zanNumber = [NSString stringWithFormat:@"%d",[_zview.zanNumber intValue]+1];
                        [_zview.myCollec reloadData];
                        
                    } failure:^(NSError *error) {
                        
                    }];
                } else {
                    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
                        _zview.ifZan = 0;
                        _zview.zanNumber = [NSString stringWithFormat:@"%d",[_zview.zanNumber intValue]-1];
                        [_zview.myCollec reloadData];
                        
                    } failure:^(NSError *error) {
                        
                    }];
                }
                
            }
            
            [self leadAleat];
        }
        
        
        
    }
    if (index == 2) {//评论
        
        if ([BusinessLogic uuid].length == 0) {
            DM_LoginController *dmLoginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
            [self.navigationController pushViewController:dmLoginVC animated:YES];
        } else {
        
            if ([BusinessLogic UGC].length == 0) {
                if ([[BusinessLogic power] isEqualToString:@"Y"]) {
                    _isComment = YES;
                    [self.commentView.inputView becomeFirstResponder];
                } else {
                    UGCViewController *ugc = [[UGCViewController alloc] init];
                    [self presentViewController:ugc animated:YES completion:nil];
                }
            } else {
                
                
                _isComment = YES;
                [self.commentView.inputView becomeFirstResponder];
            }
        }
    }
    
    if (index == 1) {
//        [self showAlertWithTitle:@"温馨提示" message:@"此功能暂未开通ikihkjhkjh" handler:nil];
        
        if ([BusinessLogic uuid].length == 0) {
            DM_LoginController *logVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
            [self.navigationController pushViewController:logVC animated:YES];
            
        } else {
           
            
            if ([[BusinessLogic power] isEqualToString:@"Y"]) {
                DTRewardViewController *controller = [[DTRewardViewController alloc] init];
                controller.anchorId = [NSString stringWithFormat:@"%ld",(long)_mode.anchorId];
                controller.dynId = [NSString stringWithFormat:@"%ld",(long)_mode.Id];
                controller.channel = @"0";
                [self presentViewController:controller animated:YES completion:nil];
            } else {
                PersonageViewController *PersonageVC = [[PersonageViewController alloc] initWithNibName:@"PersonageViewController" bundle:nil];
                PersonageVC.UUID = [NSString stringWithFormat:@"%ld",(long)_mode.anchorId];
                [self.navigationController pushViewController:PersonageVC animated:YES];
            }

        }
    }
    
}

//分享
- (void)btn1Delegate:(NSInteger)ID {
    
    //分享
    __weak typeof(self) weakSelf = self;
    //显示分享面板
    _sharecontent = _mode.content;
    _shareID = [NSString stringWithFormat:@"%ld",(long)_mode.Id];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [weakSelf shareWebPageToPlatformType:platformType];
    }];
    
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"我分享了一条动态" descr:_sharecontent thumImage:[UIImage imageNamed:@"dog"]];
    //设置网页地址
    shareObject.webpageUrl =[NSString stringWithFormat:DTShareIP,_shareID];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)sendBtnClick:(UIButton *)sender {
    if (_commentView.inputView.text.length == 0) {
        [LCProgressHUD showMessage:@"评论不能为空"];
    } else {
    [self.view endEditing:YES];
    if (_isComment) {
        [self request_PLAPI];
        
    } else {
        [self request_HFApi];
    }
    }
}

- (void)request_PLAPI {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY300006",@"userId":[BusinessLogic uuid],@"dynId":[NSString stringWithFormat:@"%ld",(long)_mode.Id],@"memBid":[NSString stringWithFormat:@"%ld",(long)_mode.anchorId],@"comment":self.commentView.inputView.text,@"type":@"0",@"flag":_flag};
    
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [LCProgressHUD showMessage:@"评论成功"];
        self.commentView.inputView.text = @"";
        self.commentView.inputView.placeholder = @"";
        [self leadAleat];
        if ([_type isEqualToString:@"dt"]) {
            
            [self request_Api];
        } else {
            [self request_HTApi];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)request_HFApi {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"iface":@"DMHY300006",@"userId":[BusinessLogic uuid],@"dynId":[NSString stringWithFormat:@"%ld",(long)_mode.Id],@"memBid":_memId,@"comment":self.commentView.inputView.text,@"type":@"1",@"flag":_flag,@"bcommentId":_bcommentId};
    
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [LCProgressHUD showMessage:@"回复成功"];
        self.commentView.inputView.text = @"";
        self.commentView.inputView.placeholder = @"";
        [self leadAleat];
        if ([_type isEqualToString:@"dt"]) {
            
            [self request_Api];
        } else {
            [self request_HTApi];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}


- (DMcommentView *)commentView {
    if (!_commentView) {
        _commentView = [[DMcommentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 40)];
        _commentView.backgroundColor = RGBA(60, 60, 60, 1);
        _commentView.inputView.delegate = self;
        _commentView.inputView.returnKeyType = UIReturnKeyDone;
        [_commentView.sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_commentView];
    }
    return _commentView;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    
    
    if (_commentView.inputView.text.length == 0) {
        [LCProgressHUD showMessage:@"评论不能为空"];
    } else {
        [self.view endEditing:YES];
        
        if (_isComment) {
            [self request_PLAPI];
            
        } else {
            [self request_HFApi];
        }
    }
    return YES;
    
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
