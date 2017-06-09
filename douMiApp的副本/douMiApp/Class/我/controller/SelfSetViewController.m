//
//  SelfSetViewController.m
//  douMiApp
//
//  Created by ydz on 2016/12/2.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "SelfSetViewController.h"
#import "AboutWeViewController.h"
#import "AddressView.h"
#import "DQBirthDateView.h"
#import "DQAgeModel.h"
#import "CalculateTool.h"
#import "GQSexView.h"
#import "WriteInforController.h"
#import "HelpCenterController.h"
#import "SelfInforMode.h"
#import <AFNetworking.h>
#import "RWebViewConreoller.h"
#import "UMMobClick/MobClick.h"
#import "ZYKMD5.h"
@interface SelfSetViewController ()<UITableViewDelegate,UITableViewDataSource,DQBirthDateViewDelegate,GQSEXDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,writeInforDelegate>
{
    NSThread *thread;
    NSData *_data;
    NSData *_data2;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray <NSArray *>*dataArr;

@property (strong, nonatomic) AddressView *addressView;

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) UITextField *address;

@property (nonatomic, strong) DQBirthDateView *DQBirthView;
@property (nonatomic, strong) GQSexView *GQSexView;
@property (copy, nonatomic) NSString *brithStr;
@property (copy, nonatomic) NSString *sexStr;

@property (nonatomic, strong)SelfInforMode *mode;

@property (nonatomic,strong) UIImagePickerController * pickerCamera;
@property (nonatomic,strong) UIImagePickerController * PickerImage;

@property (nonatomic, copy) NSString *strImage;

@property (nonatomic, assign) CGFloat dataSize;

@end

@implementation SelfSetViewController

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
    _data = [[NSData alloc] init];
    thread = [[NSThread alloc] initWithTarget:self selector:@selector(initImgPicker) object:nil];
    [thread start];
    
    
    
    
    [self addItem:nitem_left btnTitleArr:@[@"back"]];
    self.lable.text = @"个人设置";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    
    
    _myTableView.backgroundColor = RGBA(247, 247, 247, 1);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(14, 20, SCREEN_WIDTH-28, 40);
    btn.backgroundColor = RGBA(60, 60, 60, 1);
    [btn setTitle:@"安全退出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [headerView addSubview:view];
    _myTableView.tableFooterView = headerView;
    
    [self request_Api];
    
    _dataSize = [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject];
}


