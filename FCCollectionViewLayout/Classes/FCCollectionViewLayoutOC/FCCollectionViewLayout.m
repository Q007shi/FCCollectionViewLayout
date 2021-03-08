//
//  FCCollectionViewLayout.m
//  FCCollectionViewLayout
//
//  Created by 石富才 on 2020/8/17.
//

#import "FCCollectionViewLayout.h"
#import <math.h>

/** 记录该组中 items 的布局方向的 KEY */
#define k_Layout_Direction(section) [NSString stringWithFormat:@"k_Layout_Direction_%@",@(section)]
/** 保存 indexPath 处的 item 的 Frame 的 KEY */
#define k_CacheItem(indexPath) [NSString stringWithFormat:@"k_CacheItem_%@_%@",@(indexPath.section),@(indexPath.item)]

/** SupplementaryView 的 frame 的 KEY  */
#define k_Section_SupplementaryView_Frame(kind,section) [NSString stringWithFormat:@"k_Section_%@_Frame_%@",kind,@(section)]

/** 装饰视图 */
#define k_Section_DecorationMsgs(section) [NSString stringWithFormat:@"k_Section_DecorationMsgs_%@",@(section)]
/** 装饰视图原 Frame */
#define k_Section_DecorationViewFrame( section ) [NSString stringWithFormat:@"k_Section_DecorationViewFrame_%@",@(section)]

@interface FCCollectionViewDecorationViewMessageModel ()

/** zIndex用于设置front-to-back层级；值越大，优先布局在上层；cell的zIndex为0  */
@property(nonatomic, strong)UICollectionViewLayoutAttributes *decorationViewLayoutAttributes;


/** 组  */
@property(nonatomic, assign)NSInteger section;


@end
//** 装饰视图信息 **/
@implementation FCCollectionViewDecorationViewMessageModel

- (UICollectionViewLayoutAttributes *)decorationViewLayoutAttributes{
    if (!_decorationViewLayoutAttributes) {
        if (self.reuseIdentifier && [self.reuseIdentifier isKindOfClass:NSString.class] && self.reuseIdentifier.length > 0) {
            if (self.customLayoutAttributesClass) {
                _decorationViewLayoutAttributes = [self.customLayoutAttributesClass layoutAttributesForDecorationViewOfKind:self.reuseIdentifier withIndexPath:[NSIndexPath indexPathForItem:0 inSection:self.section]];
                _decorationViewLayoutAttributes.zIndex = self.zIndex;
                if ([self.customParams isKindOfClass:NSDictionary.class]) {
                    for (id key in self.customParams.allKeys) {
                        [_decorationViewLayoutAttributes setValue:self.customParams[key] forKey:key];
                    }
                }
            }else{
                _decorationViewLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:self.reuseIdentifier withIndexPath:[NSIndexPath indexPathForItem:0 inSection:self.section]];
                _decorationViewLayoutAttributes.zIndex = self.zIndex;
            }
        }
    }
    return _decorationViewLayoutAttributes;
}

@end

@interface FCCollectionViewLayout ()

/** 缓冲Frame  */
@property(nonatomic, strong)NSMutableDictionary *cachedItemFrame;

/** sectionSpace 造成的内容偏移  */
@property(nonatomic, strong)NSNumber *sectionSpaceOffsetY;
/** FCCollectionViewItemsLayoutTypeWaterFlow 流水布局造成的内容偏移  */
@property(nonatomic, strong)NSNumber *waterFlowOffsetY;

@end

//MARK: 属性分类
@implementation FCCollectionViewLayout (Attributes)

/** 与滚动方向水平的 item 之间的间距 */
- (CGFloat)fc_minimumInteritemSpacingAtIndex:(NSInteger)section{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delegate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    }
    return self.minimumInteritemSpacing;
}
/** 与滚动方向垂直的 item 之间的间距 */
- (CGFloat)fc_minimumLineSpacingAtIndex:(NSInteger)section{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delegate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    }
    return self.minimumLineSpacing;
}
/** 组边距缩进 */
- (UIEdgeInsets)fc_insetForSectionAtIndex:(NSInteger)section{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delegate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    return self.sectionInset;
}

