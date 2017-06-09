//
//  AppDelegate.m
//  douMiApp
//
//  Created by ydz on 16/10/27.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "AppDelegate.h"
#import "CYLTabBarControllerConfig.h"
#import "DM_SideslipController.h"
#import "YRSideViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMMobClick/MobClick.h"
#import "UMessage.h"
#import "BusinessLogic.h"
#import "RWebViewConreoller.h"
#import "DM_LoginController.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self showWindows];//设置主窗口
    
    /************打开次数,弹引导********************/
    if ([BusinessLogic uuid].length == 0) {
        
    } else {
        
        if ([BusinessLogic openNum].length == 0) {
            [BusinessLogic setOpenNum:@"1"];
        }
        if ([BusinessLogic isAllow].length == 0) {
            [BusinessLogic setIsAllow:@"Y"];
        }
        if ([BusinessLogic isFirst].length == 0) {
            [BusinessLogic setIsFirst:@"Y"];
        }
        
        
        
            if ([[BusinessLogic isAllow] isEqualToString:@"Y"]) {
                if ([[BusinessLogic isFirst] isEqualToString:@"Y"]) {
                    [NetworkRequest post1:serVerIP params:@{@"iface":@"DMHY100013",@"userId":[BusinessLogic uuid],@"apptime":[BusinessLogic openNum]} success:^(id responseObj) {
                        NSLog(@"app===  %@",responseObj);
                        if ([responseObj[@"play"] isEqualToString:@"1"]) {
                            NSInteger open = [[BusinessLogic openNum] integerValue]+1;
                            [BusinessLogic setOpenNum:[NSString stringWithFormat:@"%li",(long)open]];
                            [self showTeaseAlert];
                        } else {
                            NSLog(@"后台不弹");
                        }
                        
                    } failure:^(NSError *error) {
                        NSLog(@"不弹");
                    }];
                    
                } else {
                    NSLog(@"不是第一次");
                    NSInteger open = [[BusinessLogic openNum] integerValue]+1;
                    [BusinessLogic setOpenNum:[NSString stringWithFormat:@"%li",(long)open]];
                    if (open%30 == 0) {
                        [self showTeaseAlert];
                    } else {
                        NSLog(@"不弹");
                        
                    }
                    [NetworkRequest post1:serVerIP params:@{@"iface":@"DMHY100013",@"userId":[BusinessLogic uuid],@"apptime":[BusinessLogic openNum]} success:^(id responseObj) {
                        if ([responseObj[@"play"] isEqualToString:@"1"]) {
                        } else {
                           NSLog(@"后台不弹");
                        }
                        
                    } failure:^(NSError *error) {
                        NSLog(@"不弹");
                    }];
                }
                
            } else {
                NSLog(@"0000不弹");
            }
    }
    /************打开次数,弹引导********************/
    
    
    
   /******************推送****************************/
    [UMessage startWithAppkey:@"583bb47f717c195337000c2e" launchOptions:launchOptions httpsenable:YES ];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            
        } else {
            //点击不允许
            
        }
    }];
    
    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.identifier = @"action1_identifier";
    action1.title=@"打开应用";
    action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
    action2.identifier = @"action2_identifier";
    action2.title=@"忽略";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action2.destructive = YES;
    UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
    actionCategory1.identifier = @"category1";//这组动作的唯一标示
    [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
    NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
    
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_ios10_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_ios10_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category101" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories_ios10 = [NSSet setWithObjects:category1_ios10, nil];
        [center setNotificationCategories:categories_ios10];
    }else
    {
        [UMessage registerForRemoteNotifications:categories];
    }
    
    [UMessage setLogEnabled:YES];
    
    
    /******************统计****************************/
    
    UMConfigInstance.appKey = @"583bb47f717c195337000c2e";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    /******************分享****************************/
    
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"583bb47f717c195337000c2e"];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx18a37e86316e8e29" appSecret:@"50edb6a03beed4c597165c54ad145040" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105810361"  appSecret:@"BO54ab77dK0UfhCW" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1880454051"  appSecret:@"300f0d6f506bc5a5f79d0dc78badeb6c" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    /******************结构事件************************/
    [MobClick event:@[@"registerSel",@"registerPaw",@"registerCode"] value:2 label:@"注册结构化事件"];
    [MobClick event:@[@"MiFenQiSel",@"MFQIdApprove",@"MFQBackCard",@"MFQOver"] value:3 label:@"蜜分期开通结构化事件"];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    //更新
    [self VersionButton];
    if ([BusinessLogic getToken].length == 0) {
        
        
    } else {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic dm_setObject:@"DMHY400055" forKey:@"iface"];
    [dic dm_setObject:[BusinessLogic getToken] forKey:@"token"];
    [NetworkRequest post1:serVerIP params:dic success:^(id responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"0"]) {
            NSLog(@"已登录");
            
        } else {
            NSLog(@"登录超时或未登录");
            DM_LoginController *loginVC = [[DM_LoginController alloc] initWithNibName:@"DM_LoginController" bundle:nil];
            loginVC.type = @"push";
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self.window.rootViewController presentViewController:nc animated:YES completion:nil];
            [LCProgressHUD showFailure:@"登录超时或未登录,请重新登录"];
            [BusinessLogic setUUID:@""];
            [BusinessLogic setPhoneNo:@""];
            [BusinessLogic setToken:@""];
            [MobClick profileSignOff];
        }
    } failure:^(NSError *error) {
        
    }];
    }
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfo==%@",userInfo);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:@{@"userinfo":[NSString stringWithFormat:@"%@",userInfo]}];
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    
    
    
    
