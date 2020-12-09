//
//  UITextView+FCCategory.m
//  FCCategoryOCKit
//
//  Created by 石富才 on 2020/2/24.
//

#import "UITextView+FCCategory.h"
#import <objc/runtime.h>

@implementation UITextView (FCCategory)

+ (void)load{
    //使用Xib，StoryBoard创建的UITextField
    Method  method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method  method2 = class_getInstanceMethod([self class], @selector(fc_initWithCoder:));
    
    //使用initWithFrame创建的UITextField
    Method method3 = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method method4 = class_getInstanceMethod([self class], @selector(fc_initWithFrame:));
    
    //销毁
    Method method5 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method6 = class_getInstanceMethod([self class], @selector(fc_dealloc));
    method_exchangeImplementations(method1, method2);
    method_exchangeImplementations(method3, method4);
    method_exchangeImplementations(method5, method6);
}

- (void)fc_dealloc{
    [self fc_dealloc];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (instancetype)fc_initWithCoder:(CGRect)frame {
    [self fc_initWithCoder:frame];
    if (self) {
        //注册观察UITextField输入变化的方法。
        [self _addLengthObserverEvent];
    }
    return self;
}


- (instancetype)fc_initWithFrame:(NSCoder *)aDecoder {
    [self fc_initWithFrame:aDecoder];
    if (self) {
        [self _addLengthObserverEvent];
    }
    return self;
}

- (void)_addLengthObserverEvent{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textViewDidChangeText) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)_textViewDidChangeText{
    NSUInteger maxLength = self.fc_maxLength;
    if (maxLength == 0) {
        return;
    }
    
    NSString *toBeString = self.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position){
        
        if (toBeString.length > maxLength){
            
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1){
                
                self.text = [toBeString substringToIndex:maxLength];
            }
            else{
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                self.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

- (void)setFc_maxLength:(NSUInteger)fc_maxLength{
    //OC 中 _cmd 表示 当前方法的selector
    objc_setAssociatedObject(self, @selector(fc_maxLength), @(fc_maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSUInteger)fc_maxLength{
    NSNumber *num = objc_getAssociatedObject(self, _cmd);
    if (num) {
        return num.unsignedIntegerValue;
    }
    return 0;
}

@end
