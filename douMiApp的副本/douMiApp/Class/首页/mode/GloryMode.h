//
//  GloryMode.h
//  douMiApp
//
//  Created by ydz on 2016/11/21.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class List;

@interface GloryMode : NSObject

@property (nonatomic, copy) NSString *rescode;
@property (nonatomic, copy) NSString *resmsg;
@property (copy, nonatomic) NSString *userId;
@property (strong, nonatomic) NSArray <List *>*results;

@end

@interface List : NSObject

@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *imgUrl;
@property (copy, nonatomic) NSString *amounts;
@property (copy, nonatomic) NSString *userId;
@end
