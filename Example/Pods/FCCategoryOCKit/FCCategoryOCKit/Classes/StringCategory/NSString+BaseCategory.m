//
//  NSString+BaseCategory.m
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/15.
//

#import "NSString+BaseCategory.h"
#import "NSObject+FCCategory.h"

@implementation NSString (BaseCategory)

#pragma mark - 属性
//是否为空，nil 或 NULL  或 "" 是返回 YES，否则为 NO
- (BOOL)fc_isEmpty{
    if (self.fc_isNilOrNull || ![self isKindOfClass:NSString.class] || self.length == 0) return YES;
    //
    return NO;
}

- (NSString *)fc_trimmingWhitespaceCharacter{
    if (self.fc_isEmpty) return @"";
    //
    return [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
}

- (NSString *)fc_whitespaceAndNewlineCharacter{
    if (self.fc_isEmpty) return @"";
    //
    return [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

- (NSArray *)fc_toArray{
    NSMutableArray *arr = NSMutableArray.array;
    if (!self.fc_isEmpty) {
        for (int t = 0; t < self.length; t++) {
            [arr addObject:[self substringWithRange:NSMakeRange(t, 1)]];
        }
    }
    
    return arr;
}

#pragma mark - 方法

/** 剔除指定字符串，如果为 nil 就返回 nil */
- (instancetype)fc_trimmingCustomCharacter:(NSString *)trimmingString{
    if (self.fc_isEmpty) return @"";
    if (trimmingString.fc_isEmpty) return self;
    //
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:trimmingString]];
}

@end
