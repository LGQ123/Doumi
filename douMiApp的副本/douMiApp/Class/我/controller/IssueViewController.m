//
//  IssueViewController.m
//  douMiApp
//
//  Created by ydz on 2016/11/24.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "IssueViewController.h"
#import <IQKeyboardManager.h>
#import <AFNetworking.h>
#import "ZYKMD5.h"
@interface IssueViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

{
    NSThread *thread;
    NSData *_data;
}

@property (weak, nonatomic) IBOutlet UILabel *plLable;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong, nonatomic) UIView *keyBordView;

@property (strong, nonatomic) UIButton *picBtn;
@property (strong, nonatomic) UIButton *biaoQingBtn;
@property (strong, nonatomic) UIButton *isPublicBtn;

@property (strong, nonatomic) UIButton *jzjBtn;
@property (strong, nonatomic) UIButton *gkBtn;

@property (strong , nonatomic) UIImageView *jiantouIV;

@property (weak, nonatomic) UIButton *oldBtn;

@property (assign, nonatomic) BOOL isOpen;

@property (assign, nonatomic) CGSize kbSize;
@property (assign, nonatomic) double kbTime;

@property (nonatomic,strong) UIImagePickerController * pickerCamera;
@property (nonatomic,strong) UIImagePickerController * PickerImage;

@property (nonatomic, copy) NSString *flag;
@property (nonatomic, copy) NSString *isPublic;

@end

@implementation IssueViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    thread = [[NSThread alloc] initWithTarget:self selector:@selector(initImgPicker) object:nil];
    [thread start];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
        _keyBordView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 50);
        _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
        _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
        _isPublicBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
    } completion:^(BOOL finished) {
        
    }];
    
    
}


- (void)createKeyBordView:(CGSize )kbSize {

    
    
    [UIView animateWithDuration:0.3 animations:^{
        _keyBordView.frame = CGRectMake(0, SCREEN_HEIGHT-kbSize.height-50, SCREEN_WIDTH, 50);
        _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-kbSize.height-13-25, 50, 25);
        _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-kbSize.height-13-25, 50, 25);
        _isPublicBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-kbSize.height-13-25, 50, 25);
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}

- (void)picBtnTouch:(UIButton *)sender {
    [self.view endEditing:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册中选择", nil];
    [actionSheet showInView:self.view];
    
}


- (void)initImgPicker{
    if ([self isCameraAvailable]) {
        _pickerCamera=[[UIImagePickerController alloc]init];
        _pickerCamera.sourceType=UIImagePickerControllerSourceTypeCamera;
        _pickerCamera.delegate=self;
        _pickerCamera.allowsEditing=NO;
    }
    _PickerImage=[[UIImagePickerController alloc]init];
    _PickerImage.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    _PickerImage.delegate=self;
    _PickerImage.allowsEditing=NO;
    
    
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
        [_myTextView becomeFirstResponder];

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
    [_myTextView becomeFirstResponder];
    _closeBtn.hidden = NO;
    _myImage.hidden = NO;
    _shadowView.hidden = NO;
    UIImage *icImage =[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *icimage1 = [self compressImage:icImage toTargetWidth:SCREEN_WIDTH];
    //    UIImage *iconImage = [self scaleFromImage:icImage1 toSize:CGSizeMake(74, 74)];
    //    //上传头像
    //    [self.button setBackgroundImage:self.image forState:UIControlStateNormal];
    _myImage.image = icImage;
    
    
    if (picker==_pickerCamera)
    {
        //将图片保存到相册
        UIImageWriteToSavedPhotosAlbum(icImage, self, nil, nil);
    }
    //    保存到本地
    _data = UIImagePNGRepresentation(icimage1);
    //    _data2 = UIImagePNGRepresentation(_icImage);
//    [self uploadICImage];
    
}

- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//上传图片
- (void)uploadICImage {
//    [LCProgressHUD showLoading:@"正在上传"];
//    NSDictionary *dic = @{@"iface":@"DMHY100008",@"userId":[BusinessLogic uuid],@"type":@"0"};
//    //    NSLog(@"%@",_data);
//    AFHTTPSessionManager *_manager = [AFHTTPSessionManager manager];
//    //    _manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求数据为json
//    _manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
//    _manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
//    //    _manager.requestSerializer.timeoutInterval=10;
//    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
//                                                                               @"text/html",
//                                                                               @"text/json",
//                                                                               @"text/plain",
//                                                                               @"text/javascript",
//                                                                               @"text/xml",
//                                                                               @"image/*"]];
//    
//    [_manager POST:serVerIP parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:_data name:@"file"fileName:[NSString stringWithFormat:@"image.png"] mimeType:@"image/png"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"%@",responseObject);
//        if ([responseObject[@"rescode"] isEqualToString:@"0000"]) {
//            [LCProgressHUD showSuccess:@"上传成功"];
//            _strImage = responseObject[@"imgUrl"];
//            [_icBtn setBackgroundImage:_icImage forState:UIControlStateNormal];
//            
//        } else {
//            [LCProgressHUD showSuccess:@"上传失败"];
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [LCProgressHUD showSuccess:@"上传失败"];
//    }];
    
}



- (void)biaoQingBtnTouch:(UIButton *)sender {

    
}

- (void)isPublicBtnTouch:(UIButton *)sender {
    _isOpen = !_isOpen;
    if (_isOpen) {
        [UIView animateWithDuration:0.5 animations:^{
            _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25-39, 50, 25);
            _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25-74, 50, 25);
            _jiantouIV.image = [UIImage imageNamed:@"bottom"];
        } completion:^(BOOL finished) {
            
        }];
    } else {
        
        [_isPublicBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25, 50, 25);
            _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25, 50, 25);
            _jiantouIV.image = [UIImage imageNamed:@"top"];
        } completion:^(BOOL finished) {
            
        }];

    }
    
    
}

