//
//  FCSectionModel.h
//  FCCollectionViewLayout_Example
//
//  Created by 石富才 on 2020/11/30.
//  Copyright © 2020 2585299617@qq.com. All rights reserved.
//

#import <TBBaseKit/TBCollectionViewSectionModel.h>
#import <FCCollectionViewLayout/FCCollectionViewLayout.h>

@class FCItemModel;
@interface FCSectionModel : TBCollectionViewSectionModel

/** <#aaa#>  */
@property(nonatomic, strong)NSMutableArray<FCItemModel *> *items;

/** <#aaa#>  */
@property(nonatomic, assign)FCCollectionViewItemsHorizontalAlignment horizontalAlignment;
/** <#aaa#>  */
@property(nonatomic, assign)FCCollectionViewItemsVerticalAlignment verticalAlignment;

/** <#aaa#>  */
@property(nonatomic, assign)FCCollectionViewItemsFlowDirection flowDirection;

/** <#aaa#>  */
@property(nonatomic, assign)NSInteger columnNum;
/** <#aaa#>  */
@property(nonatomic, assign)FCCollectionViewItemsLayoutType layoutType;


/** DecorationView 的显示方式  */
@property(nonatomic, assign)FCCollectionViewDecorationViewType decorationViewType;
/** 装饰视图信息 */
@property(nonatomic, strong)NSArray<FCCollectionViewDecorationViewMessageModel *> *decorationViewMessages;

@end

@interface FCItemModel : TBCollectionViewItemModel

@end
