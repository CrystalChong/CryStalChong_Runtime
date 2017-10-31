//
//  NSMutableDictionary+ChongRuntime.m
//  TEST_RUNtime
//
//  Created by ZhengZheng Li on 2017/8/29.
//  Copyright © 2017年 ChongZhang. All rights reserved.
//

#import "NSMutableDictionary+ChongRuntime.h"
#import <objc/runtime.h>
@implementation NSMutableDictionary (ChongRuntime)
+(void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(em_setObject:forKey:));
        method_exchangeImplementations(fromMethod, toMethod);

    });

}
- (void)em_setObject:(id)emObject forKey:(NSString *)key {
    if (emObject == nil) {
        @try {
            [self em_setObject:emObject forKey:key];
        }
        @catch (NSException *exception) {
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            emObject = [NSString stringWithFormat:@""];
            [self em_setObject:emObject forKey:key];
        }
        @finally {}
    }else {
        [self em_setObject:emObject forKey:key];
    }
}

@end
