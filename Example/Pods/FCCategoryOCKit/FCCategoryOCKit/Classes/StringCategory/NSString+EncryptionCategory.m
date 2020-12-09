//
//  NSString+EncryptionCategory.m
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/12.
//

#import "NSString+EncryptionCategory.h"
#import <CommonCrypto/CommonDigest.h>
//
#import "NSString+BaseCategory.h"



//crypto ['krɪptəʊ]  密码
//encryption [ɪn'krɪpʃn] 加密
//digest  [daɪˈdʒest] 文摘
@implementation NSString (EncryptionCategory)

- (NSString *)fc_md5{
    if(self.fc_isEmpty) return nil;
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end