/** ---------------------------- 自定义属性 --------------------------- */
/** 水平对齐方式  */
- (FCCollectionViewItemsHorizontalAlignment)fc_itemsHorizontalAlignmentAtIndex:(NSInteger)section{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:itemsHorizontalAlignmentAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delegate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self itemsHorizontalAlignmentAtIndex:section];
    }
    return self.itemsHorizontalAlignment;
}
/** 竖直对齐方式 */
- (FCCollectionViewItemsVerticalAlignment)fc_itemsVerticalAlignmentAtIndex:(NSInteger)section{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:itemsVerticalAlignmentAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delegate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self itemsVerticalAlignmentAtIndex:section];
    }
    return self.itemsVerticalAlignment;
}

/**
 items 的流动方向
 */
- (FCCollectionViewItemsFlowDirection)fc_itemsFlowDirectionAtIndex:(NSInteger)section{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:itemsFlowDirectionAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delegate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self itemsFlowDirectionAtIndex:section];
    }
    return self.itemsFlowDirection;
}
/** section 之间的间距  */
- (CGFloat)fc_sectionSpaceAtIndex:(NSInteger)section{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sectionSpaceAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delegate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self sectionSpaceAtIndex:section];
    }
    return self.sectionSpace;
}

/**
 items 的布局方式
 */
- (FCCollectionViewItemsLayoutType)fc_itemsLayoutTypeAtIndex:(NSInteger)section{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:itemsLayoutTypeAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delagate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delagate collectionView:self.collectionView layout:self itemsLayoutTypeAtIndex:section];
    }
    return self.itemsLayoutType;
}

@end

//MARK: 同一行 item 处理
@implementation FCCollectionViewLayout (Line)

/** 是否是一行的第一个 cell  */
- (BOOL)fc_isLineStartCellAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) return YES;
    UICollectionViewLayoutAttributes *currentLayoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *previousLayoutAttributes = [super layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section]];
    UIEdgeInsets insets = [self fc_insetForSectionAtIndex:indexPath.section];
    CGRect currentLineFrame = CGRectMake(insets.left, CGRectGetMinY(currentLayoutAttributes.frame), CGRectGetWidth(self.collectionView.frame) - insets.left - insets.right, CGRectGetHeight(currentLayoutAttributes.frame));
    CGRect previousLineFrame = CGRectMake(insets.left, CGRectGetMinY(previousLayoutAttributes.frame), CGRectGetWidth(self.collectionView.frame) - insets.left - insets.right, CGRectGetHeight(previousLayoutAttributes.frame));
    return !CGRectIntersectsRect(currentLineFrame, previousLineFrame);
}

/**  判断当前 Cell 与上一个 Cell 是否在同一水平线上 */
- (BOOL)fc_isLinePreviousCellAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) return NO;
    UICollectionViewLayoutAttributes *currentLayoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *previousLayoutAttributes = [super layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section]];
    UIEdgeInsets insets = [self fc_insetForSectionAtIndex:indexPath.section];
    CGRect currentLineFrame = CGRectMake(insets.left, CGRectGetMinY(currentLayoutAttributes.frame), CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(currentLayoutAttributes.frame));
    CGRect previousLineFrame = CGRectMake(insets.left, CGRectGetMinY(previousLayoutAttributes.frame), CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(previousLayoutAttributes.frame));
    return CGRectIntersectsRect(currentLineFrame, previousLineFrame);
}

/** 判断当前 Cell 与下一个Cell是否在同一行 */
- (BOOL)fc_isLineNextCellAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger num = [self.collectionView numberOfItemsInSection:indexPath.section];
    if (indexPath.item == num-1) return NO;
    UIEdgeInsets insets = [self fc_insetForSectionAtIndex:indexPath.section];
    UICollectionViewLayoutAttributes *currentLayoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *nextLayoutAttributes = [super layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item+1 inSection:indexPath.section]];
    CGRect currentLineFrame = CGRectMake(insets.left, CGRectGetMinY(currentLayoutAttributes.frame), CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(currentLayoutAttributes.frame));
    CGRect nextLineFrame = CGRectMake(insets.left, CGRectGetMinY(nextLayoutAttributes.frame), CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(nextLayoutAttributes.frame));
    return CGRectIntersectsRect(currentLineFrame, nextLineFrame);
}

