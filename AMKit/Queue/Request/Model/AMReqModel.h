//
//  AMReqModel.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/21.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//  网络请求模型，主要是为了调整网络请求的时间方法。

#import <Foundation/Foundation.h>

@interface AMReqModel : NSObject

@property (nonatomic, assign, readonly) NSInteger tag;

/// 请求是否成功
@property (nonatomic, assign, readonly) BOOL success;

/// 请求结果数据
@property (nonatomic, strong, readonly) id data;

/// target

@property (nonatomic, weak, readonly) id target;

/// Method，数据请求方法
@property (nonatomic, assign, readonly) SEL requestMethod;

/// Method，请求完成调用
@property (nonatomic, assign, readonly) SEL requestCompleteMethod;


/// block

@property (nonatomic, copy, readonly) void (^requestBlock)(AMReqModel *);

@property (nonatomic, copy, readonly) void (^requestCompleteBlock)(AMReqModel *);

#pragma mark - # 队列用
@property (nonatomic, weak) id queueTarget;

@property (nonatomic, assign) SEL queueMethod;

#pragma mark - # 公开方法
+ (AMReqModel *)requestTag:(NSInteger)tag target:(id)target requestMethod:(SEL)requestMethod requestCompleteMethod:(SEL)requestCompleteMethod;

+ (AMReqModel *)requestTag:(NSInteger)tag requestBlock:(void (^)(AMReqModel *requestModel))requestBlock completeBlock:(void (^)(AMReqModel *requestModel))completeBlock;

/**
 *  执行网络请求方法
 */
- (void)executeRequestMethod;

/**
 *  执行网络请求完成方法
 */
- (void)executeRequestCompleteMethodWithSuccess:(BOOL)success data:(id)data;

@end
