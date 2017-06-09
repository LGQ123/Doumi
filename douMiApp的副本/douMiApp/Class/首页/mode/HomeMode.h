//
//  HomeMode.h
//  douMiApp
//
//  Created by ydz on 2016/11/18.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Listanchoronindex,Bannerlist,talkHeadUrlList;
@interface HomeMode : NSObject


@property (nonatomic, copy) NSString *rescode;

@property (nonatomic, copy) NSString *hotNewsTitle;

@property (nonatomic, copy) NSString *pic1;

@property (nonatomic, copy) NSString *hotNewsContent;

@property (nonatomic, strong) NSArray<Bannerlist *> *bannerList;

@property (nonatomic, copy) NSString *hotNewsType;

@property (nonatomic, copy) NSString *resmsg;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *hotNewsId;

@property (nonatomic, strong) NSArray *listTalkOnindex;

@property (nonatomic, copy) NSString *pic3;

@property (nonatomic, copy) NSString *msgStatus;

@property (nonatomic, strong) NSArray<Listanchoronindex *> *listAnchorOnindex;

@property (nonatomic, copy) NSString *pic2;

@property (nonatomic, copy) NSString *publishDate;

@property (nonatomic, copy) NSString *entPlayBanner;

@property (nonatomic, copy) NSString *talkId;
@property (nonatomic, copy) NSString *talkTitle;
@property (nonatomic, copy) NSString *talkContent;
@property (nonatomic, copy) NSString *hotNum;

@property (nonatomic, copy) NSString *showYBState;

@property (nonatomic, strong) NSArray <talkHeadUrlList *>*talkHeadUrlList;


@end
@interface Listanchoronindex : NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger anchorId;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger counts;

@property (nonatomic, copy) NSString *anchorUname;

@property (nonatomic, copy) NSString *type;

@end

@interface Bannerlist : NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *descrition;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *jumpUrl;

@property (nonatomic, copy) NSString *jumpValue;
@property (nonatomic, copy) NSString *jumpType;

@end

@interface talkHeadUrlList : NSObject

@property (nonatomic, copy) NSString *mId;
@property (nonatomic, copy) NSString *headUrl;

@end

