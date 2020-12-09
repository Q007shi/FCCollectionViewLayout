//
//  TBCollectionViewSectionModel.m
//  TBBaseKit
//
//  Created by 石富才 on 2020/2/29.
//

#import "TBCollectionViewSectionModel.h"

@implementation TBCollectionViewSectionModel

//- (NSMutableArray<TBCollectionViewItemModel *> *)items{
//    if (!_items) {
//        _items = NSMutableArray.array;
//    }
//    return _items;
//}

- (NSMutableDictionary *)actions{
    if (!_actions) {
        _actions = NSMutableDictionary.dictionary;
    }
    return _actions;
}

@end

@implementation TBCollectionViewItemModel

- (TBCollectionViewLineModel *)lineModel{
    if (!_lineModel) {
        _lineModel = TBCollectionViewLineModel.new;
        _lineModel.backgroundColor = UIColor.clearColor;
        _lineModel.lineColor = UIColor.clearColor;
        _lineModel.edgeInset = UIEdgeInsetsZero;
    }
    return _lineModel;
}

- (NSMutableDictionary *)actions{
    if (!_actions) {
        _actions = NSMutableDictionary.dictionary;
    }
    return _actions;
}

@end

@implementation TBCollectionViewLineModel

@end
