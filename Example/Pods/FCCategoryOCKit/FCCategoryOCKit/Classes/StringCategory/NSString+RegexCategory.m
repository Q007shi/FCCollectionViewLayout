//
//  NSString+RegexCategory.m
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/15.
//

#import "NSString+RegexCategory.h"
#import "NSString+BaseCategory.h"
#import "NSObject+FCCategory.h"

@implementation NSString (RegexCategory)

//根据正则表达式字符串 regex 将字符串分割，并将分割结果返回
- (NSArray<NSTextCheckingResult *> *)fc_trimSourceStringWithRegex:(NSString *)regex{
    
    if (self.fc_isEmpty || regex.fc_isEmpty) return nil;
    
    //
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        return nil;
    }
    return [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
}

//对当前字符，根据正则表达式 regex 进行匹配
- (BOOL)fc_matchesWithRegex:(nonnull NSString *)regex{
    if (self.fc_isEmpty || regex.fc_isEmpty) {
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

@end