/** 获取当前 Cell 所在行的所有 Cell 布局 */
- (NSArray<UICollectionViewLayoutAttributes *> *)fc_lineAttributes:(NSIndexPath *)indexPath{
    NSMutableArray *mArr = NSMutableArray.array;
    //向上查询
    NSInteger previousIndex = indexPath.item;
    while (previousIndex > 0) {
        --previousIndex;
        BOOL previousIsLine = [self fc_isLineNextCellAtIndexPath:[NSIndexPath indexPathForItem:previousIndex inSection:indexPath.section]];
        if (previousIsLine) {
            [mArr addObject:[super layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:previousIndex inSection:indexPath.section]]];
        }else{
            previousIndex = 0;
        }
    }
    //当前位置
    [mArr addObject:[super layoutAttributesForItemAtIndexPath:indexPath]];
    //向下查询
    NSInteger nextIndex = indexPath.item;
    NSInteger allItemNum = [self.collectionView numberOfItemsInSection:indexPath.section];
    while (nextIndex < allItemNum-1) {
        ++nextIndex;
        BOOL nextIsLine = [self fc_isLinePreviousCellAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:indexPath.section]];
        if (nextIsLine) {
            [mArr addObject:[super layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:indexPath.section]]];
        }else{
            nextIndex = allItemNum;
        }
    }
    return mArr;
}

/** 获取 indexPath 对应的行 item 的 frame 交集 */
- (CGRect)fc_lineFrame:(NSIndexPath *)indexPath{
    NSArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [self fc_lineAttributes:indexPath];
    CGRect rect = layoutAttributes.firstObject.frame;
    for (UICollectionViewLayoutAttributes *layoutAttri in layoutAttributes) {
        rect = CGRectUnion(rect, layoutAttri.frame);
    }
    return rect;
}

@end


@implementation FCCollectionViewLayout (CashLayout)

/** 缓冲 indexPath 处的 frame */
- (void)fc_cachedItemFrame:(CGRect)frame indexPath:(NSIndexPath *)indexPath{
    self.cachedItemFrame[k_CacheItem(indexPath)] = @(frame);
}
/** 获取 indexPath 处的 frame */
- (NSValue *)fc_cachedFrameAtIndexPath:(NSIndexPath *)indexPath{
    return self.cachedItemFrame[k_CacheItem(indexPath)];
}

