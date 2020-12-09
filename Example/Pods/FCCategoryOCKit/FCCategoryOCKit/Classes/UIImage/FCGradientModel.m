//
//  FCGradientModel.m
//  FCCategoryOCKit
//
//  Created by 石富才 on 2020/3/7.
//

#import "FCGradientModel.h"

@implementation FCGradientModel

- (NSMutableArray<FCGradientContentModel *> *)gradientContents{
    if (!_gradientContents) {
        _gradientContents = NSMutableArray.array;
    }
    return _gradientContents;
}

@end

@implementation FCGradientContentModel

@end