- (void)BtnTouch:(UIButton *)sender {
    _isOpen = !_isOpen;
    _oldBtn.selected = NO;
    [_oldBtn setBackgroundColor:[UIColor whiteColor]];
    sender.selected = YES;
    [sender setBackgroundColor:RGBA(60, 60, 60, 1)];
    _oldBtn = sender;
    [_isPublicBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25, 50, 25);
        _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT-_kbSize.height-13-25, 50, 25);
        _jiantouIV.image = [UIImage imageNamed:@"top"];
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _closeBtn.hidden = YES;
    _shadowView.hidden = YES;
    _myImage.hidden = YES;
    [_myTextView becomeFirstResponder];
    _isOpen = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(SCREEN_WIDTH-14-40, 34, 40, 20);
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:RGBA(139, 139, 139, 1) forState:UIControlStateNormal];
    [btn setBackgroundColor:RGBA(247, 247, 247, 1)];
    btn.layer.borderColor = [RGBA(160, 160, 160, 1) CGColor];
    btn.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(showRight:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:btn];
    
    _data = [[NSData alloc] init];
    [self createKeyBordView];
    
    if ([self.type isEqualToString:@"dt"]) {
        _flag = @"1";
        [self addItem:item_left btnTitle:@"close" viewTitle:@"发布状态"];
    } else {
        _flag = @"2";
        _plLable.text = @"对这个话题有什么想法，说出来让大家知道吧";
        [self addItem:item_left btnTitle:@"close" viewTitle:@"评论话题"];
    }
}

//创建keyBordView