/** 重置和缓冲一行Cell 的 Frame */
- (void)fc_resetAddCachedCellOfLineLayoutAttributes:(NSArray<UICollectionViewLayoutAttributes *> *)lineLayoutAttributes{
    NSInteger section = lineLayoutAttributes.firstObject.indexPath.section;
    NSInteger sectionItemNum = [self.collectionView numberOfItemsInSection:section];
    /** ------------- 布局方式 ------------- */
    //水平对齐方式
    FCCollectionViewItemsHorizontalAlignment horizontalAlignment = [self fc_itemsHorizontalAlignmentAtIndex:section];
    //垂直对齐方式
    FCCollectionViewItemsVerticalAlignment verticalAlignment = [self fc_itemsVerticalAlignmentAtIndex:section];
    //item 的流动方向
    FCCollectionViewItemsFlowDirection flowDirection = [self fc_itemsFlowDirectionAtIndex:section];
    //转换方向
    if (flowDirection == FCCollectionViewItemsFlowDirectionL2R2L || flowDirection == FCCollectionViewItemsFlowDirectionR2L2R) {
        if ([self.cachedItemFrame.allKeys containsObject:k_Layout_Direction(section)]) {
            NSMutableArray<NSNumber *> *directionCachedArr = self.cachedItemFrame[k_Layout_Direction(section)];
            if (horizontalAlignment == FCCollectionViewItemsFlowDirectionL2R2L) {
                if (directionCachedArr.lastObject.integerValue == FCCollectionViewItemsFlowDirectionL2R) {
                    lineLayoutAttributes = [lineLayoutAttributes reverseObjectEnumerator].allObjects;
                    [directionCachedArr addObject:@(FCCollectionViewItemsFlowDirectionR2L)];
                }else{
                    [directionCachedArr addObject:@(FCCollectionViewItemsFlowDirectionL2R)];
                }
            }else{
                if (directionCachedArr.lastObject.integerValue == FCCollectionViewItemsFlowDirectionR2L) {
                    lineLayoutAttributes = [lineLayoutAttributes reverseObjectEnumerator].allObjects;
                    [directionCachedArr addObject:@(FCCollectionViewItemsFlowDirectionL2R)];
                }else{
                    [directionCachedArr addObject:@(FCCollectionViewItemsFlowDirectionR2L)];
                }
            }
        }else{
            if (horizontalAlignment == FCCollectionViewItemsFlowDirectionL2R2L) {
                self.cachedItemFrame[k_Layout_Direction(section)] = [NSMutableArray arrayWithObject:@(FCCollectionViewItemsFlowDirectionL2R)];
            }else{
                self.cachedItemFrame[k_Layout_Direction(section)] = [NSMutableArray arrayWithObject:@(FCCollectionViewItemsFlowDirectionR2L)];
            }
        }
    }
    //边距
    UIEdgeInsets contentEdgeInsets = self.collectionView.contentInset;
    UIEdgeInsets sectionEdgeInsets = [self fc_insetForSectionAtIndex:section];
    //与 Collectionview 滚动方向水平的 Cell 之间的间距
    CGFloat minimumInteritemSpacing = [self fc_minimumInteritemSpacingAtIndex:section];
    //该行 cell 的宽度集合
    NSMutableArray<NSNumber *> *widthArray = NSMutableArray.array;
    for (UICollectionViewLayoutAttributes *tempLayoutAttributes in lineLayoutAttributes) {
        [widthArray addObject:@(tempLayoutAttributes.frame.size.width)];
    }
    //该行中 cell 宽度的和
    CGFloat allCellWidth = [[widthArray valueForKeyPath:@"@sum.self"] floatValue];
    //CollectionView 的宽度
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    //Cell 的有效宽度
    CGFloat cellContainerWidth = collectionViewWidth - contentEdgeInsets.left - contentEdgeInsets.right;
    //
    NSInteger lineItemCount = lineLayoutAttributes.count;
    //剩余宽度
    CGFloat extra = collectionViewWidth - allCellWidth - contentEdgeInsets.left - contentEdgeInsets.right - sectionEdgeInsets.left - sectionEdgeInsets.right - minimumInteritemSpacing*(lineItemCount - 1);
    
    //***************** 计算起点及间距 *********************//
    CGFloat start = 0.f,space = minimumInteritemSpacing;
    switch (horizontalAlignment) {
        case FCCollectionViewItemsHorizontalAlignmentFlow:{
            switch (flowDirection) {
                case FCCollectionViewItemsFlowDirectionL2R:{ };
                case FCCollectionViewItemsFlowDirectionL2R2L:{
                    start = sectionEdgeInsets.left;
                }break;
                case FCCollectionViewItemsFlowDirectionR2L:{ };
                case FCCollectionViewItemsFlowDirectionR2L2R:{
                    start = cellContainerWidth - sectionEdgeInsets.right - widthArray.firstObject.floatValue;
                }break;
                default:{} break;
            }
            BOOL isEnd = lineLayoutAttributes.lastObject.indexPath.item == [self.collectionView numberOfItemsInSection:section] - 1;
            if (isEnd && lineLayoutAttributes.count == 1) {//最后一个 CELL 且该行只有一个 CELL
                start = (cellContainerWidth - allCellWidth)*0.5;
            }
            space = minimumInteritemSpacing + extra/((lineItemCount - 1)*1.0);
        }break;
        case FCCollectionViewItemsHorizontalAlignmentFlowDirection:{
            switch (flowDirection) {
                case FCCollectionViewItemsFlowDirectionL2R:{};
                case FCCollectionViewItemsFlowDirectionL2R2L:{
                    start = sectionEdgeInsets.left;
                }break;
                    
                case FCCollectionViewItemsFlowDirectionR2L:{};
                case FCCollectionViewItemsFlowDirectionR2L2R:{
                    start = cellContainerWidth - sectionEdgeInsets.right - widthArray.firstObject.floatValue;
                }break;
                default:{} break;
            }
            if (lineLayoutAttributes.lastObject.indexPath.item == sectionItemNum - 1) {
                space = minimumInteritemSpacing;
            }else{
                space = minimumInteritemSpacing + extra/((lineItemCount - 1)*1.0);
            }
        }break;
        case FCCollectionViewItemsHorizontalAlignmentFlowFill:{
            switch (flowDirection) {
                case FCCollectionViewItemsFlowDirectionL2R:{};
                case FCCollectionViewItemsFlowDirectionL2R2L:{
                    start = sectionEdgeInsets.left;
                }break;
                case FCCollectionViewItemsFlowDirectionR2L:{};
                case FCCollectionViewItemsFlowDirectionR2L2R:{
                    start = cellContainerWidth - sectionEdgeInsets.right - (widthArray.firstObject.floatValue + extra / (lineItemCount * 1.0));
                }break;
                default:{} break;
            }
        }break;
        case FCCollectionViewItemsHorizontalAlignmentLeft:{
            switch (flowDirection) {
                case FCCollectionViewItemsFlowDirectionL2R:{};
                case FCCollectionViewItemsFlowDirectionL2R2L:{
                    start = sectionEdgeInsets.left;
                }break;
                case FCCollectionViewItemsFlowDirectionR2L:{};
                case FCCollectionViewItemsFlowDirectionR2L2R:{
                    start = cellContainerWidth - sectionEdgeInsets.right - extra - widthArray.firstObject.floatValue;
                }break;
                default:{} break;
            }
        }break;
        case FCCollectionViewItemsHorizontalAlignmentCenter:{
            switch (flowDirection) {
                case FCCollectionViewItemsFlowDirectionL2R:{};
                case FCCollectionViewItemsFlowDirectionL2R2L:{
                    start = sectionEdgeInsets.left + extra / 2.0;
                }break;
                case FCCollectionViewItemsFlowDirectionR2L:{};
                case FCCollectionViewItemsFlowDirectionR2L2R:{
                    start = cellContainerWidth - extra / 2.0 - widthArray.firstObject.floatValue;
                }break;
                default:{} break;
            }
        }break;
        case FCCollectionViewItemsHorizontalAlignmentRight:{
            switch (flowDirection) {
                case FCCollectionViewItemsFlowDirectionL2R:{};
                case FCCollectionViewItemsFlowDirectionL2R2L:{
                    start = sectionEdgeInsets.left + extra;
                }break;
                case FCCollectionViewItemsFlowDirectionR2L:{};
                case FCCollectionViewItemsFlowDirectionR2L2R:{
                    start = cellContainerWidth - sectionEdgeInsets.right - widthArray.firstObject.floatValue;
                }break;
                default:{} break;
            }
        }break;
            
        default:
            break;
    }
    
    //********** 竖直方向位置(origin.y)，用于竖直方向的对齐方式 *********//
    CGFloat tempOriginY = 0.f;
    NSArray *tempFrameValues = [lineLayoutAttributes valueForKeyPath:@"frame"];
    if (verticalAlignment == FCCollectionViewItemsVerticalAlignmentTop) {//顶对齐
        tempOriginY = CGFLOAT_MAX;
        for (NSValue *tempFrameValue in tempFrameValues) {
            tempOriginY = MIN(tempOriginY, CGRectGetMinY(tempFrameValue.CGRectValue));
        }
    }else if (verticalAlignment == FCCollectionViewItemsVerticalAlignmentBottom){//底对齐
        tempOriginY = CGFLOAT_MIN;
        for (NSValue *tempFrameValue in tempFrameValues) {
            tempOriginY = MAX(tempOriginY, CGRectGetMaxY(tempFrameValue.CGRectValue));
        }
    }
    
    /** 计算并缓存 frame */
    CGFloat previousCellMaxX = 0.f;
    for (NSInteger index = 0; index < lineLayoutAttributes.count; index++) {
        CGRect frame = lineLayoutAttributes[index].frame;
        CGFloat cellWidth = widthArray[index].floatValue;
        if (horizontalAlignment == FCCollectionViewItemsHorizontalAlignmentFlowFill) {
            cellWidth = cellWidth + (extra / (lineItemCount * 1.0));
        }
        //X 轴
        CGFloat currentCellOriginX = 0.f;
        switch (flowDirection) {
            case FCCollectionViewItemsFlowDirectionL2R:{};
            case FCCollectionViewItemsFlowDirectionL2R2L:{
                currentCellOriginX = index == 0 ? start : previousCellMaxX + space;
                previousCellMaxX = currentCellOriginX + cellWidth;
            }break;
            case FCCollectionViewItemsFlowDirectionR2L:{};
            case FCCollectionViewItemsFlowDirectionR2L2R:{
                currentCellOriginX = index == 0 ? start : previousCellMaxX - space - cellWidth;
                previousCellMaxX = currentCellOriginX;
            }break;
                
            default:
                break;
        }
        //Y 轴
        CGFloat currentCellOriginY = 0.f;
        switch (verticalAlignment) {
            case FCCollectionViewItemsVerticalAlignmentBottom:{
                currentCellOriginY += tempOriginY - CGRectGetHeight(frame);
            }break;
            case FCCollectionViewItemsVerticalAlignmentCenter:{
                currentCellOriginY += frame.origin.y;
            }break;
            default:{
                currentCellOriginY += tempOriginY;
            }break;
        }
        //
        frame.origin = CGPointMake(currentCellOriginX, currentCellOriginY);
        frame.size.width = cellWidth;
        [self fc_cachedItemFrame:frame indexPath:lineLayoutAttributes[index].indexPath];
    }
    
}

