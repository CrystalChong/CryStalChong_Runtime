//
//  NSMutableArray+ChongRuntime.m
//  51QuickMatch
//
//  Created by ZhengZheng Li on 2017/8/25.
//  Copyright © 2017年 ChongZhang. All rights reserved.
//

#import "NSMutableArray+ChongRuntime.h"
#import <objc/runtime.h>

@implementation NSMutableArray (ChongRuntime)
+(void)load{
    //Method Swizzling
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //数组越界问题
        
        Method method1 = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:));
        Method method2 = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(_safeObjectAtIndex:));
        method_exchangeImplementations(method1, method2);
        
       // class_getClassMethod
         */
        method_exchangeImplementations(class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:)), class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(_safeObjectAtIndex:)));
        
        //添加空元素;
        method_exchangeImplementations(class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:)), class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(_safeAddObject:)));
        
        //删除越界问题
        method_exchangeImplementations(class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObjectAtIndex:)), class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(_safeRemoveObjectAtIndex:)));
        
        //删除空元素
        method_exchangeImplementations(class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObject:)), class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(_safeRemoveObjec:)));
        
    });
    
    
    
    Method method1 = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:));
    Method method2 = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(_safeObjectAtIndex:));
    method_exchangeImplementations(method1, method2);
}
/*
 //%li 长整型   ==%ld   %i = %d   整形;
//交换方法;
- (void)_swizzlingMethod:(SEL)method withSafeSwizzling:(SEL)safeMethod withClass:(Class)class{
    
    Method method1 = class_getInstanceMethod(class,method);
    Method method2 = class_getInstanceMethod(class, safeMethod);
    method_exchangeImplementations(method1, method2);
}
*/
#pragma mark - 数组的安全处理(先写几个常见的现象,以后再更新)
//数组越界
-(instancetype)_safeObjectAtIndex:(NSInteger)index
{
    if (self.count < (index + 1)) {
        NSLog(@"Runtime Warning from %s index %li out of bound",__FUNCTION__,index);
        return nil;
    }
    return [self _safeObjectAtIndex:index];
}
//添加空元素
- (void)_safeAddObject:(id)object{
    if (object == nil) {
        NSLog(@"Warning from %s  can't add nil object into NSMutableArray", __FUNCTION__);
    } else {
        [self _safeAddObject:object];
    }
}
//移除元素越界
- (void)_safeRemoveObjectAtIndex:(NSInteger)index{
    
    if (self.count<index) {
        NSLog(@"Warning from %s:sorry can't Remove object at index, beyond the scope",__func__);
    }else{
        [self _safeRemoveObjectAtIndex:index];
    }
    
}
//移除空对象
- (void)_safeRemoveObjec:(id)obj{
    if (obj==nil) {
        NSLog(@"Warning from %s:sorry can't remove nil objec for NsmuatbleArray",__FUNCTION__);
    }else{
        [self _safeRemoveObjec:obj];
    }
}








@end
