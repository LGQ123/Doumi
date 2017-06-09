//
//  HTDetailsMode.h
//  douMiApp
//
//  Created by ydz on 2016/12/6.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Talkdynamiclist;
@interface HTDetailsMode : NSObject

@property (nonatomic, copy) NSString *resmsg;

@property (nonatomic, copy) NSString *talkType;

@property (nonatomic, strong) NSArray<Talkdynamiclist *> *talkDynamicList;

@property (nonatomic, copy) NSString *picMaxUrl;

@property (nonatomic, copy) NSString *rescode;

@property (nonatomic, copy) NSString *talkContent;

@property (nonatomic, copy) NSString *videoUrl;

@property (nonatomic, copy) NSString *talkTitle;

@end
@interface Talkdynamiclist : NSObject

@property (nonatomic, assign) NSInteger zanNum;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, assign) NSInteger talkUserId;

@property (nonatomic, copy) NSString *headUrl;

@property (nonatomic, assign) NSInteger contentType;

@property (nonatomic, copy) NSString *imgVideoUrl;

@property (nonatomic, copy) NSString *isDel;

@property (nonatomic, assign) NSInteger commentNum;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger dynId;

@property (nonatomic, assign) NSInteger zanStatus;

@end

