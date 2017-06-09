//
//  DM_PerfectController.m
//  douMiApp
//
//  Created by ydz on 2016/11/7.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "DM_PerfectController.h"
#import "UIImage+Resize.h"
#import <AFNetworking.h>
#import "ZYKMD5.h"
@interface DM_PerfectController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    NSThread *thread;
    NSData *_data;
    NSData *_data2;
}
@property (weak, nonatomic) IBOutlet UIButton *icBtn;
@property (weak, nonatomic) IBOutlet MBTextFieldWithFontAdapter *nickNameText;
@property (nonatomic,strong) UIImagePickerController * pickerCamera;
@property (nonatomic,strong) UIImagePickerController * PickerImage;
@property (copy, nonatomic) NSString *strImage;
@property (strong, nonatomic) UIImage *icImage;
@property (weak, nonatomic) IBOutlet UILabel *tishi;

@end

@implementation DM_PerfectController
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
    self.lable.text = @"完善信息";
    self.lable.textColor = RGBA(40, 40, 40, 1);
    _data = [[NSData alloc] init];
    _data2 = [[NSData alloc] init];
    thread = [[NSThread alloc] initWithTarget:self selector:@selector(initImgPicker) object:nil];
    [thread start];
    [_nickNameText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.nickNameText) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
    
    
}


- (IBAction)iconTouch:(UIButton *)sender {//头像
    [self.view endEditing:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册中选择", nil];
    [actionSheet showInView:self.view];
}
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
    _icImage = [icImage cutImageWithRadius:10];
    
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
        NSLog(@"%@",responseObject);
        if ([responseObject[@"rescode"] isEqualToString:@"0000"]) {
            [LCProgressHUD showSuccess:@"上传成功"];
            _strImage = responseObject[@"imgUrl"];
           [_icBtn setBackgroundImage:_icImage forState:UIControlStateNormal];
        } else {
            [LCProgressHUD showSuccess:@"上传失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LCProgressHUD showSuccess:@"上传失败"];
    }];
    
}


- (IBAction)skipTouch:(UIButton *)sender {//跳过
    if ([_type isEqualToString:@"push"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
- (IBAction)completeTouch:(UIButton *)sender {//完成
    
    if (_nickNameText.text.length == 0) {
       [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
    NSDictionary *dic = @{@"iface":@"DMHY100003",@"userId":[BusinessLogic uuid],@"nickName":_nickNameText.text};
    [NetworkRequest post:serVerIP params:dic success:^(id responseObj) {
        if ([_type isEqualToString:@"push"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(NSError *error){
        
    }];
    }
}

- (void)showLeft {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
