//
//  FSAndZDMode.h
//  douMiApp
//
//  Created by ydz on 2016/12/10.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FSZBList;
@interface FSAndZDMode : NSObject

@property (nonatomic, copy) NSString *rescode;

@property (nonatomic, copy) NSString *resmsg;

@property (nonatomic, strong) NSArray<FSZBList *> *list;

@end
@interface FSZBList : NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, assign) NSInteger mId;

@property (nonatomic, assign) NSInteger isOnline;

@end

