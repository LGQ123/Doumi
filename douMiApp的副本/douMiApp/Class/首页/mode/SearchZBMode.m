//
//  SearchZBMode.m
//  douMiApp
//
//  Created by ydz on 2016/11/29.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "SearchZBMode.h"

@implementation SearchZBMode


+ (NSDictionary *)objectClassInArray{
    return @{@"results" : [SearchZBResults class]};
}
@end
@implementation SearchZBResults
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}
@end


