//
//  MessageMode.h
//  douMiApp
//
//  Created by ydz on 2016/12/12.
//  Copyright © 2016年 lgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Messagelist;
@class MessageSystemListModel;
@class MessageSystemModel;
@class MessageZanListModel;
@class MessageZanModel;
@interface MessageModeA : NSObject

@property (nonatomic, copy) NSString *totalNum;

@property (nonatomic, copy) NSString *resmsg;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *rescode;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, strong) NSArray<Messagelist *> *results;
@property (nonatomic, strong) NSString *thumbUpMsgCount; // 点赞数
@property (nonatomic, assign) NSInteger pageNo; // 当前页面
@property (nonatomic, assign) NSInteger pageSize; // 每页显示条数
@property (nonatomic, strong) NSString *totalRecord;
@property (nonatomic, strong) NSString *sysMsgCount; // 系统消息数
@property (nonatomic, assign) NSInteger totalPage; // 一共的页数


@end
@interface Messagelist : NSObject

@property (nonatomic, assign) NSInteger Id; // commentId

@property (nonatomic, copy) NSString *content; // 内容

@property (nonatomic, copy) NSString *title; // 标题

@property (nonatomic, copy) NSString *pic; //

@property (nonatomic, copy) NSString *publishDate; // 时间

@property (nonatomic, assign) NSInteger isRead;
@property (nonatomic, assign) NSInteger dynType; // 1：个人动态2：话题动态
@property (nonatomic, assign) NSInteger status; // 0：动态不存在，1：动态存在评论都存在2：动态存在，评论不存在
@property (nonatomic, assign) NSInteger type; // 1系统 2赞我的 3我赞的 4动态（回复、打赏）
@property (nonatomic, strong) NSString *commentId; // 评论id
@property (nonatomic, strong) NSString *dynId; // 动态id
@property (nonatomic, strong) NSString *imgUrl; // 头像

@end



@interface MessageSystemListModel : NSObject

@property (nonatomic, strong) NSString *imgUrl; // 头像
@property (nonatomic, strong) NSString *totalNum; // list列表总数量
@property (nonatomic, strong) NSString *userId; // 用户id
@property (nonatomic, strong) NSArray *messageList; // MessageSystemModel
@property (nonatomic, strong) NSString *resmsg;
@property (nonatomic, strong) NSString *rescode;


@end


@interface MessageSystemModel : NSObject

@property (nonatomic, strong) NSString *msgId; // 消息id
@property (nonatomic, strong) NSString *title; // 标题
@property (nonatomic, strong) NSString *pic; // 图片
@property (nonatomic, strong) NSString *content1; // 内容1(第一行内容：例如账号：dsafg)
@property (nonatomic, strong) NSString *content2; // 内容2（页面展示有颜色.例如：商品详情）
@property (nonatomic, strong) NSString *publishDate; // 发布时间
@property (nonatomic, assign) BOOL isRead; // 是否已读
@property (nonatomic, assign) float cellHeight; // 缓存cell的高

@end


@interface MessageZanListModel : NSObject

@property (nonatomic, strong) NSArray *map; // MessageZanModel
@property (nonatomic, strong) NSString *resmsg;
@property (nonatomic, strong) NSString *rescode;

@end


@interface MessageZanModel : NSObject

@property (nonatomic, strong) NSString *msgId; // 消息id
@property (nonatomic, strong) NSString *title; // 消息title
@property (nonatomic, strong) NSString *dynId; // 动态（话题）id
@property (nonatomic, strong) NSString *createDate; // 点赞时间
@property (nonatomic, strong) NSString *dynType; // 1:个人动态 2:话题动态

@end

