//
//  NSObject+FCCategory.m
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/30.
//

#import "NSObject+FCCategory.h"
#import <objc/runtime.h>

@implementation NSObject (FCCategory)

/** 重写 Debug 情况下对对象的输出 */
//- (NSString *)debugDescription{
//    NSMutableDictionary *mDic = NSMutableDictionary.dictionary;
//    //
//    uint count;
//    objc_property_t *properties = class_copyPropertyList(self.class, &count);
//    for (int t = 0; t < count; t++) {
//        objc_property_t property = properties[t];
//        NSString *name = @(property_getName(property));
//        id value = [self valueForKey:name] ?: @"nil";//默认为 nil
//        [mDic setObject:value forKey:name];
//    }
//    return [NSString stringWithFormat:@"<%@: %p> -- %@",self.class,self,mDic];
//}

/** 判断当前对象是否是 nil 或 NSNull */
- (BOOL)fc_isNilOrNull{
    return (self == nil || [self isKindOfClass:NSNull.class]);
}

- (instancetype)init:(void (^)(id))block{
    id obj = [self init];
    if (block) {
        block(obj);
    }
    return obj;
}

@end
