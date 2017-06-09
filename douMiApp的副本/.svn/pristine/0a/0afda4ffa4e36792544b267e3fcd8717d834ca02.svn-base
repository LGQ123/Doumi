//
//  GQLoveSexView.h
//  douMiApp
//
//  Created by ydz on 2016/12/12.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoveSexMode;
@protocol GQLoveSexDelegate <NSObject>
@optional

//点击选中哪一行 的代理方法
- (void)clickGQLoveSexStr:(LoveSexMode *)mode;
@end


@interface GQLoveSexView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, weak)id<GQLoveSexDelegate> delegate;

@property (nonatomic, copy)NSString *constellationStr;
@property (nonatomic, strong) UIViewController *ctl;


- (void)startAnimationFunction;

- (void)CloseAnimationFunction;

@end
