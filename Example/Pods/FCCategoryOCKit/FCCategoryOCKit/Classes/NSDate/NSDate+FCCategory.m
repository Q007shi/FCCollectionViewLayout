//
//  NSDate+FCCategory.m
//  FCCategoryOCKit
//
//  Created by 石富才 on 2020/3/4.
//

#import "NSDate+FCCategory.h"

@implementation NSDate (FCCategory)

/**
 将当前时间转换为指定格式的字符串
 */
- (NSString *)fc_stringWithFormat:(NSString *)Format{
    if (self && Format && [Format isKindOfClass:NSString.class]) {
        NSDateFormatter *dateFormat = NSDateFormatter.new;
        [dateFormat setDateFormat:Format];
        NSString *str = [dateFormat stringFromDate:self];
        return str ? str : @"";
    }
    return @"";
}

/**
 将 dateString 根据 format 格式转换为 Date
 */
+ (NSDate *)fc_dateWithDateString:(NSString *)dateString format:(NSString *)format{
    if (dateString && format) {
        NSDateFormatter *dateFormat = NSDateFormatter.new;
        [dateFormat setDateFormat:format];
        return [dateFormat dateFromString:dateString];
    }
    
    return nil;
}

@end
