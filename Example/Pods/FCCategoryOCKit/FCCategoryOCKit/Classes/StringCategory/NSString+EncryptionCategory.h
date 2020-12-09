//
//  NSString+EncryptionCategory.h
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/12.
//

#import <Foundation/Foundation.h>


/**
 字符串加密。encryption [ɪn'krɪpʃn] 加密
 */
@interface NSString (EncryptionCategory)

/**
对当前字符串进行 MD5 加密

@return MD5 加密后字符串，如果当前字符串为 nil,返回 nil.
*/
@property(nonatomic,copy, readonly)NSString *fc_md5;



@end

