//
//  SearchDTMode.m
//  douMiApp
//
//  Created by ydz on 2016/11/29.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "SearchDTMode.h"

@implementation SearchDTMode


+ (NSDictionary *)objectClassInArray{
    return @{@"results" : [SearchResults class]};
}
@end
@implementation SearchResults
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}

@end


