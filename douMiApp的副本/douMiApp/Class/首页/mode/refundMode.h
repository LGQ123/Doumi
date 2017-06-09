//
//  refundMode.h
//  douMiApp
//
//  Created by ydz on 2017/1/14.
//  Copyright © 2017年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class overdueRepayments111;
@interface refundMode : NSObject

@property (copy,nonatomic) NSString *rescode;
@property (copy, nonatomic) NSString *resmsg;
@property (strong, nonatomic) NSArray <overdueRepayments111 *>*overdueRepayments;
@end
@interface overdueRepayments111 : NSObject
@property (copy,nonatomic) NSString *userId;
@property (copy,nonatomic) NSString *bId;
@property (copy,nonatomic) NSString *borrowTitle;
@property (assign,nonatomic) NSInteger overdueRevenue;
@property (assign,nonatomic) NSInteger overdueFine;
@property (copy,nonatomic) NSString *anchorName;
@property (assign,nonatomic) NSInteger principal;
@property (assign,nonatomic) NSInteger overdueSize;
@property (copy,nonatomic) NSString *borrowDate;
@property (assign,nonatomic) NSInteger borrowAmount;
@property (assign,nonatomic) NSInteger monthManage;





@end