- (void)request_Api {
    __weak UITableView *tableView = _myTableView;
    NSDictionary *dic = @{@"iface":@"DMHY400029",@"userId":[BusinessLogic uuid]};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        _mode = [SelfInforMode mj_objectWithKeyValues:responseObj];
        [tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)btnClick:(UIButton *)sender {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY400056" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic getToken] forKey:@"token"];
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"0"]) {
            NSLog(@"退出失败");
            [LCProgressHUD showFailure:@"退出登录失败"];
        } else {
            NSLog(@"退出成功");
            [BusinessLogic setUUID:@""];
            [BusinessLogic setPhoneNo:@""];
            [BusinessLogic setToken:@""];
            [MobClick profileSignOff];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.textColor = RGBA(140, 140, 140, 1);
    lable.text = @"未设置";
    lable.font = [UIFont systemFontOfSize:12];
    lable.textAlignment = NSTextAlignmentRight;
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10, 30, 30)];
    iv.image = [UIImage imageNamed:@"userdog"];
    iv.layer.cornerRadius = 15;
    iv.layer.masksToBounds = YES;
    
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            [iv sd_setImageWithURL:[NSURL URLWithString:_mode.imgUrl] placeholderImage:[UIImage imageNamed:@"dog"]];
            [cell.contentView addSubview:iv];
        } else{
        if (indexPath.row == 1) {
            lable.text = _mode.uname.length == 0?@"未设置":_mode.uname;
        }
        if (indexPath.row == 2) {
            if (_mode.sex.length == 0) {
                lable.text = @"未设置";
            } else {
                lable.text = [_mode.sex isEqualToString:@"0"]?@"女":@"男";
                
                
            
            }
        }
        if (indexPath.row == 3) {
            lable.text = _mode.birthday.length == 0?@"未设置":_mode.birthday;
            
        }
        if (indexPath.row == 4) {
            lable.text = _mode.name.length == 0?@"未设置":_mode.name;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (indexPath.row == 5) {
            lable.text = _mode.individualitySignature.length == 0?@"未设置":_mode.individualitySignature;
        }
            lable.frame = CGRectMake(SCREEN_WIDTH-235, 0, 200, 50);
        }
    } else {
        if (indexPath.section==1 && indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            lable.frame = CGRectMake(SCREEN_WIDTH-215, 0, 200, 50);
    
            lable.text = _dataSize > 1 ? [NSString stringWithFormat:@"%dM", (int)_dataSize] : @"0M";
            
        } else {
            
            lable.text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    
    }
    [cell.contentView addSubview:lable];
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = RGBA(40, 40, 40, 1);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_address.isFirstResponder) {
        [_address resignFirstResponder];
        
    }

    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册中选择", nil];
        [actionSheet showInView:self.view];
        
    }
    
    
    
    if (indexPath.section == 0 && indexPath.row == 4) {
//        [self.addressView showInView:_myTableView];
//        self.addressView = [[AddressView alloc] init];//城市
//        self.address.inputView = self.addressView;
//        self.address.inputAccessoryView = self.toolBar;
//        [self.address becomeFirstResponder];

    }

    if (indexPath.section == 0 && indexPath.row == 3) {//生日
        self.DQBirthView = [DQBirthDateView new];
        self.DQBirthView.delegate = self;
        [self.DQBirthView startAnimationFunction];
    }
    
    if (indexPath.section == 0 && indexPath.row == 2) {//性别
        self.GQSexView = [GQSexView new];
        self.GQSexView.delegate = self;
        [self. GQSexView startAnimationFunction];
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {//昵称
        [self pushWriteVC:@"昵称" isGongKai:YES];
        
    }
    
    if (indexPath.section == 0 && indexPath.row == 5) {//个性签名
        
        [self pushWriteVC:@"个性签名" isGongKai:YES];
        
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            HelpCenterController *helpCC = [[HelpCenterController alloc] initWithNibName:@"HelpCenterController" bundle:nil];
            [self.navigationController pushViewController:helpCC animated:YES];
        }
        if (indexPath.row == 1) {
            
            AboutWeViewController *aboutVC = [[AboutWeViewController alloc] initWithNibName:@"AboutWeViewController" bundle:nil];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
        
        if (indexPath.row == 2) {
            
            
           BOOL isClearSuccess = [self clearCache:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject];
            if (isClearSuccess) {
                _dataSize = 0;
                [_myTableView reloadData];
            } else {
            
            }
        }
    }
    
}
- (void)pushWriteVC:(NSString *)titleStr isGongKai:(BOOL )GK {
    WriteInforController *writeInfo = [[WriteInforController alloc] initWithNibName:@"WriteInforController" bundle:nil];
    writeInfo.titleStr = titleStr;
    writeInfo.isGongKai = GK;
    writeInfo.delegate = self;
    [self.navigationController pushViewController:writeInfo animated:YES];
    
}


- (void)writeStr:(NSString *)str title:(NSString *)title {
    if ([title isEqualToString:@"昵称"]) {
        _mode.uname = str;
    }
    if ([title isEqualToString:@"个性签名"]) {
        _mode.individualitySignature = str;
    }
    [_myTableView reloadData];
}

- (NSArray *)dataArr {
    if (!_dataArr) {
//        _dataArr = @[@[@"头像",@"昵称",@"性别",@"出生日期",@"所在城市",@"个性签名"],@[@"系统设置",@"分享该应用给好友"],@[@"帮助与反馈",@"吐槽我们",@"关于我们",@"清除缓存"]];
        _dataArr = @[@[@"头像",@"昵称",@"性别",@"出生日期",@"所在城市",@"个性签名"],@[@"帮助与反馈",@"关于我们",@"清除缓存"]];
    }
    
    return _dataArr;
}


- (UIToolbar *)toolBar{
    if (_toolBar == nil) {
        self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _toolBar.barTintColor=RGB16(0xF2F2F2);
        UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickQ:)];
        UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(click:)];
        _toolBar.items = @[item,item1, item2];
    }
    return _toolBar;
}


- (UITextField*)address {
    if (!_address) {
        _address = [[UITextField alloc] init];
        [self.view addSubview:_address];
    }
    return _address;
}

- (void)click:(UIButton *)sender{
    if (_address.isFirstResponder) {
        [_address resignFirstResponder];
        _mode.name = [NSString stringWithFormat:@"%@%@",self.addressView.province,self.addressView.city];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:4 inSection:0];
        [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)clickQ:(UIButton *)sender {
    if (_address.isFirstResponder) {
        [_address resignFirstResponder];
        
    }
    
}

//点击选中哪一行 的代理方法
- (void)clickDQBirthDateViewEnsureBtnActionAgeModel:(DQAgeModel *)ageModel andConstellation:(NSString *)str{
//    NSInteger age = [CalculateTool calculateNowAge:ageModel];
    _mode.birthday = [NSString stringWithFormat:@"%@/%@/%@",ageModel.year,ageModel.month,ageModel.day];
    NSDictionary *dic = @{@"iface":@"DMHY400005",@"userId":[BusinessLogic uuid],@"birthday":_mode.birthday};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
        [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    } failure:^(NSError *error) {
        
    }];
    
}

