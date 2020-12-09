//
//  TBFGradientView.m
//  TBBaseKit
//
//  Created by 石富才 on 2020/2/19.
//

#import "TBFGradientView.h"

@implementation TBFGradientView

+ (Class)layerClass{
    return CAGradientLayer.class;
}

- (void)setGradient:(TBFGradientModel *)gradient{
    _gradient = gradient;
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    NSMutableArray<id> *colors = NSMutableArray.array;
    NSMutableArray<NSNumber *> *locations = NSMutableArray.array;
    layer.startPoint = gradient.startPoint;
    layer.endPoint = gradient.endPoint;
    for (TBFGradientContentModel *gradientContentM in gradient.gradientContents) {
        [colors addObject:(id)gradientContentM.color.CGColor];
        [locations addObject:@(gradientContentM.location)];
    }
    layer.colors = colors;
    layer.locations = locations;
}

@end

@implementation TBFGradientModel

@end

@implementation TBFGradientContentModel

@end

