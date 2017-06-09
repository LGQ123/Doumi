//
//  PopupPawView.h
//  douMiApp
//
//  Created by ydz on 2016/12/30.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol popupPawDelegate <NSObject>
@optional
- (void)popupPaw:(NSString *)paw;//输入代理
- (void)foundPawDelegate;//忘记密码代理
@end

@interface PopupPawView : UIView

@property (copy, nonatomic)NSString *title;
@property (strong, nonatomic) UILabel *errorLable;//错误提示

@property (weak, nonatomic) id<popupPawDelegate>delegate;
- (void)startAnimationFunction;//弹出
- (void)CloseAnimationFunction;//收起
@end
