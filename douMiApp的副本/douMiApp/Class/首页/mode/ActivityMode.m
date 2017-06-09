//
//  ActivityMode.m
//  douMiApp
//
//  Created by ydz on 2016/11/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "ActivityMode.h"

@implementation ActivityMode


+ (NSDictionary *)objectClassInArray{
    return @{@"results" : [ResultsActivity class]};
}
@end
@implementation ResultsActivity

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}
@end


