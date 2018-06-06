//
//  AMRequestQueue.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/21.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMReqModel.h"

@interface AMRequestQueue : NSObject

/// 是否正在请求中
@property (nonatomic, assign, readonly) BOOL isReques;

/// 请求队列元素个数
@property (nonatomic, assign, readonly) NSInteger requestCount;

- (void)addReqModel:(AMReqModel *)model;

- (void)allRequestsWithCompleteAction:(void (^)(NSArray *data, NSInteger successCount, NSInteger failureCount))completeAction;

- (void)cancelAllRequests;

@end
