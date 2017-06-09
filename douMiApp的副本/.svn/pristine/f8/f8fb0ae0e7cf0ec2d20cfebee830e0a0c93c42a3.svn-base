//
//  NSMutableDictionary+dmSet.m
//  douMiApp
//
//  Created by edz on 2016/12/26.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import "NSMutableDictionary+dmSet.h"

@implementation NSMutableDictionary (dmSet)

- (void)dm_setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (anObject&&aKey) {
        
        [self setObject:anObject forKey:aKey];
    }
    
}


@end



@implementation NSDictionary (dzGet)

- (id)dm_getObjectForKey:(id)aKey
{
    if (self&&[self isKindOfClass:[NSDictionary class]]) {
        
        id o = [self objectForKey:aKey];
        if ([o isKindOfClass:[NSNull class]]) {
            return nil;
        }else{
            return o;
        }
    }
    return nil;
}

@end
