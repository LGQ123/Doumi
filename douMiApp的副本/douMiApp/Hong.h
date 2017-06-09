//
//  Hong.h
//  tourongzhuanjia
//
//  Created by sweet luo on 15/10/12.
//  Copyright © 2015年 KristyFuWa. All rights reserved.
//

#ifndef Hong_h
#define Hong_h

#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define mainColor RGB16(0xFFBC00)
#define backColorB RGB16(0x0F0F0F)
#define writingColor RGB16(0xD3D3D3)
#define btnColor 0xF39800
#define btnHeightVolor 0xFFBC00

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#define DMFont(SIZE) [UIFont systemFontOfSize:SIZE]
#define DMFontBold(SIZE) [UIFont boldSystemFontOfSize:SIZE]

//rbg转UIColor(16进制)
#define RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA16(rgbaValue) [UIColor colorWithRed:((float)((rgbaValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbaValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbaValue & 0xFF))/255.0 alpha:((float)((rgbaValue & 0xFF000000) >> 24))/255.0]


/* { thread } */
#define __async_opt__  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define __async_main__ dispatch_async(dispatch_get_main_queue()

#define  zjself __weak __typeof(self) sfself = self
#define HEIGTH(view) view.frame.size.height
#define WIDTH(view) view.frame.size.width
#define POINTY(view) view.frame.origin.y
#define POINTX(view) view.frame.origin.x





#pragma mark - API


#define NewIP @"http://m.doume.tv/hotNews/hotNewsDetail?newsId=%@"
#define DTShareIP @"http://m.doume.tv/hdb/memberComment/f/getAllComment?dynId=%@"
#define SuperIP @"http://m.doume.tv/memberEntPlay"
#define zhuBoIP @"http://m.doume.tv/f/anchor/anchorDeta?id=%@"
#define accountHistory @"http://m.doume.tv/member/accountDetailH5?userId=%@"
#define signi @"http://m.doume.tv/memberSignInfo/toSignForApp?userId=%@"
#define regpay @"http://m.doume.tv/f/regpay"
//IP地址

//#define serVerIP @"http://app.doume.tv/DMHY/home"
//#define serVerIP @"http://192.168.15.216:8081/DMHY/home"
#define serVerIP @"http://192.168.15.243:8089/video_mobile/DMHY/home"

//#define serVerIP @"http://192.168.2.240:8087/DMHY/home"

#endif /* Hong_h */