@end

//MARK: 流水布局
@implementation FCCollectionViewLayout (WaterFlow)


/**
 collectionView 分为几列，最小为1；默认2；当  itemsLayoutType ==  FCCollectionViewItemsLayoutTypeWaterFlow 时有效
 */
- (NSInteger)fc_columnNumAtIndex:(NSInteger)section{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:columnNumAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delegate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        NSInteger columnNum = [delegate collectionView:self.collectionView layout:self columnNumAtIndex:section];
        return columnNum > 0 ? columnNum : 1;
    }
    return self.columnNum > 0 ? self.columnNum : 1;
}


@end

//MARK: 装饰视图
@implementation FCCollectionViewLayout (DecorationView)

/** 装饰视图显示方式 */
- (FCCollectionViewDecorationViewType)fc_decorationViewTypeAtIndex:(NSInteger)section{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:decorationViewTypeAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delegate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self decorationViewTypeAtIndex:section];
    }
    return self.decorationViewType;
}
/** 装饰视图信息 */
- (NSArray<FCCollectionViewDecorationViewMessageModel *> *)fc_decorationViewMessagesAtIndex:(NSInteger)section{
    NSArray<FCCollectionViewDecorationViewMessageModel *> *decorationViewMessages = self.decorationViewMessages;
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:decorationViewTypeAtIndex:)]) {
        id<FCCollectionViewDelegateFlowLayout> delegate = (id<FCCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        decorationViewMessages = [delegate collectionView:self.collectionView layout:self decorationViewMessagesAtIndex:section];
    }
    if (decorationViewMessages && [decorationViewMessages isKindOfClass:NSArray.class]) {
        for (FCCollectionViewDecorationViewMessageModel *msgM in decorationViewMessages) {
            msgM.section = section;
        }
    }
    return decorationViewMessages;
}
//MARK:  求 DecorationView 的 frame =  item 和 headerView、footerView Frame的交集
- (void)fc_decorationViewFrameWithUnion:(UICollectionViewLayoutAttributes *)layoutAttributes{
    if (layoutAttributes.representedElementCategory == UICollectionElementCategoryDecorationView)   return;
    NSArray<FCCollectionViewDecorationViewMessageModel *> *decorationViewMsgs = [self fc_decorationViewMessagesAtIndex:layoutAttributes.indexPath.section];
    if (decorationViewMsgs == nil || ![decorationViewMsgs isKindOfClass:NSArray.class] || decorationViewMsgs.count == 0) return;
    
    //是否包含组头或组尾
    FCCollectionViewDecorationViewType decorationViewType = [self fc_decorationViewTypeAtIndex:layoutAttributes.indexPath.section];
    //不包含组头
    if (((decorationViewType & FCCollectionViewDecorationViewTypeContainSectionHeaderView) == NO && layoutAttributes.representedElementCategory == UICollectionElementCategorySupplementaryView && [layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader])) {
        return;
    }
    //不包含组尾
    if (((decorationViewType & FCCollectionViewDecorationViewTypeContainSectionFooterView) == NO && layoutAttributes.representedElementCategory == UICollectionElementCategorySupplementaryView && [layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionFooter])) {
        return;
    }
    NSValue *decorationViewFrameValue = self.cachedItemFrame[k_Section_DecorationViewFrame(layoutAttributes.indexPath.section)];
    if (decorationViewFrameValue == nil) {
        decorationViewFrameValue = @(layoutAttributes.frame);
    }else{
        decorationViewFrameValue = @(CGRectUnion(decorationViewFrameValue.CGRectValue, layoutAttributes.frame));
    }
    //CollectionView 的有效宽度
    if (decorationViewType & FCCollectionViewDecorationViewTypeValidWidth) {
        CGRect tempRect = CGRectMake(0, decorationViewFrameValue.CGRectValue.origin.y, CGRectGetWidth(self.collectionView.frame), decorationViewFrameValue.CGRectValue.size.height);
        decorationViewFrameValue = @(CGRectUnion(decorationViewFrameValue.CGRectValue, tempRect));
    }
    self.cachedItemFrame[k_Section_DecorationViewFrame(layoutAttributes.indexPath.section)] = decorationViewFrameValue;
    //
    for (FCCollectionViewDecorationViewMessageModel *dcViewMsgM in decorationViewMsgs) {
        dcViewMsgM.decorationViewLayoutAttributes.frame = decorationViewFrameValue.CGRectValue;
    }
    self.cachedItemFrame[k_Section_DecorationMsgs(layoutAttributes.indexPath.section)] = decorationViewMsgs;
}

