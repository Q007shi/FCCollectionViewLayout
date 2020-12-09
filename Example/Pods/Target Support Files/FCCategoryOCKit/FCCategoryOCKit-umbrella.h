#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UIButton+FCCategory.h"
#import "UIColor+TransformCategory.h"
#import "FCCategoryOCKit.h"
#import "NSDate+FCCategory.h"
#import "NSObject+FCCategory.h"
#import "FCStringCategoryHeader.h"
#import "NSString+BaseCategory.h"
#import "NSString+EncryptionCategory.h"
#import "NSString+RegexCategory.h"
#import "UITextField+FCCategory.h"
#import "UITextView+FCCategory.h"
#import "FCGradientModel.h"
#import "FCImageCategoryHeader.h"
#import "UIImage+FCCategory.h"
#import "UIImage+FCGradientImage.h"
#import "UIView+FrameCategory.h"

FOUNDATION_EXPORT double FCCategoryOCKitVersionNumber;
FOUNDATION_EXPORT const unsigned char FCCategoryOCKitVersionString[];

