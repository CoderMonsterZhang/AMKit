//
//  UIDevice+MasAdd.h
//  MasKitDemo
//
//  Created by 张松宇 on 2018/6/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (MasAdd)

/// Device system version (e.g. 8.1)
+ (double)systemVersion;

@end

#ifndef kSystemVersion
#define kSystemVersion [UIDevice systemVersion]
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

#ifndef kiOS10Later
#define kiOS10Later (kSystemVersion >= 10)
#endif

#ifndef kiOS11Later
#define kiOS11Later (kSystemVersion >= 11)
#endif

#ifndef kiOS12Later
#define kiOS12Later (kSystemVersion >= 12)
#endif