/** 根据 edgeInsets 修改 decorationViewFrame */
- (void)fc_resetDecorationViewFrameAtIndex:(NSInteger)section{
    if (self.cachedItemFrame[k_Section_DecorationMsgs(section)]) {
        NSArray<FCCollectionViewDecorationViewMessageModel *> *decorationViewMsgs = self.cachedItemFrame[k_Section_DecorationMsgs(section)];
        if ([decorationViewMsgs isKindOfClass:NSArray.class]) {
            for (FCCollectionViewDecorationViewMessageModel *decorationViewMsgM in decorationViewMsgs) {
                CGRect decorationViewFrame = [self.cachedItemFrame[k_Section_DecorationViewFrame(decorationViewMsgM.section)] CGRectValue];
                if (![decorationViewMsgM.reuseIdentifier isKindOfClass:NSString.class] || ![decorationViewMsgM.decorationViewLayoutAttributes isKindOfClass:UICollectionViewLayoutAttributes.class]) break;
                //计算位置
                if (decorationViewMsgM.decorationViewCenter && decorationViewMsgM.decorationViewSize) {//决定位置和大小
                    CGFloat x = CGRectGetMinX(decorationViewFrame) + (CGRectGetWidth(decorationViewFrame) - decorationViewMsgM.decorationViewSize.CGSizeValue.width) * 0.5;
                    CGFloat y = CGRectGetMinY(decorationViewFrame) + (CGRectGetHeight(decorationViewFrame) - decorationViewMsgM.decorationViewSize.CGSizeValue.height) * 0.5;
                    CGFloat w = decorationViewMsgM.decorationViewSize.CGSizeValue.width;
                    CGFloat h = decorationViewMsgM.decorationViewSize.CGSizeValue.height;
                    decorationViewMsgM.decorationViewLayoutAttributes.frame = CGRectMake(x, y, w, h);
                }else if(decorationViewMsgM.decorationViewEdgeInsets && decorationViewMsgM.decorationViewSize){
                    UIEdgeInsets decorationViewEdgeInsets = decorationViewMsgM.decorationViewEdgeInsets.UIEdgeInsetsValue;
                    CGFloat x = CGRectGetMinX(decorationViewFrame) + decorationViewEdgeInsets.left;
                    CGFloat y = CGRectGetMinY(decorationViewFrame) + decorationViewEdgeInsets.top;
                    CGFloat w = decorationViewMsgM.decorationViewSize.CGSizeValue.width;
                    CGFloat h = decorationViewMsgM.decorationViewSize.CGSizeValue.height;
                    decorationViewMsgM.decorationViewLayoutAttributes.frame = CGRectMake(x, y, w, h);
                }else if(decorationViewMsgM.decorationViewEdgeInsets){//决定边距
                    UIEdgeInsets decorationViewEdgeInsets = decorationViewMsgM.decorationViewEdgeInsets.UIEdgeInsetsValue;
                    CGFloat x = CGRectGetMinX(decorationViewFrame) + decorationViewEdgeInsets.left;
                    CGFloat y = CGRectGetMinY(decorationViewFrame) + decorationViewEdgeInsets.top;
                    CGFloat w = CGRectGetWidth(decorationViewFrame) - decorationViewEdgeInsets.left - decorationViewEdgeInsets.right;
                    CGFloat h = CGRectGetHeight(decorationViewFrame) - decorationViewEdgeInsets.top - decorationViewEdgeInsets.bottom;
                    decorationViewMsgM.decorationViewLayoutAttributes.frame = CGRectMake(x, y, w, h);
                }else if(decorationViewMsgM.decorationViewSize){//决定大小
                    CGFloat x = CGRectGetMinX(decorationViewFrame);
                    CGFloat y = CGRectGetMinY(decorationViewFrame);
                    CGFloat w = decorationViewMsgM.decorationViewSize.CGSizeValue.width;
                    CGFloat h = decorationViewMsgM.decorationViewSize.CGSizeValue.height;
                    decorationViewMsgM.decorationViewLayoutAttributes.frame  = CGRectMake(x, y, w, h);
                }else{//为 decorationViewFrame
                    decorationViewMsgM.decorationViewLayoutAttributes.frame = decorationViewFrame;
                }
            }
        }
    }
}

