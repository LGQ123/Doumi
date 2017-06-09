//
//  GQLoveSexView.m
//  douMiApp
//
//  Created by ydz on 2016/12/12.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "GQLoveSexView.h"
#import "DQCanCerEnsureView.h"
#import "DQHeader.h"
#import "Masonry.h"
#import "LoveSexMode.h"
@interface GQLoveSexView ()<DQCanCerEnsureViewDelegate>
@property (nonatomic, strong) DQCanCerEnsureView *CancerEnsure;
@property (nonatomic, assign) NSInteger SelectIndex;
@property (nonatomic, copy) NSArray <NSArray *>*StarArr;
@property (strong,nonatomic) UIPickerView * pickerView;
@property (nonatomic, strong) UITapGestureRecognizer *ges;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) LoveSexMode *mode;
@end

@implementation GQLoveSexView


- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0,0, nc_ScreenWidth, nc_ScreenHeight);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [window addSubview:self];
        UIView *blackView1 = [UIView new];
        blackView1.backgroundColor = HEX_COLOR(0x000000);
        blackView1.alpha = 0.6f;
        blackView1.frame = CGRectMake(0, 0, nc_ScreenWidth, nc_ScreenHeight);
        [self addSubview:blackView1];
        self.ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestureCloseSelectViewAnimation:)];
        [self.window bringSubviewToFront:self];
        [blackView1 addGestureRecognizer:self.ges];
        self.backView = [UIView new];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.frame = CGRectMake(0, nc_ScreenHeight, nc_ScreenWidth, 260);
        //self.backView.center = CGPointMake(nc_ScreenWidth/2.0f, nc_ScreenHeight+130);
        [self addSubview:self.backView];
        [self creadtionSub];
        self.hidden = YES;
    }
    return self;
}
- (void)creadtionSub{
    _CancerEnsure = [[DQCanCerEnsureView alloc]init];
    [_CancerEnsure setTitleText:@"性取向"];
    _CancerEnsure.delegate = self;
    UIView *sub = self.backView;
    [sub  addSubview:_CancerEnsure];
    [_CancerEnsure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub);
        make.left.equalTo(sub);
        make.right.equalTo(sub);
        make.height.mas_equalTo(45);
    }];
    self.StarArr =@[@[@"公开",@"仅自己"],@[@"同性恋",@"异性恋",@"双性恋"]];
    self.mode = [[LoveSexMode alloc] init];
    self.mode.isGK = self.StarArr[0][0];
    self.mode.sex = self.StarArr[1][0];
    self.pickerView = [UIPickerView new];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    [sub addSubview:self.pickerView];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(45);
        make.left.equalTo(sub);
        make.right.equalTo(sub);
        make.bottom.equalTo(sub);
    }];
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:5 inComponent:0 animated:YES];
    
}
- (void)ClickCancerDelegateFunction{
    
    [self CloseAnimationFunction];
    
}
- (void)ClickEnsureDelegateFunction{
    //    self.constellationStr = self.StarArr[[self.pickerView selectedRowInComponent:0]%self.StarArr.count];
    [self CloseAnimationFunction];
    
    
    if ([self.delegate respondsToSelector:@selector(clickGQLoveSexStr:)]) {
        
        [self.delegate clickGQLoveSexStr:self.mode];
    }
}
#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return self.StarArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.StarArr[component].count;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    //    lable.font=[UIFont systemFontOfSize:13];
    lable.text=[[self.StarArr objectAtIndex:component] objectAtIndex:row];
    return lable;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return nc_ScreenWidth/2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 41;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    if (component == 0) {
      self.mode.isGK = self.StarArr[0][row];
    } else {
        self.mode.sex = self.StarArr[1][row];
    }
    
}
- (void)startAnimationFunction{
    UIView *AnView = self.backView;
    self.hidden = NO;
    CGRect rect = AnView.frame;
    rect.origin.y = nc_ScreenHeight-260;
    [self.window bringSubviewToFront:self];
    [UIView animateWithDuration:0.4 animations:^{
        
        AnView.frame = rect;
    }];
    
}
- (void)CloseAnimationFunction{
    
    UIView *AnView = self.backView;
    CGRect rect = AnView.frame;
    rect.origin.y = nc_ScreenHeight;
    [UIView animateWithDuration:0.4f animations:^{
        AnView.frame = rect;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}

- (void)GestureCloseSelectViewAnimation:(UIGestureRecognizer *)ges{
    
    [self CloseAnimationFunction];
}

- (void)dealloc{
    
    self.ges = nil;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
