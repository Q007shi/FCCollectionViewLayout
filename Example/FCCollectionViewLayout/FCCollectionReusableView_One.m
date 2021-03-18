//
//  FCCollectionReusableView_One.m
//  FCCollectionViewLayout_Example
//
//  Created by 石富才 on 2020/12/7.
//  Copyright © 2020 2585299617@qq.com. All rights reserved.
//

#import "FCCollectionReusableView_One.h"
#import "FCCollectionViewLayoutAttributes.h"

@implementation FCCollectionReusableView_One

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.redColor;
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    if ([layoutAttributes isKindOfClass:FCCollectionViewLayoutAttributes.class]) {
        FCCollectionViewLayoutAttributes *customLayoutAttributes = (FCCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = customLayoutAttributes.backgroundColor;
    }
}

@end