//    [UMessage didReceiveRemoteNotification:userInfo];
    
    //    self.userInfo = userInfo;
    //    //定制自定的的弹出框
    //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    //    {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
    //                                                            message:@"Test On ApplicationStateActive"
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"确定"
    //                                                  otherButtonTitles:nil];
    //
    //        [alertView show];
    //
    //    }
    
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"前台收到通知QuserInfo==%@",userInfo);
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"后台点击通知QuserInfo==%@",userInfo);
    NSDictionary *apsDic = userInfo[@"aps"];
    if ([apsDic[@"sound"] isEqualToString:@"homePage"]) {
        NSLog(@"homePage");
    } else {
        NSLog(@"bbbbb");
        RWebViewConreoller *webVC = [[RWebViewConreoller alloc] initWithNibName:@"RWebViewConreoller" bundle:nil];
        webVC.titleStr = @"资讯详情";
        webVC.urlStr = [NSString stringWithFormat:NewIP,apsDic[@"sound"]];
        webVC.type = @"push";
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:webVC];
        [self.window.rootViewController presentViewController:nc animated:YES completion:nil];
    }
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
    
    
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    // [UMessage registerDeviceToken:deviceToken];
    
    //下面这句代码只是在demo中，供页面传值使用。
    NSLog(@"deviceToken===%@",[self stringDevicetoken:deviceToken]);
    [BusinessLogic setDeviceToken:[self stringDevicetoken:deviceToken]];
    if ([BusinessLogic uuid]) {
        [NetworkRequest post1:serVerIP params:@{@"iface":@"DMHY100015",@"source":@"1",@"deviceSoleMark":[self stringDevicetoken:deviceToken],@"userId":[BusinessLogic uuid]} success:^(id responseObj) {
            NSLog(@"lll22222=======%@",responseObj);
        } failure:^(NSError *error) {
            
        }];
    }
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


#pragma rootWindows

- (void)showWindows {
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    tabBarControllerConfig.tabBarController.selectedIndex = 1;
    DM_SideslipController *dm_controller = [[DM_SideslipController alloc] initWithNibName:@"DM_SideslipController" bundle:nil];
    _LeftSlideController=[[YRSideViewController alloc]initWithNibName:nil bundle:nil];
    _LeftSlideController.rootViewController=tabBarControllerConfig.tabBarController;
    _LeftSlideController.leftViewController=dm_controller;
    _LeftSlideController.leftViewShowWidth=SCREEN_WIDTH-SCREEN_WIDTH/5;
    _LeftSlideController.showBoundsShadow = NO;
    [_LeftSlideController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
        //使用简单的平移动画
        rootView.frame=CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
    }];
    self.window.rootViewController = _LeftSlideController;
}

//版本更新

- (void)VersionButton {
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"%@",version);
    
    [NetworkRequest post3:serVerIP params:@{@"iface":@"DMHY100010",@"osType":@"1"} success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        NSString *str = responseObj[@"newVerNo"];
        NSLog(@"%@",str);
        if (str.length == 0) {
        } else {
        if ([responseObj[@"newVerNo"] isEqualToString:version]) {
        } else {
           [ self showAlertWithTitle:@"您好" message:@"有新版本更新，请前去下载" handler:^(UIAlertAction *action) {
               NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/%E8%B1%86%E8%9C%9C/id1186113028?mt=8"];
               [[UIApplication sharedApplication] openURL:url];
            }];
        }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^) (UIAlertAction *action))handler;
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:handler];
    [alert addAction:action];
    [alert addAction:action1];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
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
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

-(NSString *)stringDevicetoken:(NSData *)deviceToken
{
    NSString *token = [deviceToken description];
    NSString *pushToken = [[[token stringByReplacingOccurrencesOfString:@"<"withString:@""]stringByReplacingOccurrencesOfString:@">"withString:@""] stringByReplacingOccurrencesOfString:@" "withString:@""];
    return pushToken;
}

@end
