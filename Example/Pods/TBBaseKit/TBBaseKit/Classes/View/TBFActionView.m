//
//  TBFActionView.m
//  TBBaseKit
//
//  Created by 石富才 on 2020/2/27.
//

#import "TBFActionView.h"
#import <Masonry/Masonry.h>

@interface TBFActionView ()


@end

@interface TBFActionViewModel ()

/** <#aaa#> */
@property(nonatomic,strong)UIButton *btn;

@end

@implementation TBFActionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if ([self.delegate respondsToSelector:@selector(actionView:)]) {
        NSArray *titles = [self.delegate actionView:self];
        
        UIButton *lastBtn = nil;
        CGFloat allW = 0;
        for (NSInteger t = titles.count-1; t >= 0; t--) {
            TBFActionViewModel *m = titles[t];
            [m.btn setContentEdgeInsets:UIEdgeInsetsMake(0, self.bounds.size.height*0.5, 0, self.bounds.size.height*0.5)];
            CGSize size = [m.btn sizeThatFits:CGSizeMake(200, self.bounds.size.height)];
            
            CGFloat x = 0;
            if (lastBtn) {
                x = self.bounds.size.width - size.width - m.lineSpace - (self.bounds.size.width - lastBtn.frame.origin.x);
                lastBtn = m.btn;
                allW += size.width + m.lineSpace;
            }else{
                x = self.bounds.size.width - size.width;
                lastBtn = m.btn;
                allW += size.width;
            }
            
            m.btn.frame = CGRectMake(x, 0, size.width, self.bounds.size.height);
            if (m.cornerRadius < 0 || m.cornerRadius > self.bounds.size.height * 0.5) {
                m.btn.layer.cornerRadius = self.bounds.size.height * 0.5;
            }else{
                m.btn.layer.cornerRadius = m.cornerRadius;
            }
            
            m.btn.layer.borderWidth = 0.5;
            if (m.borderColor) {
                m.btn.layer.borderColor = m.borderColor.CGColor;
            }else{
                m.btn.layer.borderColor = UIColor.clearColor.CGColor;
            }
            if (m.backgroundColor) {
                m.btn.backgroundColor = m.backgroundColor;
            }else{
                m.backgroundColor = UIColor.clearColor;
            }
            m.btn.layer.masksToBounds = YES;
            
        }
        if (lastBtn) {
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(allW)).priority(1000);
            }];
        }
    }
    
}

- (void)reloadData{
    if ([self.delegate respondsToSelector:@selector(actionView:)]) {
        
        if (self.subviews.count > 0) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        
        NSArray *titles = [self.delegate actionView:self];
        for (NSInteger t = titles.count-1; t >= 0; t--) {
            TBFActionViewModel *m = titles[t];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            m.btn = btn;
            NSAttributedString *attri = [[NSAttributedString alloc]initWithString:@"-"];
            if (m.titleAttri) {
                attri = m.titleAttri;
            }
            [btn setAttributedTitle:attri forState:UIControlStateNormal];
            [btn setAttributedTitle:attri forState:UIControlStateNormal | UIControlStateHighlighted];
            btn.tag = 100 + t;
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

- (void)buttonAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(actionView:didSelectedIndex:)]) {
        [self.delegate actionView:self didSelectedIndex:btn.tag - 100];
    }
}

@end

@implementation TBFActionViewModel


@end
