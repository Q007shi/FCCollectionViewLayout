//
//  NSObject+FCCategory.h
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/30.
//

#import <Foundation/Foundation.h>

@interface NSObject (FCCategory)

#pragma mark - 属性
/** 判断当前对象是否是 nil 或 NSNull */
@property (nonatomic, assign, readonly) BOOL fc_isNilOrNull;

- (instancetype)init:(void(^)(id))block;

@end

