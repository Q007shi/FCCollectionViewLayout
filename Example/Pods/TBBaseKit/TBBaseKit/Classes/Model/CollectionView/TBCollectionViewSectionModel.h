//
//  TBCollectionViewSectionModel.h
//  TBBaseKit
//
//  Created by 石富才 on 2020/2/29.
//

#import <Foundation/Foundation.h>
#import "TBBaseKitHeader.h"

//@class TBCollectionViewItemModel;
@interface TBCollectionViewSectionModel : NSObject

/** 组头大小 */
@property(nonatomic) CGSize sectionHeaderSize;
/** 组头视图 */
@property(nonatomic) Class sectionHeaderClass;

/** 组尾大小 */
@property(nonatomic) CGSize sectionFooterSize;
/** 组尾视图 */
@property(nonatomic) Class sectionFooterClass;


/** 组头内容边距  */
@property(nonatomic)UIEdgeInsets sectionHeaderContentEdgeInsets;
/** 组尾内容边距  */
@property(nonatomic)UIEdgeInsets sectionFooterContentEdgeInsets;

/**  */
@property(nonatomic) UIEdgeInsets insetForSection;

/** <#aaa#> */
@property(nonatomic,assign)CGFloat lineSpace;
/** <#aaa#> */
@property(nonatomic,assign)CGFloat itemSpace;

/** <#aaa#> */
@property(nonatomic, strong)NSIndexPath *indexPath;

/** 背景颜色  */
@property(nonatomic, strong)UIColor *backgroundColor;

/** <#aaa#>  */
@property(nonatomic, strong)NSAttributedString *titleAttri;
/** <#aaa#>  */
@property(nonatomic, strong)NSAttributedString *subTitleAttri;


/** <#aaa#>  */
@property(nonatomic, strong)NSMutableDictionary *actions;

/** <#aaa#> */
//@property(nonatomic,strong)NSMutableArray<TBCollectionViewItemModel *> *items;

@end


typedef NS_ENUM(NSInteger, TBCollectionViewItemSizeType){
    TBCollectionViewItemSizeTypeFixSize,//固定大小
    TBCollectionViewItemSizeTypeFixWidth,//固定宽度
    TBCollectionViewItemSizeTypeFixHeight,//固定高度
};

@class TBCollectionViewLineModel;
@interface TBCollectionViewItemModel : NSObject

/** item 大小 */
@property(nonatomic) CGSize itemSize;
/** item size 类型  */
@property(nonatomic, assign)TBCollectionViewItemSizeType sizeType;
/** item View */
@property(nonatomic) Class itemClass;

/** <#aaa#> */
@property(nonatomic, strong)NSIndexPath *indexPath;

/** <#aaa#>  */
@property(nonatomic, strong)NSAttributedString *titleAttri;
/** <#aaa#>  */
@property(nonatomic, strong)NSAttributedString *subTitleAttri;
/** <#aaa#>  */
@property(nonatomic)UIEdgeInsets contentEdgeInsets;

/** <#aaa#>  */
@property(nonatomic, strong)UIColor *backgroundColor;

/** <#aaa#> */
@property(nonatomic,strong)TBCollectionViewLineModel *lineModel;

/** <#aaa#>  */
@property(nonatomic, strong)NSMutableDictionary *actions;

//----------------> 路由设置

/** <#aaa#> */
@property(nonatomic, copy)NSString *target;
/** <#aaa#> */
@property(nonatomic, copy)NSString *action;
/** <#aaa#> */
@property(nonatomic, strong)NSMutableDictionary *params;

/** 这个参数和上面三个是等效的  */
@property(nonatomic, copy)NSString *router;
/** <#aaa#> */
@property(nonatomic, assign)TBBaseKitVCActionType vcActionType;
/** <#aaa#> */
@property(nonatomic, assign)BOOL vcActionAnimation;

/** <#aaa#>  */
@property(nonatomic)SEL selector;

//---------------< 路由设置 参数结束

@end

//
@interface TBCollectionViewLineModel : NSObject

/** 分割线背景颜色，默认 clearColor */
@property(nonatomic,strong)UIColor *backgroundColor;
/** 分割线颜色,默认 clearColor */
@property(nonatomic,strong)UIColor *lineColor;
/** {0,0,0,0} */
@property(nonatomic,assign)UIEdgeInsets edgeInset;

@end
