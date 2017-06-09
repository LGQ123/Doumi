//
//  HomeMode.m
//  douMiApp
//
//  Created by ydz on 2016/11/18.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "HomeMode.h"

@implementation HomeMode


+ (NSDictionary *)objectClassInArray{
    return @{@"listAnchorOnindex" : [Listanchoronindex class], @"bannerList" : [Bannerlist class],@"talkHeadUrlList":[talkHeadUrlList class]};
}
@end
@implementation Listanchoronindex

@end


@implementation Bannerlist

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return@{@"Id": @"id"};
}


@end

@implementation talkHeadUrlList

@end

