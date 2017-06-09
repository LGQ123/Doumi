//
//  NSString+ExtendMethod.m
//  douMiApp
//
//  Created by edz on 2016/12/29.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "NSString+ExtendMethod.h"

@implementation NSString (ExtendMethod)

- (NSString *)dm_substringToIndex:(NSUInteger)to
{
    if (to <= 0) {
        return @"";
    }
    if (self && self.length <= to) {
        return self;
    }
    if (self.length > to) {
        return [NSString stringWithFormat:@"%@...",[self substringToIndex:to]];
    }
    return self;
}

@end
