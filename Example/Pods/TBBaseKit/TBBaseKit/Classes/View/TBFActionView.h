//
//  TBFActionView.h
//  TBBaseKit
//
//  Created by 石富才 on 2020/2/27.
//

#import <UIKit/UIKit.h>

@protocol TBFActionViewDelegate;
@class TBFActionViewModel;
@interface TBFActionView : UIView

/** <#aaa#> */
@property(nonatomic,weak)id<TBFActionViewDelegate> delegate;

- (void)reloadData;

@end

@protocol TBFActionViewDelegate <NSObject>

@optional
- (void)actionView:(TBFActionView *)actionView didSelectedIndex:(NSInteger)index;

@required
- (NSArray<TBFActionViewModel *> *)actionView:(TBFActionView *)actionView;

@end

@interface TBFActionViewModel : NSObject
/** <#aaa#> */
@property(nonatomic,strong)NSAttributedString *titleAttri;
/** 按钮间的间距 */
@property(nonatomic,assign)CGFloat lineSpace;

/** 背景颜色 */
@property(nonatomic,strong)UIColor *backgroundColor;
/** 边框颜色 */
@property(nonatomic,strong)UIColor *borderColor;

/** 圆角半径，为 -1 时圆角为高度的一半  */
@property(nonatomic, assign)CGFloat cornerRadius;


@end
