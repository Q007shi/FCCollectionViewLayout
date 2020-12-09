//
//  FCSectionModel.m
//  FCCollectionViewLayout_Example
//
//  Created by 石富才 on 2020/11/30.
//  Copyright © 2020 2585299617@qq.com. All rights reserved.
//

#import "FCSectionModel.h"

@implementation FCSectionModel

- (NSMutableArray<FCItemModel *> *)items{
    if (!_items) {
        _items = NSMutableArray.array;
    }
    return _items;
}

@end

@implementation FCItemModel

@end
