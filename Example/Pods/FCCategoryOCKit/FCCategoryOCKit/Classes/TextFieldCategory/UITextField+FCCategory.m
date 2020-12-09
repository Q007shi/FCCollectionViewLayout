//
//  UITextField+FCCategory.m
//  FCCategoryOCKit
//
//  Created by 石富才 on 2020/2/24.
//

#import "UITextField+FCCategory.h"
#import <objc/runtime.h>

@implementation UITextField (FCCategory)

+ (void)load{
    //使用Xib，StoryBoard创建的UITextField
    Method  method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method  method2 = class_getInstanceMethod([self class], @selector(fc_initWithCoder:));
    
    //使用initWithFrame创建的UITextField
    Method method3 = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method method4 = class_getInstanceMethod([self class], @selector(fc_initWithFrame:));
    method_exchangeImplementations(method1, method2);
    method_exchangeImplementations(method3, method4);
}

- (instancetype)fc_initWithFrame:(CGRect)frame {
    [self fc_initWithFrame:frame];
    if (self) {
        //注册观察UITextField输入变化的方法。
        [self _addLengthObserverEvent];
    }
    return self;
}


- (instancetype)fc_initWithCoder:(NSCoder *)aDecoder {
    [self fc_initWithCoder:aDecoder];
    if (self) {
        [self _addLengthObserverEvent];
    }
    return self;
}

- (void)_addLengthObserverEvent{
    [self addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)valueChange:(UITextField *)textField{
    
    NSUInteger maxLength = self.fc_maxLength;
    if (maxLength == 0) {
        return;
    }
    
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position){
        
        if (toBeString.length > maxLength){
            
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1){
                
                textField.text = [toBeString substringToIndex:maxLength];
            }
            else{
                
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
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
