//
//  UIDevice+MasAdd.m
//  MasKitDemo
//
//  Created by 张松宇 on 2018/6/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "UIDevice+MasAdd.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <mach/mach.h>
#include <arpa/inet.h>
#include <ifaddrs.h>

@implementation UIDevice (MasAdd)

+ (double)systemVersion {
    static double version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [UIDevice currentDevice].systemVersion.doubleValue;
    });
    return version;
}

@end
