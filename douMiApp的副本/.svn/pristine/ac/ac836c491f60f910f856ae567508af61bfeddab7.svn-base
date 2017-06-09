//
//  GQPikerView.m
//  douMiApp
//
//  Created by ydz on 2016/12/27.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "GQPikerView.h"
#import "DQCanCerEnsureView.h"
#import "DQHeader.h"
#import "Masonry.h"
#import "BackInforMode.h"
@interface GQPikerView ()<DQCanCerEnsureViewDelegate>
@property (nonatomic, strong) DQCanCerEnsureView *CancerEnsure;
@property (nonatomic, assign) NSInteger SelectIndex;
@property (nonatomic, strong) NSArray <bankInfo *>*StarArr;
@property (strong,nonatomic) UIPickerView * pickerView;
@property (nonatomic, strong) UITapGestureRecognizer *ges;
@property (nonatomic, strong) UIView *backView;
@end
@implementation GQPikerView

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
        
        self.hidden = YES;
        
    }
    return self;
}

- (void)setDataArr:(NSArray *)arr andTitleStr:(NSString *)title {
    
    [self creadtionSub:arr title:title];
}

- (void)creadtionSub:(NSArray<bankInfo *>*)arr title:(NSString *)str{
    _CancerEnsure = [[DQCanCerEnsureView alloc]init];
    [_CancerEnsure setTitleText:str];
    _CancerEnsure.delegate = self;
    UIView *sub = self.backView;
    [sub  addSubview:_CancerEnsure];
    [_CancerEnsure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub);
        make.left.equalTo(sub);
        make.right.equalTo(sub);
        make.height.mas_equalTo(45);
    }];
//    NSLog(@"%@",arr);
    self.StarArr = [NSArray arrayWithArray:arr];
    self.constellationStr = self.StarArr[0].bankDetail.name;
    self.alias = self.StarArr[0].alias;
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
//    [self.pickerView selectRow:5 inComponent:0 animated:YES];
    
}
- (void)ClickCancerDelegateFunction{
    
    [self CloseAnimationFunction];
    
}
- (void)ClickEnsureDelegateFunction{
    //    self.constellationStr = self.StarArr[[self.pickerView selectedRowInComponent:0]%self.StarArr.count];
    [self CloseAnimationFunction];
    if ([self.delegate respondsToSelector:@selector(clickGQPikerStr:andAlias:)]) {
        
        [self.delegate clickGQPikerStr:self.constellationStr andAlias:self.alias];
    }
}
#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.StarArr.count;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    //    lable.font=[UIFont systemFontOfSize:13];
    lable.text=[self.StarArr objectAtIndex:row].bankDetail.name;
    return lable;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return nc_ScreenWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 41;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.constellationStr = self.StarArr[row].bankDetail.name;
    self.alias = self.StarArr[row].alias;
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

@end
