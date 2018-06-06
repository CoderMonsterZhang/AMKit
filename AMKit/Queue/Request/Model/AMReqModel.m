//
//  AMReqModel.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/21.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMReqModel.h"

@implementation AMReqModel

#pragma mark - 初始化方法

+ (id)requestTag:(NSInteger)tag target:(id)target requestMethod:(SEL)requestMethod requestCompleteMethod:(SEL)requestCompleteMethod
{
    AMReqModel *result = [[AMReqModel alloc] initWithTag:tag target:target requestMethod:requestMethod requestCompleteMethod:requestCompleteMethod];
    return result;
}

+ (AMReqModel *)requestTag:(NSInteger)tag requestBlock:(void (^)(AMReqModel *requestModel))requestBlock completeBlock:(void (^)(AMReqModel *requestModel))completeBlock
{
    AMReqModel *result = [[AMReqModel alloc] initWithTag:tag requestBlock:requestBlock completeBlock:completeBlock];
    return result;
}

- (id)initWithTag:(NSInteger)tag target:(id)target requestMethod:(SEL)requestMethod requestCompleteMethod:(SEL)requestCompleteMethod
{
    if (self = [super init]) {
        _tag = tag;
        _target = target;
        _requestMethod = requestMethod;
        _requestCompleteMethod = requestCompleteMethod;
    }
    return self;
}

- (id)initWithTag:(NSInteger)tag requestBlock:(void (^)(AMReqModel *))requestBlock completeBlock:(void (^)(AMReqModel *))completeBlock
{
    if (self = [super init]) {
        _tag = tag;
        _requestBlock = requestBlock;
        _requestCompleteBlock = completeBlock;
    }
    return self;
}

#pragma mark - 网络请求方法
- (void)executeRequestMethod
{
    if (self.target && self.requestMethod && [self.target respondsToSelector:self.requestMethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
        [self.target performSelector:self.requestMethod withObject:self];
#pragma clang diagnostic pop
    }
    else if (self.requestBlock) {
        self.requestBlock(self);
    }
}

- (void)executeRequestCompleteMethodWithSuccess:(BOOL)success data:(id)data
{
    _success = success;
    _data = data;
    
    if (self.target && self.requestCompleteMethod && [self.target respondsToSelector:self.requestCompleteMethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
        [self.target performSelector:self.requestCompleteMethod withObject:self];
#pragma clang diagnostic pop
    }
    else if (self.requestCompleteBlock) {
        self.requestCompleteBlock(self);
    }
}

@end
