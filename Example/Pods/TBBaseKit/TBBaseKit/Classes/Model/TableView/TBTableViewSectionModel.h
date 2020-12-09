//
//  TBTableViewSectionModel.h
//  TBBaseKit
//
//  Created by 石富才 on 2020/2/29.
//

#import <Foundation/Foundation.h>
#import "TBBaseKitHeader.h"

//@class TBTableViewCellModel;
@interface TBTableViewSectionModel : NSObject

/** 组头视图高度 */
@property(nonatomic,assign)CGFloat sectionHeaderHeight;
/** 组头视图 Class  */
@property(nonatomic)Class sectionHeaderClass;

/** 组尾视图高度 */
@property(nonatomic,assign)CGFloat sectionFooterHeight;
/** 组尾视图 Class  */
@property(nonatomic)Class sectionFooterClass;

/** <#aaa#> */
@property(nonatomic, assign)NSInteger section;
/** <#aaa#>  */
@property(nonatomic, strong)NSMutableDictionary *actions;

/** <#aaa#> */
//@property(nonatomic,strong)NSMutableArray<TBTableViewCellModel *> *cells;

@end

@class TBTableViewLineModel;
@interface TBTableViewCellModel : NSObject

/** cell 高度 */
@property(nonatomic,assign)CGFloat cellHeight;
/** <#aaa#> */
@property(nonatomic)Class cellClass;

/** <#aaa#> */
@property(nonatomic, strong)NSIndexPath *indexPath;

/** <#aaa#> */
@property(nonatomic)UITableViewCellSelectionStyle cellSelectionStyle;

/** <#aaa#> */
@property(nonatomic)SEL selector;
/** <#aaa#>  */
@property(nonatomic, strong)NSMutableDictionary *actions;

/** <#aaa#>  */
@property(nonatomic, strong)NSAttributedString *titleAttri;
/** <#aaa#>  */
@property(nonatomic, strong)NSAttributedString *subTitleAttri;

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

//---------------< 路由设置 参数结束


/** <#aaa#> */
@property(nonatomic,strong)TBTableViewLineModel *lineModel;

@end

//
@class TBTableViewViewLineModel;
@interface TBTableViewLineModel : NSObject

/** 分割线背景颜色，默认 white */
@property(nonatomic,strong)UIColor *backgroundColor;
/** 分割线颜色,默认 white */
@property(nonatomic,strong)UIColor *lineColor;
/** {0,0,0,0} */
@property(nonatomic,assign)UIEdgeInsets edgeInset;

@end


