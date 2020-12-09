//
//  TBTableViewSectionModel.m
//  TBBaseKit
//
//  Created by 石富才 on 2020/2/29.
//

#import "TBTableViewSectionModel.h"
#import <FCCategoryOCKit/FCCategoryOCKit.h>

@implementation TBTableViewSectionModel

//- (NSMutableArray<TBTableViewCellModel *> *)cells{
//    if (!_cells) {
//        _cells = NSMutableArray.array;
//    }
//    return _cells;
//}

- (NSMutableDictionary *)actions{
    if (!_actions) {
        _actions = NSMutableDictionary.dictionary;
    }
    return _actions;
}

@end

@implementation TBTableViewCellModel

- (TBTableViewLineModel *)lineModel{
    if (!_lineModel) {
        _lineModel = TBTableViewLineModel.new;
        _lineModel.backgroundColor = UIColor.whiteColor;
        _lineModel.lineColor = UIColor.whiteColor;
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

@implementation TBTableViewLineModel


@end



