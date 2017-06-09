//
//  GQSexView.h
//  DQBirthDate
//
//  Created by ydz on 2016/12/6.
//  Copyright © 2016年 GuanzhouDQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GQSEXDelegate <NSObject>
@optional

//点击选中哪一行 的代理方法
- (void)clickDQSexStr:(NSString *)str;
@end
@interface GQSexView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, weak)id<GQSEXDelegate> delegate;

@property (nonatomic, copy)NSString *constellationStr;
@property (nonatomic, strong) UIViewController *ctl;


- (void)startAnimationFunction;

- (void)CloseAnimationFunction;
@end
