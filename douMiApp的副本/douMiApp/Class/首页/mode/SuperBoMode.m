//
//  SuperBoMode.m
//  douMiApp
//
//  Created by ydz on 2016/12/6.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "SuperBoMode.h"

@implementation SuperBoMode


+ (NSDictionary *)objectClassInArray{
    return @{@"hashMapList" : [Hashmaplist class], @"questions" : [Questions class]};
}
@end
@implementation Hashmaplist

+ (NSDictionary *)objectClassInArray{
    return @{@"ents" : [Ents class]};
}

@end


@implementation Ents
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}
@end


@implementation Questions
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}
@end


