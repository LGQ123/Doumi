//
//  ShouXinMoe.h
//  douMiApp
//
//  Created by ydz on 2017/1/17.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class creditResult;
@interface ShouXinMoe : NSObject

@property (strong, nonatomic) creditResult *creditResult;

@end

@interface creditResult : NSObject

@property (nonatomic, assign) NSInteger success;

@end
