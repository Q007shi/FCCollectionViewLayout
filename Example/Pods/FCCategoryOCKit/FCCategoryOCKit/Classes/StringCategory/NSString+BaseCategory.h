//
//  NSString+BaseCategory.h
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/15.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSUInteger,FCCharacterSetType){
//    FCCharacterSetTypeWhitespace = 1,//空格
//    FCCharacterSetTypeControlCharacters = 1 << 1,//控制符
//    FCCharacterSetTypeNewlines = 1 << 2,//换行符
//    FCCharacterSetTypeDecimalDigits = 1 << 3,//小数点
//    FCCharacterSetTypeLetters = 1 << 4,//英文字母
//    FCCharacterSetTypeLowercaseLetters = 1 << 5,//小写字母
//    FCCharacterSetTypeUppercaseLetters = 1 << 6,//大写字母
//};

@interface NSString (BaseCategory)

#pragma mark - 属性

/** 是否为空，nil 或 NULL  或 "" 是返回 YES，否则为 NO */
@property (nonatomic, assign, readonly) BOOL fc_isEmpty;
/** 剔除字符串收尾空格，如果为 nil 就返回 nil  */
@property(nonatomic,copy, readonly)NSString * _Nullable fc_trimmingWhitespaceCharacter;
/** 剔除字符串收尾空格和换行符，如果为 nil 就返回 nil  */
@property(nonatomic,copy, readonly)NSString * _Nullable fc_whitespaceAndNewlineCharacter;

/** 字符串转数组  “ABC” -> ["a","b","c"]*/
@property(nonatomic,strong, readonly)NSArray * _Nullable fc_toArray;

#pragma mark - 方法

/** 剔除指定字符串，如果为 nil 就返回 nil */
- (instancetype _Nullable)fc_trimmingCustomCharacter:(nonnull NSString *)trimmingString;

@end

