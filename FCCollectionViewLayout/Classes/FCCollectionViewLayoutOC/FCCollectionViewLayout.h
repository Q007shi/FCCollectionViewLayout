//
//  FCCollectionViewLayout.h
//  FCCollectionViewLayout
//
//  Created by 石富才 on 2020/8/17.
//
//https://www.jianshu.com/p/5ee9333644ed
//https://blog.csdn.net/iosworker/article/details/50749697
//https://blog.csdn.net/u013410274/article/details/79925531
//http://code.cocoachina.com/view/132340

#import <UIKit/UIKit.h>

//** 装饰视图信息 **/
@interface FCCollectionViewDecorationViewMessageModel : NSObject

/** 唯一标识符 (每组中必须是唯一的)，【必须】  */
@property(nonatomic, strong)NSString *reuseIdentifier;
/** 层  */
@property(nonatomic, assign)NSInteger zIndex;
/** zIndex用于设置front-to-back层级；值越大，优先布局在上层；cell的zIndex为0   */
@property(nonatomic, strong, readonly)UICollectionViewLayoutAttributes *decorationViewLayoutAttributes;

//这两个属性决定 decorationViewAttributes 的 frame
/** UIEdgeInsets  */
@property(nonatomic)NSValue *decorationViewEdgeInsets;
/** CGSize  */
@property(nonatomic)NSValue *decorationViewSize;
/** 显示在 DecorationViewFrame 的中心点，大小等于  decorationViewSize  */
@property(nonatomic, assign)BOOL decorationViewCenter;

/** 组  */
@property(nonatomic, assign, readonly)NSInteger section;

//********** 自定义 UICollectionViewLayoutAttributes
/** 【可选】，默认UICollectionViewLayoutAttributes  */
@property Class customLayoutAttributesClass;
/** 自定义 customLayoutAttributesClass 添加的属性 */
@property(nonatomic, strong)NSDictionary *customParams;
//**********

@end

/** 水平对齐方式 */
typedef NS_ENUM(NSInteger, FCCollectionViewItemsHorizontalAlignment){
    FCCollectionViewItemsHorizontalAlignmentFlow,/** 等同  FCCollectionViewItemsHorizontalAlignment */
    FCCollectionViewItemsHorizontalAlignmentFlowDirection,/** 等同  FCCollectionViewItemsHorizontalAlignment，但最后一行左对齐或右对齐(和 FCCollectionViewItemsFlowDirection 有关) */
    FCCollectionViewItemsHorizontalAlignmentFlowFill, /** cell 均分多余部分，使 Cell 间距不变 */
    FCCollectionViewItemsHorizontalAlignmentLeft,/** 左对齐 */
    FCCollectionViewItemsHorizontalAlignmentCenter, /** 居中 */
    FCCollectionViewItemsHorizontalAlignmentRight,/** 右对齐 */
};
/** 竖直对齐方式 */
typedef NS_ENUM(NSInteger,FCCollectionViewItemsVerticalAlignment){
    FCCollectionViewItemsVerticalAlignmentCenter,/** 中线对齐 */
    FCCollectionViewItemsVerticalAlignmentTop, /** 顶线对齐 */
    FCCollectionViewItemsVerticalAlignmentBottom,/** 底线对齐 */
};

/** items 的流动方向 */
typedef NS_ENUM(NSInteger,FCCollectionViewItemsFlowDirection){
    FCCollectionViewItemsFlowDirectionL2R,/** 从左向右 */
    FCCollectionViewItemsFlowDirectionL2R2L,/** 从左到右再到左  */
    FCCollectionViewItemsFlowDirectionR2L,/** 从右向左 */
    FCCollectionViewItemsFlowDirectionR2L2R,/** 从右向左再到右 */
};

/** items 的布局方式 */
typedef NS_ENUM(NSInteger, FCCollectionViewItemsLayoutType){
    FCCollectionViewItemsLayoutTypeFlow,//默认布局
    FCCollectionViewItemsLayoutTypeWaterFlow,//流水布局
};

/** DecorationView 的显示方式 */
typedef NS_ENUM(NSInteger,FCCollectionViewDecorationViewType){
    FCCollectionViewDecorationViewTypeItemsContainer = 1,// 二进制：1；十进制：1。
    FCCollectionViewDecorationViewTypeValidWidth = 1 << 1,//CollectionView 的有效宽度。二进制：10；十进制：2。
    
    FCCollectionViewDecorationViewTypeContainSectionHeaderView = 1 << 2,//包含 SectionHeaderView(注意：zIndex = 10)。二进制：100；十进制：4。
    FCCollectionViewDecorationViewTypeContainSectionFooterView = 1 << 3,//包含 SectionFooterView(注意：zIndex = 10)。二进制：1000；十进制：8
};

@interface FCCollectionViewLayout : UICollectionViewFlowLayout

/** 水平对齐方式  */
@property(nonatomic, assign)FCCollectionViewItemsHorizontalAlignment itemsHorizontalAlignment;
/** 竖直对齐方式  */
@property(nonatomic, assign)FCCollectionViewItemsVerticalAlignment itemsVerticalAlignment;
/** items 的流动方向  */
@property(nonatomic, assign)FCCollectionViewItemsFlowDirection itemsFlowDirection;

/** items 的布局方式  */
@property(nonatomic, assign)FCCollectionViewItemsLayoutType itemsLayoutType;

/** section 之间的间距  */
@property(nonatomic, assign)CGFloat sectionSpace;


//************* 流水布局  *****************/

/** collectionView 分为几列，最小为1；默认2；当  itemsLayoutType ==  FCCollectionViewItemsLayoutTypeWaterFlow 时有效 */
@property(nonatomic, assign)NSUInteger columnNum;

//***************************************/

//************* 装饰视图  *****************/
/** DecorationView 的显示方式  */
@property(nonatomic, assign)FCCollectionViewDecorationViewType decorationViewType;
/** 装饰视图信息 */
@property(nonatomic, strong)NSArray<FCCollectionViewDecorationViewMessageModel *> *decorationViewMessages;

//****************************************/

@end

@protocol FCCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@optional
/**
 items 水平对齐方式
 */
- (FCCollectionViewItemsHorizontalAlignment)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout itemsHorizontalAlignmentAtIndex:(NSInteger)section;

/**
 items 竖直对齐方式
 */
- (FCCollectionViewItemsVerticalAlignment)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout itemsVerticalAlignmentAtIndex:(NSInteger)section;

/**
 items 的流动方向
 */
- (FCCollectionViewItemsFlowDirection)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout itemsFlowDirectionAtIndex:(NSInteger)section;

/**
 items 的布局方式
 */
- (FCCollectionViewItemsLayoutType)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout itemsLayoutTypeAtIndex:(NSInteger)section;

/** section 之间的间距  */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout sectionSpaceAtIndex:(NSInteger)section;

//************* 流水布局  *****************/
/**
 collectionView 分为几列，最小为1；默认2；当  itemsLayoutType ==  FCCollectionViewItemsLayoutTypeWaterFlow 时有效
 */
- (NSUInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout columnNumAtIndex:(NSInteger)section;

//**********************************************/

//************* 装饰视图  *****************/

- (FCCollectionViewDecorationViewType)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout decorationViewTypeAtIndex:(NSInteger)section;

/** 装饰视图信息 */
- (NSArray<FCCollectionViewDecorationViewMessageModel *> *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout decorationViewMessagesAtIndex:(NSInteger)section;

//****************************************/

@end
