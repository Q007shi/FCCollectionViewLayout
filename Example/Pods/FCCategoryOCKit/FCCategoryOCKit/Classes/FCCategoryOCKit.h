//
//  FCCategoryOCKit.h
//  FCCategoryOCKit
//
//  Created by 石富才 on 2020/2/16.
//

#ifndef FCCategoryOCKit_h
#define FCCategoryOCKit_h

//---
#define fc_attriAttachment(attachment) [NSAttributedString attributedStringWithAttachment:attachment]
#define fc_mAttriAttachment(attachment) [[NSMutableAttributedString alloc]initWithAttributedString:fc_attriAttachment(attachment)]
//---
#define fc_attri(str, color, fontSize) [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}]
#define fc_attriStyle(str, color, fontSize, style) [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : [UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName : style}]
#define fc_attriBold(str, color, fontSize) [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize]}]
#define fc_attriUnderLine(str, color, fontSize) [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont systemFontOfSize:fontSize],NSUnderlineStyleAttributeName : @1}]
#define fc_attriStrikethrough(str, color, fontSize) [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont systemFontOfSize:fontSize],NSStrikethroughStyleAttributeName : @1}]

//---
#define fc_mAttri(str, color, fontSize) [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}]
#define fc_mAttriUnderLine(str, color, fontSize) [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont systemFontOfSize:fontSize],NSUnderlineStyleAttributeName : @1}]

#define fc_mAttriStrikethrough(str, color, fontSize) [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont systemFontOfSize:fontSize],NSStrikethroughStyleAttributeName : @1}]

//------
#define fc_mAttriBold(str, color, fontSize) [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize]}]

#define fc_mAttriBoldUnderLine(str, color, fontSize) [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize],NSUnderlineStyleAttributeName : @1}]

#define fc_mAttriBoldStrikethrough(str, color, fontSize) [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize],NSStrikethroughStyleAttributeName : @1}]

#define FCWeakSelf(type)  __weak typeof(type) weak##type = type

/**
 *  属性转字符串
 */
#define FCKeyPath(obj, key) @(((void)obj.key, #key))


//是否是空对象
#define FCIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)


#import "NSObject+FCCategory.h"
#import "UIView+FrameCategory.h"
#import "UIButton+FCCategory.h"
#import "UIColor+TransformCategory.h"
#import "UITextField+FCCategory.h"
#import "UITextView+FCCategory.h"
#import "NSDate+FCCategory.h"

//NSString
#import "FCStringCategoryHeader.h"
//UIImage
#import "FCImageCategoryHeader.h"

#endif /* FCCategoryOCKit_h */