/**
 获取 rect 范围内的装饰视图
 */
- (NSArray *)fc_decorationViewsWithRect:(CGRect)rect section:(NSInteger)section{
    NSMutableArray *mArr = NSMutableArray.array;
    NSArray<FCCollectionViewDecorationViewMessageModel *> *decorationViewMsgs = self.cachedItemFrame[k_Section_DecorationMsgs(section)];
    if ([decorationViewMsgs isKindOfClass:NSArray.class]){
        for (FCCollectionViewDecorationViewMessageModel *decorationViewMsgM in decorationViewMsgs) {
            if (CGRectIntersectsRect(rect, decorationViewMsgM.decorationViewLayoutAttributes.frame)) {
                [mArr addObject:decorationViewMsgM.decorationViewLayoutAttributes];
            }
        }
    }
    return mArr;
}

@end


@implementation FCCollectionViewLayout



#pragma mark - UISubclassingHooks ->
//第一次调用：初始化布局信息
//再次调用：使布局信息失效(-invalidateLayout; -invalidateLayoutWithContext:)
- (void)prepareLayout{
    [super prepareLayout];
    self.cachedItemFrame = @{}.mutableCopy;
    self.sectionSpaceOffsetY = nil;
    self.waterFlowOffsetY = nil;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //重置有效区域
    rect.origin.y -= [self.sectionSpaceOffsetY floatValue];
    rect.size.height += [self.sectionSpaceOffsetY floatValue];
    //
    NSArray *originalLayoutAttributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newLayoutAttributes = originalLayoutAttributes.mutableCopy;
    
    NSMutableSet *sectionSet = NSMutableSet.set;
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in originalLayoutAttributes) {
        //
        if (!layoutAttributes.representedElementKind && layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
            NSInteger newIndex = [newLayoutAttributes indexOfObject:layoutAttributes];
            newLayoutAttributes[newIndex] = [self layoutAttributesForItemAtIndexPath:layoutAttributes.indexPath];
        }
        //
        [sectionSet addObject:@(layoutAttributes.indexPath.section)];
    }
    //
    for (UICollectionViewLayoutAttributes *layoutAttributes in newLayoutAttributes) {
        //
        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell || (layoutAttributes.representedElementCategory == UICollectionElementCategorySupplementaryView && ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader] || [layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]))) {
            if (layoutAttributes.indexPath.section != 0) {
                CGFloat offsetY = 0.f;
                for (NSInteger tempSection = 0; tempSection <= layoutAttributes.indexPath.section; ++tempSection) {
                    offsetY += [self fc_sectionSpaceAtIndex:tempSection];
                }
                layoutAttributes.frame = CGRectOffset(layoutAttributes.frame, 0, offsetY);
            }
        }
        //
        [self fc_decorationViewFrameWithUnion:layoutAttributes];
    }
    //DecorationView 处理
    for (NSNumber *section in sectionSet) {
        [newLayoutAttributes addObjectsFromArray:[self fc_decorationViewsWithRect:rect section:[section integerValue]]];
        [self fc_resetDecorationViewFrameAtIndex:[section integerValue]];
    }
    return newLayoutAttributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
    //获取 indexPath 处 cell 的缓冲Frame
    NSValue *cellFrameValue = [self fc_cachedFrameAtIndexPath:indexPath];
    if (!cellFrameValue) {
        //是否是一行的第一个元素
        BOOL isLineStart = [self fc_isLineStartCellAtIndexPath:indexPath];
        if (isLineStart) {
            NSArray *line = [self fc_lineAttributes:indexPath];
            if (line.count > 0) {
                [self fc_resetAddCachedCellOfLineLayoutAttributes:line];
            }
        }
        //获取 indexPath 处 cell 的缓冲Frame
        cellFrameValue = [self fc_cachedFrameAtIndexPath:indexPath];
    }
    //
    if (cellFrameValue) {
        layoutAttributes.frame = cellFrameValue.CGRectValue;
    }
    return layoutAttributes;
}

- (CGSize)collectionViewContentSize {
    CGSize size = [super collectionViewContentSize];
    size.height += [self.sectionSpaceOffsetY floatValue];
    return size;
}

- (NSNumber *)sectionSpaceOffsetY{
    if (!_sectionSpaceOffsetY) {
        NSInteger sectionNum = self.collectionView.numberOfSections -1;
        CGFloat offsetY = 0;
        while (sectionNum > 0) {
            --sectionNum;
            offsetY += [self fc_sectionSpaceAtIndex:sectionNum];
        }
        _sectionSpaceOffsetY = @(offsetY);
    }
    return _sectionSpaceOffsetY;
}


@end
