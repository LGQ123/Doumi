//
//  NSMutableArray+dmAdd.h
//  douMiApp
//
//  Created by edz on 2016/12/27.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (dmAdd)

- (void)dm_addObject:(id)anObject;

- (void)dm_insertObject:(id)anObject atIndex:(NSUInteger)index;

@end
