//
//  DMSelectBankcardViewController.h
//  douMiApp
//
//  Created by edz on 2017/1/16.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import "RootNViewController.h"
#import "DMMeXinModel.h"

@interface DMSelectBankcardViewController : RootNViewController<UITextFieldDelegate>

@property (nonatomic, assign) BOOL isBindBankcard; // 是否绑定了银行卡
@property (nonatomic, strong) DMMeXinBankInfoModel *bankInfoModel;

@end
