//
//  NSMutableArray+ChongRuntime.h
//  51QuickMatch
//
//  Created by ZhengZheng Li on 2017/8/25.
//  Copyright © 2017年 Sunfairy. All rights reserved.
//

#import "NSNull+Exception.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSNull (Exception)



+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("NSNull") swizzleMethod:@selector(length) swizzledSelector:@selector(replace_length)];
        }
    });
}
- (NSInteger)replace_length {
    return 0;
}
@end
