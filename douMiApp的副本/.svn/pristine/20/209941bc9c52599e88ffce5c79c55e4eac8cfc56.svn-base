//
//  DynamicListMode.h
//  douMiApp
//
//  Created by ydz on 2016/11/17.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Effectresults,Comments,Results,Comments,Notconcernedanchors,replyInfo,TalkListFound,TalkDetail;
@interface DynamicListMode : NSObject

@property (nonatomic, copy) NSString *pageNo;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, copy) NSString *resmsg;

@property (nonatomic, strong) NSArray<Results *> *effectResults;

@property (nonatomic, copy) NSString *replyTotalSize;

@property (nonatomic, copy) NSString *totalRecord;

@property (nonatomic, strong) NSArray<Results *> *results;

@property (nonatomic, copy) NSString *rescode;

@property (nonatomic, strong) NSArray<Notconcernedanchors *> *notConcernedAnchors;

@property (nonatomic, copy) NSString *totalPage;

@property (nonatomic, strong) replyInfo *replyInfo;

@property (nonatomic, strong) NSArray <TalkListFound*>*talkList;

@end
@interface Effectresults : NSObject

@property (nonatomic, strong) NSArray<Comments *> *comments;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *imgOrVideoUrl;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger contentType;

@property (nonatomic, assign) NSInteger thumbUpNum;

@property (nonatomic, copy) NSString *anchorUName;

@property (nonatomic, copy) NSString *headImgUrl;

@property (nonatomic, assign) NSInteger anchorId;

@property (nonatomic, assign) NSInteger thumbUpStatus;

@property (nonatomic, copy) NSString *createTime;

@end

@interface Comments : NSObject

@property (nonatomic, assign) NSInteger memBid;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger memId;

@property (nonatomic, copy) NSString *headImgUrl;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger dynId;

@property (nonatomic, assign) CGFloat money;

@property (nonatomic, copy) NSString *buname;

@property (nonatomic, copy) NSString *isDel;

@end

@interface Results : NSObject

@property (nonatomic, strong) NSMutableArray<Comments *> *comments;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *imgOrVideoUrl;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger contentType;

@property (nonatomic, assign) NSInteger thumbUpNum;

@property (nonatomic, copy) NSString *anchorUName;

@property (nonatomic, copy) NSString *headImgUrl;

@property (nonatomic, assign) NSInteger anchorId;

@property (nonatomic, assign) NSInteger thumbUpStatus;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger commentTotalSize;

@property (nonatomic, copy) NSString *videoCover;

@property (nonatomic, strong) TalkDetail *talkDetail;


@end


@interface Notconcernedanchors : NSObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *uname;

@end

@interface replyInfo : NSObject

@property (nonatomic, copy) NSString *lastHeadImgUrl;
@property (nonatomic, assign) NSInteger replyTotalSize;

@end

@interface TalkListFound : NSObject
@property (nonatomic, copy) NSString *talkId;
@property (nonatomic, copy) NSString *talkTitle;

@end


@interface TalkDetail : NSObject

@property (nonatomic, copy) NSString *talkId;
@property (nonatomic, copy) NSString *hotNum;
@property (nonatomic, copy) NSString *picMaxUrl;
@property (nonatomic, copy) NSString *picMinUrl;
@property (nonatomic, copy) NSString *talkContent;
@property (nonatomic, copy) NSString *talkTitle;
@property (nonatomic, copy) NSString *talkType;
@property (nonatomic, copy) NSString *videoUrl;

@end
