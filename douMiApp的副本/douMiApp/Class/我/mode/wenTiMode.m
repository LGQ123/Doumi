//
//  wenTiMode.m
//  douMiApp
//
//  Created by ydz on 2016/12/12.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "wenTiMode.h"

@implementation wenTiMode
+ (NSDictionary *)objectClassInArray{
    return @{@"questions" : [QuestionsA class],@"mIdList":[QuestionsA class]};
}
@end

@implementation QuestionsA

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}

@end
