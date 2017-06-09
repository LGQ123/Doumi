//
//  MessageMode.m
//  douMiApp
//
//  Created by ydz on 2016/11/18.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MessageMode.h"

@implementation MessageMode


+ (NSDictionary *)objectClassInArray{
    return @{@"hotNewsList" : [Hotnewslist class]};
}
@end
@implementation Hotnewslist

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}

@end


