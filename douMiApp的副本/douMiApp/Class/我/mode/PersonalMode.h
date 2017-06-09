//
//  PersonalMode.h
//  douMiApp
//
//  Created by ydz on 2016/12/7.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynamicListMode.h"
@class Dynamiclist,Userimgurllsit,replyInfo;
@interface PersonalMode : NSObject

@property (nonatomic, copy) NSString *likeNum;

@property (nonatomic, strong) NSArray<Userimgurllsit *> *UserImgUrlLsit;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, strong) NSArray<Dynamiclist *> *dynamicList;

@property (nonatomic, copy) NSString *isOnline;

@property (nonatomic, copy) NSString *dynamicCount;

@property (nonatomic, copy) NSString *resmsg;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *yyAcount;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *anchorId;

@property (nonatomic, copy) NSString *rescode;

@property (nonatomic, copy) NSString *isGuanZhu;

@property (nonatomic, strong) replyInfo *replyInfo;

@property (nonatomic, copy) NSString *introduction;


@end
@interface Dynamiclist : NSObject

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *headUrl;

@property (nonatomic, assign) NSInteger ifZan;

@property (nonatomic, assign) NSInteger contentType;

@property (nonatomic, copy) NSString *imgVideoUrl;

@property (nonatomic, copy) NSString *anchorName;

@property (nonatomic, assign) NSInteger anchorId;

@property (nonatomic, assign) NSInteger zanCount;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger dynId;

@property (nonatomic, copy) NSString *videoCover;

@property (nonatomic, copy) NSString *talkId;

@property (nonatomic, copy) NSString *talkTitle;

@property (nonatomic, copy) NSString *talkContent;

@property (nonatomic, copy) NSString *talkType;

@property (nonatomic, copy) NSString *videoUrl;

@property (nonatomic, copy) NSString *picMinUrl;

@property (nonatomic, copy) NSString *hotNum;

@end

@interface Userimgurllsit : NSObject

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *uname;

@end

