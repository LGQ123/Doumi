//
//  ActivityMode.h
//  douMiApp
//
//  Created by ydz on 2016/11/28.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ResultsActivity;
@interface ActivityMode : NSObject

@property (nonatomic, copy) NSString *pageNo;

@property (nonatomic, copy) NSString *pageSize;

@property (nonatomic, copy) NSString *resmsg;

@property (nonatomic, copy) NSString *totalRecord;

@property (nonatomic, strong) NSArray<ResultsActivity *> *results;

@property (nonatomic, copy) NSString *rescode;

@property (nonatomic, copy) NSString *totalPage;

@end
@interface ResultsActivity : NSObject

@property (nonatomic, copy) NSString *coverUrl;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *activityUrl;

@end

