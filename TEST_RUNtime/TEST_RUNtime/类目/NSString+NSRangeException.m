//
//  NSMutableArray+ChongRuntime.h
//  51QuickMatch
//
//  Created by ZhengZheng Li on 2017/8/25.
//  Copyright © 2017年 Sunfairy. All rights reserved.
//

#import "NSString+NSRangeException.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSString (NSRangeException)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSCFConstantString") swizzleMethod:@selector(substringToIndex:) swizzledSelector:@selector(replace_substringToIndex:)];
            [objc_getClass("__NSCFConstantString") swizzleMethod:@selector(objectForKeyedSubscript:) swizzledSelector:@selector(replace_objectForKeyedSubscript:)];
        }
    });
}

- (NSString *)replace_substringToIndex:(NSUInteger)to {
    if (to > self.length) {
        return nil;
    }
    
    return [self replace_substringToIndex:to];
}

- (id)replace_objectForKeyedSubscript:(NSString *)key {
    return nil;
}

@end
