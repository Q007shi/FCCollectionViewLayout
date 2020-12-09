//
//  TBFShapeView.m
//  TBBaseKit
//
//  Created by 石富才 on 2020/2/19.
//

#import "TBFShapeView.h"

@implementation TBFShapeView

+ (Class)layerClass{
    return CAShapeLayer.class;
}

- (void)roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii fillColor:(UIColor *)fillColor{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = fillColor.CGColor;
}

@end
