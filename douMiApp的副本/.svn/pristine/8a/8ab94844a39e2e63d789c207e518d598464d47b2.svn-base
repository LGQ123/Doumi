//
//  GQPikerView.h
//  douMiApp
//
//  Created by ydz on 2016/12/27.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GQPikerViewDelegate <NSObject>
@optional

//点击选中哪一行 的代理方法
- (void)clickGQPikerStr:(NSString *)str andAlias:(NSString *)alias;
@end
@interface GQPikerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, weak)id<GQPikerViewDelegate> delegate;

@property (nonatomic, copy)NSString *constellationStr;
@property (nonatomic, copy)NSString *alias;
@property (nonatomic, strong) UIViewController *ctl;

- (void)setDataArr:(NSArray *)arr andTitleStr:(NSString *)title;
- (void)startAnimationFunction;

- (void)CloseAnimationFunction;
@end
