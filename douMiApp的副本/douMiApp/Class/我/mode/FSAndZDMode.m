//
//  FSAndZDMode.m
//  douMiApp
//
//  Created by ydz on 2016/12/10.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "FSAndZDMode.h"

@implementation FSAndZDMode


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [FSZBList class]};
}
@end
@implementation FSZBList
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}
@end


