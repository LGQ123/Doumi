//
//  HTListMode.m
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "HTListMode.h"

@implementation HTListMode


+ (NSDictionary *)objectClassInArray{
    return @{@"talkList" : [TalkHTlist class]};
}
@end
@implementation TalkHTlist

+ (NSDictionary *)objectClassInArray{
    return @{@"headUrlList" : [Headurllist class]};
}

@end


@implementation Headurllist

@end


