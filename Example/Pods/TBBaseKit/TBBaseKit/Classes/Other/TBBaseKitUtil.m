//
//  TBBaseKitUtil.m
//  TBBaseKit
//
//  Created by 石富才 on 2020/3/6.
//

#import "TBBaseKitUtil.h"
#import "TBBaseKitHeader.h"

#define K_souce_bundle [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"TBBaseKit" ofType:@"bundle"]]
#define K_source_img(imgName) [UIImage imageNamed:imgName inBundle:K_souce_bundle compatibleWithTraitCollection:nil]

@implementation TBBaseKitUtil

+ (UIImage *)navigationBarBackArrow{
    return K_source_img(@"backArrow");
}

@end
