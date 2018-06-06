//
//  NSString+AMAdd.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/7.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AMAdd)

- (NSString * (^)(NSString *))create;
- (NSString * (^)(NSString *))append;
- (NSString * (^)(void))clear;

/**
 Trim blank characters (space and newline) in head and tail.
 @return the trimmed string.
 */
- (NSString *)stringByTrim;

- (NSString *)pinyin;
- (NSString *)pinyinInitial;

@end