- (void)createKeyBordView {
    
    _keyBordView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 50)];
    _keyBordView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_keyBordView];
    
    
    _jzjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _jzjBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
    [_jzjBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_jzjBtn setTitleColor:RGBA(39, 39, 39, 1) forState:UIControlStateNormal];
    [_jzjBtn setTitle:@"仅自己" forState:UIControlStateNormal];
    _jzjBtn.titleLabel.font= [UIFont systemFontOfSize:10];
    [_jzjBtn setBackgroundColor:[UIColor whiteColor]];
    _jzjBtn.layer.cornerRadius = 13;
    _jzjBtn.layer.masksToBounds = YES;
    _jzjBtn.layer.borderWidth = 0.5;
    [_jzjBtn addTarget:self action:@selector(BtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_jzjBtn];
    
    _gkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _gkBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
    [_gkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_gkBtn setTitleColor:RGBA(39, 39, 39, 1) forState:UIControlStateNormal];
    [_gkBtn setTitle:@"公开" forState:UIControlStateNormal];
    _gkBtn.titleLabel.font= [UIFont systemFontOfSize:10];
    [_gkBtn setBackgroundColor:[UIColor whiteColor]];
    _gkBtn.layer.cornerRadius = 13;
    _gkBtn.layer.masksToBounds = YES;
    _gkBtn.layer.borderWidth = 0.5;
    [_gkBtn addTarget:self action:@selector(BtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self BtnTouch:_gkBtn];
    [self.view addSubview:_gkBtn];
    
    _isPublicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _isPublicBtn.frame = CGRectMake(SCREEN_WIDTH-14-50, SCREEN_HEIGHT, 50, 25);
    [_isPublicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_isPublicBtn setTitle:@"公开" forState:UIControlStateNormal];
    _isPublicBtn.titleLabel.font= [UIFont systemFontOfSize:10];
    [_isPublicBtn setBackgroundColor:RGBA(60, 60, 60, 1)];
    _isPublicBtn.layer.cornerRadius = 13;
    _isPublicBtn.layer.masksToBounds = YES;
    _isPublicBtn.layer.borderWidth = 0.5;
    [_isPublicBtn addTarget:self action:@selector(isPublicBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_isPublicBtn];
    
    _picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _picBtn.frame = CGRectMake(14, 14, 25, 25);
    [_picBtn setBackgroundImage:[UIImage imageNamed:@"imagePic"] forState:UIControlStateNormal];
    [_picBtn addTarget:self action:@selector(picBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [_keyBordView addSubview:_picBtn];
    
//    _biaoQingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _biaoQingBtn.frame = CGRectMake(60, 14, 25, 25);
//    [_biaoQingBtn setBackgroundImage:[UIImage imageNamed:@"smallBQ"] forState:UIControlStateNormal];
//    [_biaoQingBtn addTarget:self action:@selector(biaoQingBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
//    [_keyBordView addSubview:_biaoQingBtn];
    
    _jiantouIV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-42, 4, 6, 5)];
    _jiantouIV.image = [UIImage imageNamed:@"top"];
    [_keyBordView addSubview:_jiantouIV];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{    if (![text isEqualToString:@""])
    
{
    
    _plLable.hidden = YES;
    
}
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        
        _plLable.hidden = NO;
        
    }
    
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    
    
    if (textView.text.length > 200) {
        textView.text = [textView.text substringToIndex:200];
    }
    
}
- (IBAction)closeTouch:(UIButton *)sender {
    _myImage.hidden = YES;
    _shadowView.hidden = YES;
    sender.hidden = YES;
}

- (void)showRight:(UIButton *)sender {
    sender.enabled = NO;
    if ([_isPublicBtn.titleLabel.text isEqualToString:@"公开"]) {
        _isPublic = @"1";
    } else {
        _isPublic = @"0";
    }
    
    if (_closeBtn.hidden) {
        [self request_TextApi:sender];
    } else {
        [self request_ImgApi:sender];
    }
    
}

- (void)request_TextApi:(UIButton *)sender {
    NSDictionary *dic;
    
    if (self.talkID.length == 0) {
        dic = @{@"iface":@"DMHY300008",@"userId":[BusinessLogic uuid],@"isPublic":_isPublic,@"content":_myTextView.text,@"contentType":@"0",@"flag":_flag,@"token":[BusinessLogic getToken]};
    } else {
        dic = @{@"iface":@"DMHY300008",@"userId":[BusinessLogic uuid],@"isPublic":_isPublic,@"content":_myTextView.text,@"contentType":@"0",@"flag":_flag,@"talkId":self.talkID,@"token":[BusinessLogic getToken]};
    }
    
    [NetworkRequest post3:serVerIP params:dic success:^(id responseObj) {
        
        if ([responseObj[@"rescode"] isEqualToString:@"0000"]) {
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [LCProgressHUD showMessage:responseObj[@"resmsg"]];
        }
    } failure:^(NSError *error) {
        [LCProgressHUD showMessage:@"发送失败"];
    }];
    
    sender.enabled = YES;
    
}

- (void)request_ImgApi:(UIButton *)sender {
    
    NSDictionary *dic;
    
    if (self.talkID.length == 0) {
        dic = @{@"iface":@"DMHY300008",@"userId":[BusinessLogic uuid],@"isPublic":_isPublic,@"content":_myTextView.text,@"contentType":@"1",@"flag":_flag,@"token":[BusinessLogic getToken]};
    } else {
        dic = @{@"iface":@"DMHY300008",@"userId":[BusinessLogic uuid],@"isPublic":_isPublic,@"content":_myTextView.text,@"contentType":@"1",@"flag":_flag,@"talkId":self.talkID,@"token":[BusinessLogic getToken]};
    }
   
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
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [LCProgressHUD showMessage:responseObject[@"resmsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LCProgressHUD showSuccess:@"上传失败"];
    }];
    sender.enabled = YES;
    
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
