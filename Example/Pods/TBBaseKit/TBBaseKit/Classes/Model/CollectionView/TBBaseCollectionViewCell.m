//
//  TBBaseCollectionViewCell.m
//  TBBaseKit
//
//  Created by 石富才 on 2020/10/27.
//

#import "TBBaseCollectionViewCell.h"
#import "TBCellUpdateProtocol.h"
#import "TBCollectionViewSectionModel.h"

@interface TBBaseCollectionViewCell (){
    TBCollectionViewItemModel *_itemM;
}

@end

@implementation TBBaseCollectionViewCell

- (void)setData:(TBCollectionViewItemModel *)data{
    _itemM = data;
}
- (TBCollectionViewItemModel *)data{
    return _itemM;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttribute{
    UICollectionViewLayoutAttributes *tempLayoutAttribute = [super preferredLayoutAttributesFittingAttributes:layoutAttribute];
    if (!self.data) { return tempLayoutAttribute; }
    //
    switch (self.data.sizeType) {
        case TBCollectionViewItemSizeTypeFixSize:{
            tempLayoutAttribute.size = self.data.itemSize;
        }break;
        case TBCollectionViewItemSizeTypeFixWidth:{
            // 新建一个宽度约束
            NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.data.itemSize.width];
            // 添加宽度约束
            [self.contentView addConstraint:widthFenceConstraint];
            // 获取约束后的size
            CGSize fittingSize = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            // 记得移除
            [self.contentView removeConstraint:widthFenceConstraint];
            self.data.itemSize = fittingSize;
            tempLayoutAttribute.size = self.data.itemSize;
        }break;
        case TBCollectionViewItemSizeTypeFixHeight:{
            // 新建一个宽度约束
            NSLayoutConstraint *heigntFenceConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.data.itemSize.height];
            // 添加宽度约束
            [self.contentView addConstraint:heigntFenceConstraint];
            // 获取约束后的size
            CGSize fittingSize = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            // 记得移除
            [self.contentView removeConstraint:heigntFenceConstraint];
            self.data.itemSize = fittingSize;
            tempLayoutAttribute.size = self.data.itemSize;
        }break;
        default:{}break;
    }
    return tempLayoutAttribute;
}

@synthesize data;

@end

