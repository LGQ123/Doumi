//
//  MessageMode.m
//  douMiApp
//
//  Created by ydz on 2016/12/12.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "MessageModeA.h"

@implementation MessageModeA


+ (NSDictionary *)objectClassInArray{
    return @{@"results" : [Messagelist class]};
}
@end


@implementation Messagelist
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}

@end


@implementation MessageSystemListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"messageList" : [MessageSystemModel class]};
}

@end


@implementation MessageSystemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"msgId": @"id"};
}

@end


@implementation MessageZanListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"map" : [MessageZanModel class]};
}

@end


@implementation MessageZanModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"msgId": @"id"};
}

@end





