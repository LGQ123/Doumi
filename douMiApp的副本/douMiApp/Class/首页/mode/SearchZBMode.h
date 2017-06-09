//
//  SearchZBMode.h
//  douMiApp
//
//  Created by ydz on 2016/11/29.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchZBResults;
@interface SearchZBMode : NSObject

@property (nonatomic, copy) NSString *pageNo;

@property (nonatomic, copy) NSString *pageSize;

@property (nonatomic, copy) NSString *resmsg;

@property (nonatomic, copy) NSString *totalRecord;

@property (nonatomic, strong) NSArray<SearchZBResults *> *results;

@property (nonatomic, copy) NSString *rescode;

@property (nonatomic, copy) NSString *totalPage;

@end
@interface SearchZBResults : NSObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, copy) NSString *imgUrl;

@end