//点击选中哪一行 的代理方法
- (void)clickDQSexStr:(NSString *)str{
    _mode.sex = [str isEqualToString:@"女"]?@"0":@"1";
   NSDictionary *dic = @{@"iface":@"DMHY400005",@"userId":[BusinessLogic uuid],@"sex":_mode.sex};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
        [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSError *error) {
        
    }];
    
    
    
}


//相机
- (void)initImgPicker{
    if ([self isCameraAvailable]) {
        _pickerCamera=[[UIImagePickerController alloc]init];
        _pickerCamera.sourceType=UIImagePickerControllerSourceTypeCamera;
        _pickerCamera.delegate=self;
        _pickerCamera.allowsEditing=YES;
    }
    _PickerImage=[[UIImagePickerController alloc]init];
    _PickerImage.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    _PickerImage.delegate=self;
    _PickerImage.allowsEditing=YES;
    
    
}

#pragma #mark 选照片
//判断设备是否有摄像头
- (BOOL) isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
//退出当前视图
-(void)dismissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIActionSheet delegate

//设置sheetButtonAction
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        if ([self isCameraAvailable])
        {
            
            if ([thread isFinished]) {
                [self presentViewController:_pickerCamera animated:YES completion:NULL];
                
            }
        }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"该设备没有摄像头" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alert show];
            [self dismissViewController];
        }
    }
    else if (buttonIndex==1)
    {
        if ([thread isFinished]) {
            [self presentViewController:_PickerImage animated:YES completion:nil];
        }
        
    }
    else
    {
        //NSLog(@"取消");
        //        [self dismissViewController];
    }
}

- (void)presentVC:(UIImagePickerController *)piker
{
    [self presentViewController:piker animated:YES completion:nil];
}

#pragma mark - UIImagePicker delegate

//六、实现ImagePicker delegate 事件
//选取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewController];
    //获得已选择的图片
    UIImage *icImage =[info objectForKey:UIImagePickerControllerEditedImage];
//    _icImage = [icImage cutImageWithRadius:10];
    
    //    UIImage *iconImage = [self scaleFromImage:icImage1 toSize:CGSizeMake(74, 74)];
    //    //上传头像
    //    [self.button setBackgroundImage:self.image forState:UIControlStateNormal];
    
    if (picker==_pickerCamera)
    {
        //将图片保存到相册
        UIImageWriteToSavedPhotosAlbum(icImage, self, nil, nil);
    }
    //    保存到本地
    _data = UIImagePNGRepresentation(icImage);
    //    _data2 = UIImagePNGRepresentation(_icImage);
    [self uploadICImage];
    
}

//上传图片
- (void)uploadICImage {
    [LCProgressHUD showLoading:@"正在上传"];
    NSDictionary *dic = @{@"iface":@"DMHY100008",@"userId":[BusinessLogic uuid],@"type":@"0",@"token":[BusinessLogic getToken]};
    //    NSLog(@"%@",_data);
    AFHTTPSessionManager *_manager = [AFHTTPSessionManager manager];
    //    _manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求数据为json
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    _manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    //    _manager.requestSerializer.timeoutInterval=10;
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                               @"text/html",
                                                                               @"text/json",
                                                                               @"text/plain",
                                                                               @"text/javascript",
                                                                               @"text/xml",
                                                                               @"image/*"]];
    
    [_manager POST:serVerIP parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:_data name:@"file"fileName:[NSString stringWithFormat:@"image.png"] mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *res = [NetworkRequest dictionaryWithJsonString: [ZYKMD5 doDecEncryptStr:[NetworkRequest decodeFromPercentEscapeString:responseObject[@"argEncPara"]]]];
//        NSLog(@"%@",res);
        if ([responseObject[@"rescode"] isEqualToString:@"0000"]) {
            [LCProgressHUD showSuccess:@"上传成功"];
            _strImage = responseObject[@"imgUrl"];
            _mode.imgUrl = _strImage;
            [_myTableView reloadData];
            
        } else {
            [LCProgressHUD showSuccess:@"上传失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LCProgressHUD showSuccess:@"上传失败"];
    }];
    
}




//清理缓存

//计算单个文件大小
-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
//计算目录大小
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

//清理
-(BOOL)clearCache:(NSString *)path{
    NSError *error = nil;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:&error];
            if (error) {
                return NO;
            }
        }
    }
     [[SDImageCache sharedImageCache] cleanDisk];
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
