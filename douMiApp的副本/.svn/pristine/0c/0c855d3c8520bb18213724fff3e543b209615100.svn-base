//
//  MyErWeiMaController.m
//  douMiApp
//
//  Created by ydz on 2016/12/1.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MyErWeiMaController.h"
#import <UMSocialCore/UMSocialCore.h>

#import <UShareUI/UMSocialUIManager.h>
@interface MyErWeiMaController ()

@end

@implementation MyErWeiMaController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.hidesBackButton = YES;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addItem:nitem_left btnTitleArr:@[@"BackW"]];
    [self addItem:nitem_right btnTitleArr:@[@"share_W"]];
    self.lable.text = @"我的二维码";
    self.view.backgroundColor = RGBA(60, 60, 60, 1);
    
    [self createUI];
    
}

- (void)showRightView:(UIButton *)btn {
    __weak typeof(self) weakSelf = self;
    //显示分享面板
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [weakSelf shareWebPageToPlatformType:platformType];
    }];
    
    
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UIImage *image;
    if (_icimage.length == 0) {
        image = [UIImage imageNamed:@"userdog"];
    } else {
        image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_icimage]]];
    }
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"快来和%@互动吧",_name] descr:_sharecontent thumImage:image];
    
    //设置网页地址
    shareObject.webpageUrl =[NSString stringWithFormat:zhuBoIP,[BusinessLogic uuid]];
    
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

- (void)createUI {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    view.backgroundColor = [UIColor whiteColor];
    view.center = self.view.center;
    [self.view addSubview:view];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    iv.layer.cornerRadius = 30;
    iv.layer.masksToBounds = YES;
    [iv sd_setImageWithURL:[NSURL URLWithString:self.icimage] placeholderImage:[UIImage imageNamed:@"dog"]];
    [view addSubview:iv];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(90, 35, 200, 13)];
    lable.textColor = RGBA(40, 40, 40, 1);
    lable.font = [UIFont boldSystemFontOfSize:12];
    lable.text = _name;
    [view addSubview:lable];
    
    UIImageView *sexIV = [[UIImageView alloc] initWithFrame:CGRectMake(90, 55, 17, 17)];
    if ([self.sex isEqualToString:@"女"]) {
        sexIV.image = [UIImage imageNamed:@"gril"];
    } else {
        sexIV.image = [UIImage imageNamed:@"man"];
    }
    [view addSubview:sexIV];
    
    UIImageView *EWMIV = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    [view addSubview:EWMIV];
    [EWMIV setImage:[self createQRImageWithString:[NSString stringWithFormat:@"http://m.doume.tv/f/anchor/anchorDeta?id=%@",[BusinessLogic uuid]] size:CGSizeMake(WIDTH(EWMIV), HEIGTH(EWMIV))]];
    
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, 300, 13)];
    lable1.textColor = RGBA(139, 139, 139, 1);
    lable1.font = [UIFont systemFontOfSize:12];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.text = [NSString stringWithFormat:@"扫一扫去看%@",self.name];
    [view addSubview:lable1];
}


/** 生成指定大小的黑白二维码 */
- (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //    NSLog(@"%@",qrFilter.inputKeys);
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    //放大并绘制二维码 (上面生成的二维码很小，需要放大)
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

/** 为二维码改变颜色 */
- (UIImage *)changeColorForQRImage:(UIImage *)image backColor:(UIColor *)backColor frontColor:(UIColor *)frontColor
{
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",[CIImage imageWithCGImage:image.CGImage],
                             @"inputColor0",[CIColor colorWithCGColor:frontColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:backColor.CGColor],
                             nil];
    
    return [UIImage imageWithCIImage:colorFilter.outputImage];
}

/** 在二维码中心加一个小图 */
- (UIImage *)addSmallImageForQRImage:(UIImage *)qrImage
{
    UIGraphicsBeginImageContext(qrImage.size);
    
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    
    UIImage *image = [UIImage imageNamed:@"dog"];
    
    CGFloat imageW = 50;
    CGFloat imageX = (qrImage.size.width - imageW) * 0.5;
    CGFloat imgaeY = (qrImage.size.height - imageW) * 0.5;
    
    [image drawInRect:CGRectMake(imageX, imgaeY, imageW, imageW)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
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
