//
//  NSString+RegexCategory.h
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/15.
//

#import <Foundation/Foundation.h>

@interface NSString (RegexCategory)

/**
 根据正则表达式字符串 regex 将字符串分割，并将分割结果返回
 @param regex 正则表达式字符串
 @return 截取结果，如果异常返回 nil
 */
-(NSArray<NSTextCheckingResult *> *_Nullable)fc_trimSourceStringWithRegex:(nonnull NSString *)regex;


/**
 对当前字符，根据正则表达式 regex 进行匹配
 
 @param regex 正则表达式
 @return 匹配结果
 */
- (BOOL)fc_matchesWithRegex:(nonnull NSString *)regex;

@end

