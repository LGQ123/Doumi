//
//  SafetyMode.m
//  douMiApp
//
//  Created by ydz on 2016/12/10.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "SafetyMode.h"

@implementation SafetyMode

+ (NSDictionary *)objectClassInArray{
    return @{@"platformAccount" : [PlatformAccount class]};
}

@end

@implementation PlatformAccount
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}

@end
