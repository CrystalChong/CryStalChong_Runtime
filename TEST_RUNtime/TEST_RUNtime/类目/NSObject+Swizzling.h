//
//  NSMutableArray+ChongRuntime.h
//  51QuickMatch
//
//  Created by ZhengZheng Li on 2017/8/25.
//  Copyright © 2017年 Sunfairy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
