//
//  HTListMode.h
//  douMiApp
//
//  Created by ydz on 2016/12/5.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TalkHTlist,Headurllist;
@interface HTListMode : NSObject

@property (nonatomic, copy) NSString *rescode;

@property (nonatomic, strong) NSArray<TalkHTlist *> *talkList;

@property (nonatomic, copy) NSString *resmsg;



@end
@interface TalkHTlist : NSObject

@property (nonatomic, assign) NSInteger hotNum;

@property (nonatomic, copy) NSString *talkTitle;

@property (nonatomic, assign) NSInteger talkId;

@property (nonatomic, strong) NSArray<Headurllist *> *headUrlList;

@property (nonatomic, copy) NSString *talkContent;

@end

@interface Headurllist : NSObject

@property (nonatomic, assign) NSInteger mId;

@property (nonatomic, copy) NSString *headUrl;

@end

