//
//  NSArray+ChongRuntmie.m
//  51QuickMatch
//
//  Created by ZhengZheng Li on 2017/11/16.
//  Copyright © 2017年 Sunfairy. All rights reserved.
//

#import "NSArray+ChongRuntmie.h"

@implementation NSArray (ChongRuntmie)
+(void)load{
    //Method Swizzling
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //数组越界问题
        method_exchangeImplementations(class_getInstanceMethod(NSClassFromString(@"__NSSingleObjectArrayI"), @selector(objectAtIndex:)), class_getInstanceMethod(NSClassFromString(@"__NSSingleObjectArrayI"), @selector(_safeObjectAtIndex:)));
    });
}
-(instancetype)_safeObjectAtIndex:(NSInteger)index
{
    if (self.count < (index + 1)) {
        NSLog(@"Runtime Warning from %s index %li out of bound",__FUNCTION__,index);
        return nil;
    }
    return [self _safeObjectAtIndex:index];
}
@end
