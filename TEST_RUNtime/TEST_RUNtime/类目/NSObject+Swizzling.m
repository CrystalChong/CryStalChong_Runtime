//
//  NSMutableArray+ChongRuntime.h
//  51QuickMatch
//
//  Created by ZhengZheng Li on 2017/8/25.
//  Copyright © 2017年 Sunfairy. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)swizzleMethod:(SEL)originMethod swizzledSelector:(SEL)swizzMethod {
    Class class = [self class];
    //使用Method的必备过程就是拿到想要交换的两个方法;
    Method originalMethod = class_getInstanceMethod(class, originMethod);
    Method swizzledMethod = class_getInstanceMethod(class, swizzMethod);

    BOOL ifHave = class_addMethod(class,originMethod,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    //如果object有此方法则添加不会成功,添加不成功直接进行交换即可,成功了,说明此objec没有此方法;不进行交换;
    if (ifHave) {
        class_replaceMethod(class,swizzMethod,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
