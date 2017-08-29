//
//  NSDictionary+ChongRuntime.m
//  TEST_RUNtime
//
//  Created by ZhengZheng Li on 2017/8/29.
//  Copyright © 2017年 ChongZhang. All rights reserved.
//

#import "NSDictionary+ChongRuntime.h"
#import <objc/runtime.h>
@implementation NSDictionary (ChongRuntime)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //字典赋值为nil 不Crash
        method_exchangeImplementations(class_getInstanceMethod(NSClassFromString(@"__NSPlaceholderDictionary"), @selector(initWithObjects:forKeys:count:)), class_getInstanceMethod(NSClassFromString(@"__NSPlaceholderDictionary"), @selector(_safeinitWithobject:forKey:count:)));
        
    });
}
- (instancetype)_safeinitWithobject:(const id  _Nonnull __unsafe_unretained *)objects forKey:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSInteger)count{
    
    id values  = nil;
    @try {
        values = [self _safeinitWithobject:objects forKey:keys count:count];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
        NSLog(@"warning from %s  we have to creat a new dic",__func__);
        id _Nonnull __unsafe_unretained objectsNew[count];
        id _Nonnull __unsafe_unretained keysNew[count];
        
        NSInteger index = 0;
        for (int a=0; a<count; a++) {
            
            if (objects[a]!=nil&&keys[a]!=nil) {
                
                objectsNew[index] = objects[a];
                keysNew[index] = keys[a];
                index++;
            }
        }
        values = [self _safeinitWithobject:objectsNew forKey:keysNew count:index];
        
    } @finally {
        return values;
    }
    
}
@end
