//
//  InteractMode.h
//  douMiApp
//
//  Created by ydz on 2016/12/30.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Map;
@interface InteractMode : NSObject

@property (copy, nonatomic) NSString *rescode;
@property (copy, nonatomic) NSString *resmsg;
@property (strong, nonatomic) NSArray <Map *>*map;

@end

@interface Map : NSObject

@property (copy, nonatomic) NSString *comment;
@property (copy, nonatomic) NSString *commentId;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *dynId;
@property (copy, nonatomic) NSString *uname;
@property (copy, nonatomic) NSString *imgUrl;
@end
