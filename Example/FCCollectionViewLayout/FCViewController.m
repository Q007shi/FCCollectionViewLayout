//
//  FCViewController.m
//  FCCollectionViewLayout
//
//  Created by 2585299617@qq.com on 08/17/2020.
//  Copyright (c) 2020 2585299617@qq.com. All rights reserved.
//

#import "FCViewController.h"
#import <FCCategoryOCKit/FCCategoryOCKit.h>
#import <Masonry/Masonry.h>
#import "FCSectionModel.h"
#import <MJRefresh/MJRefresh.h>
//
#import "FCCollectionReusableView_Two.h"
#import "FCCollectionReusableView_One.h"
#import "FCCollectionViewLayoutAttributes.h"

@interface FCViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,FCCollectionViewDelegateFlowLayout>{
    CFDictionaryRef _dicRef;
    id obj;
    
    NSString *_str;
    CGRect _rect;
}

/** <#aaa#>  */
@property(nonatomic, strong)FCCollectionViewLayout *flowLayout;

/** <#aaa#>  */
@property(nonatomic, strong)UICollectionView *collectionView;

/** <#aaa#>  */
@property(nonatomic, strong)NSMutableArray<FCSectionModel *> *datas;


@end

@implementation FCViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _str = NSStringFromCGRect(self.view.frame);
    CGRect rect = CGRectFromString(_str);
    _rect = rect;
    
    _dicRef = CGRectCreateDictionaryRepresentation(_rect);
    
    NSLog(@"%@",_str);
    NSLog(@"%@",_dicRef);
    
    CFDictionaryRef dicRef = CGPointCreateDictionaryRepresentation(CGPointMake(10, 10));
    NSLog(@"%@",dicRef);
//    NSLog(@"%@",NSStringFromClass([CFBridgingRelease(dicRef) class]));
//    NSLog(@"%@",dicRef);
    NSLog(@"%@",NSStringFromClass([NSDictionary.dictionary class]));
    NSLog(@"%@",NSStringFromClass([NSDictionary.new class]));
    obj = CFBridgingRelease(dicRef);

    NSLog(@"obj1 %@",obj);
    
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%@",_str);
    NSLog(@"%@",_dicRef);
}

//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datas.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas[section].items.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aa" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    UILabel *label = [cell viewWithTag:101];
    if (!label) {
        label = UILabel.new;
        label.tag = 101;
        label.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.datas[indexPath.section].items[indexPath.item].contentEdgeInsets);
        }];
    }
    label.text = [NSString stringWithFormat:@"%@ - %@",@(indexPath.section),@(indexPath.item)];
//    label.frame = cell.bounds;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *rv = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"aa" forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        rv.backgroundColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.1 alpha:0.4];
    }else{
        rv.backgroundColor = [UIColor colorWithRed:0.7 green:0.1 blue:0.4 alpha:0.4];
    }
    return rv;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return self.datas[section].insetForSection;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return self.datas[section].sectionHeaderSize;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return self.datas[section].sectionFooterSize;
}

/**
 items 水平对齐方式
 */
- (FCCollectionViewItemsHorizontalAlignment)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout itemsHorizontalAlignmentAtIndex:(NSInteger)section{
    return self.datas[section].horizontalAlignment;
}

/**
 items 竖直对齐方式
 */
- (FCCollectionViewItemsVerticalAlignment)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout itemsVerticalAlignmentAtIndex:(NSInteger)section{
    return self.datas[section].verticalAlignment;
}

/**
 items 的流动方向
 */
- (FCCollectionViewItemsFlowDirection)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout itemsFlowDirectionAtIndex:(NSInteger)section{
    return self.datas[section].flowDirection;
}
/**
 items 的布局方式
 */
- (FCCollectionViewItemsLayoutType)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout itemsLayoutTypeAtIndex:(NSInteger)section{
    return self.datas[section].layoutType;
}
/** section 之间的间距  */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout sectionSpaceAtIndex:(NSInteger)section{
    return self.datas[section].sectionSpace;
}

/**
 collectionView 分为几列，最小为1；默认2；当  itemsLayoutType ==  FCCollectionViewItemsLayoutTypeWaterFlow 时有效
 */
- (NSUInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout columnNumAtIndex:(NSInteger)section{
    return self.datas[section].columnNum;
}

//MARK: FCCollectionViewLayoutDecorationViewDelegate
/** 装饰视图显示方式 */
- (FCCollectionViewDecorationViewType)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout decorationViewTypeAtIndex:(NSInteger)section{
    return self.datas[section].decorationViewType;
}

/** 装饰视图信息 */
- (NSArray<FCCollectionViewDecorationViewMessageModel *> *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout decorationViewMessagesAtIndex:(NSInteger)section{
//    NSArray *arr = self.datas[section].decorationViewMessages;
//    if ([arr isKindOfClass:NSArray.class]) {
//        for (FCCollectionViewDecorationViewMessageModel *dmM in arr) {
//            dmM.section = section;
//        }
//    }
    return self.datas[section].decorationViewMessages;
}

#pragma mark - edgeInset
- (CGFloat)_topEdgeInset{
    CGFloat f = 0;
    f += UIApplication.sharedApplication.statusBarFrame.size.height;
    f += self.navigationController.navigationBar.bounds.size.height;
    return f;
}
- (CGFloat)_bottomEdgeInset{
    CGFloat f = 0;
    if (@available(iOS 11.0, *)) {
        f += UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
    }
    if (!self.hidesBottomBarWhenPushed) {
        f += 49;
    }
    return f;
}

- (FCCollectionViewLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = FCCollectionViewLayout.new;
        _flowLayout.estimatedItemSize = CGSizeMake(100, 50);
//        _flowLayout.decorationViewDelegate = self;
//        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        _flowLayout.itemSize = CGSizeMake(100, 50);
//        _flowLayout.headerReferenceSize = CGSizeMake(100, 100);
//        _flowLayout.footerReferenceSize = CGSizeMake(100, 20);
        
        [_flowLayout registerClass:FCCollectionReusableView_One.class forDecorationViewOfKind:NSStringFromClass(FCCollectionReusableView_One.class)];
        [_flowLayout registerClass:FCCollectionReusableView_Two.class forDecorationViewOfKind:NSStringFromClass(FCCollectionReusableView_Two.class)];
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        if (@available(iOS 11.0,*)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
//        _collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 40);
        _collectionView.backgroundColor = UIColor.whiteColor;
        //
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"aa"];
        
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"aa"];
        
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"aa"];
        
        //
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.collectionView.mj_header endRefreshing];
            });
        }];
        _collectionView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.collectionView.mj_footer endRefreshing];
            });
        }];
    }
    return _collectionView;
}

- (NSMutableArray<FCSectionModel *> *)datas{
    if (!_datas) {
        _datas = NSMutableArray.array;
        
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlow verticalAlign:FCCollectionViewItemsVerticalAlignmentCenter flowDirection:FCCollectionViewItemsFlowDirectionL2R]];
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlow verticalAlign:FCCollectionViewItemsVerticalAlignmentCenter flowDirection:FCCollectionViewItemsFlowDirectionL2R2L]];
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlow verticalAlign:FCCollectionViewItemsVerticalAlignmentCenter flowDirection:FCCollectionViewItemsFlowDirectionR2L]];
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlow verticalAlign:FCCollectionViewItemsVerticalAlignmentCenter flowDirection:FCCollectionViewItemsFlowDirectionR2L2R]];
        
        
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlow verticalAlign:FCCollectionViewItemsVerticalAlignmentTop flowDirection:FCCollectionViewItemsFlowDirectionL2R]];
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlow verticalAlign:FCCollectionViewItemsVerticalAlignmentTop flowDirection:FCCollectionViewItemsFlowDirectionL2R2L]];
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlow verticalAlign:FCCollectionViewItemsVerticalAlignmentTop flowDirection:FCCollectionViewItemsFlowDirectionR2L]];
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlow verticalAlign:FCCollectionViewItemsVerticalAlignmentTop flowDirection:FCCollectionViewItemsFlowDirectionR2L2R]];



        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlow verticalAlign:FCCollectionViewItemsVerticalAlignmentBottom flowDirection:FCCollectionViewItemsFlowDirectionL2R]];
//
//
//
//
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlowDirection verticalAlign:FCCollectionViewItemsVerticalAlignmentCenter flowDirection:FCCollectionViewItemsFlowDirectionL2R]];
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentFlowFill verticalAlign:FCCollectionViewItemsVerticalAlignmentCenter flowDirection:FCCollectionViewItemsFlowDirectionL2R]];
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentLeft verticalAlign:FCCollectionViewItemsVerticalAlignmentCenter flowDirection:FCCollectionViewItemsFlowDirectionL2R]];
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentCenter verticalAlign:FCCollectionViewItemsVerticalAlignmentCenter flowDirection:FCCollectionViewItemsFlowDirectionL2R]];
        [_datas addObjectsFromArray:[self horizontalAlign:FCCollectionViewItemsHorizontalAlignmentRight verticalAlign:FCCollectionViewItemsVerticalAlignmentCenter flowDirection:FCCollectionViewItemsFlowDirectionL2R]];
    }
    return _datas;
}

- (NSArray *)horizontalAlign:(FCCollectionViewItemsHorizontalAlignment)horizontalAlign verticalAlign:(FCCollectionViewItemsVerticalAlignment)verticalAlign flowDirection:(FCCollectionViewItemsFlowDirection)flowDirection{
    NSMutableArray *_data = NSMutableArray.array;
    FCSectionModel *sectionM5 = [[FCSectionModel alloc]init:^(FCSectionModel *sm) {
        sm.sectionHeaderSize = CGSizeMake(100, 10);
        sm.sectionFooterSize = CGSizeMake(10, 20);;
//        sm.insetForSection = UIEdgeInsetsMake(10, 10, 10, 10);
        sm.horizontalAlignment = horizontalAlign;
        sm.verticalAlignment = verticalAlign;
        sm.flowDirection = flowDirection;
        sm.layoutType = FCCollectionViewItemsLayoutTypeWaterFlow;
        sm.columnNum = 2;
        //
        sm.sectionSpace = 20;
        //
        FCItemModel *m1 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(1, 1, 2, 2);
        }];
        [sm.items addObject:m1];
        //
        FCItemModel *m2 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(50, 1, 40, 2);
        }];
        [sm.items addObject:m2];
        //
        FCItemModel *m3 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(5, 2, 7, 2);
        }];
        [sm.items addObject:m3];
        //
        FCItemModel *m4 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(3, 2, 1, 2);
        }];
        [sm.items addObject:m4];
        //
        FCItemModel *m5 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(10, 2, 10, 2);
        }];
        [sm.items addObject:m5];
        //
        FCItemModel *m6 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(21, 2, 23, 5);
        }];
        [sm.items addObject:m6];
        //
        FCItemModel *m7 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 23, 24);
        }];
        [sm.items addObject:m7];
        //
        FCItemModel *m8 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 23, 24);
        }];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        [sm.items addObject:m8];
        
        FCCollectionViewDecorationViewMessageModel *dmM = [[FCCollectionViewDecorationViewMessageModel alloc]init:^(FCCollectionViewDecorationViewMessageModel *dm) {
            dm.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_One.class);
            dm.zIndex = -1;
            dm.customLayoutAttributesClass = FCCollectionViewLayoutAttributes.class;
            dm.customParams = @{
                @"backgroundColor" : UIColor.redColor,
            };
        }];
        sm.decorationViewType = FCCollectionViewDecorationViewTypeItemsContainer;
        sm.decorationViewMessages = @[dmM];
    }];
    [_datas addObject:sectionM5];
    
    //--------
    FCSectionModel *sectionM0 = [[FCSectionModel alloc]init:^(FCSectionModel *sm) {
        sm.sectionHeaderSize = CGSizeMake(100, 10);
        sm.sectionFooterSize = CGSizeMake(10, 20);;
//        sm.insetForSection = UIEdgeInsetsMake(10, 10, 10, 10);
        sm.horizontalAlignment = horizontalAlign;
        sm.verticalAlignment = verticalAlign;
        sm.flowDirection = flowDirection;
        
        //
        sm.sectionSpace = 20;
        //
        FCItemModel *m1 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(1, 1, 2, 2);
        }];
        [sm.items addObject:m1];
        //
        FCItemModel *m2 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(50, 1, 40, 2);
        }];
        [sm.items addObject:m2];
        //
        FCItemModel *m3 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(5, 2, 7, 2);
        }];
        [sm.items addObject:m3];
        //
        FCItemModel *m4 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(3, 2, 1, 2);
        }];
        [sm.items addObject:m4];
        //
        FCItemModel *m5 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(10, 2, 10, 2);
        }];
        [sm.items addObject:m5];
        //
        FCItemModel *m6 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(21, 2, 23, 5);
        }];
        [sm.items addObject:m6];
        //
        FCItemModel *m7 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 23, 24);
        }];
        [sm.items addObject:m7];
        //
        FCItemModel *m8 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 23, 24);
        }];
        [sm.items addObject:m8];
        
        FCCollectionViewDecorationViewMessageModel *dmM = [[FCCollectionViewDecorationViewMessageModel alloc]init:^(FCCollectionViewDecorationViewMessageModel *dm) {
            dm.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_One.class);
            dm.zIndex = -1;
            dm.customLayoutAttributesClass = FCCollectionViewLayoutAttributes.class;
            dm.customParams = @{
                @"backgroundColor" : UIColor.yellowColor,
            };
        }];
        
        FCCollectionViewDecorationViewMessageModel *dmM1 = [[FCCollectionViewDecorationViewMessageModel alloc]init:^(FCCollectionViewDecorationViewMessageModel *dm) {
            dm.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_Two.class);
            dm.zIndex = 99;
            dm.decorationViewSize = @(CGSizeMake(100, 50));
            dm.decorationViewCenter = YES;
        }];
        sm.decorationViewType = FCCollectionViewDecorationViewTypeItemsContainer;
        sm.decorationViewMessages = @[dmM,dmM1];
    }];
    [_datas addObject:sectionM0];
    
    //--------
    FCSectionModel *sectionM1 = [[FCSectionModel alloc]init:^(FCSectionModel *sm) {
        sm.sectionHeaderSize = CGSizeMake(100, 10);
        sm.sectionFooterSize = CGSizeMake(10, 20);
//        sm.insetForSection = UIEdgeInsetsMake(10, 10, 10, 10);
        sm.horizontalAlignment = horizontalAlign;
        sm.verticalAlignment = verticalAlign;
        sm.flowDirection = flowDirection;
        sm.layoutType = FCCollectionViewItemsLayoutTypeFlow;
        //
        sm.sectionSpace = 20;
        //
        FCItemModel *m1 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(1, 1, 2, 2);
        }];
        [sm.items addObject:m1];
        //
        FCItemModel *m2 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(50, 1, 40, 2);
        }];
        [sm.items addObject:m2];
        //
        FCItemModel *m3 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(5, 2, 7, 2);
        }];
        [sm.items addObject:m3];
        //
        FCItemModel *m4 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(3, 2, 1, 2);
        }];
        [sm.items addObject:m4];
        //
        FCItemModel *m5 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(10, 2, 10, 2);
        }];
        [sm.items addObject:m5];
        //
        FCItemModel *m6 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(21, 2, 23, 5);
        }];
        [sm.items addObject:m6];
        //
        FCItemModel *m7 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 23, 24);
        }];
        [sm.items addObject:m7];
        //
        FCItemModel *m8 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 23, 24);
        }];
        [sm.items addObject:m8];
        
        FCCollectionViewDecorationViewMessageModel *dmM = [[FCCollectionViewDecorationViewMessageModel alloc]init:^(FCCollectionViewDecorationViewMessageModel *dm) {
            dm.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_One.class);
            dm.zIndex = -1;
            dm.customLayoutAttributesClass = FCCollectionViewLayoutAttributes.class;
            dm.customParams = @{
                @"backgroundColor" : UIColor.blueColor,
            };
        }];
        
        FCCollectionViewDecorationViewMessageModel *dmM1 = [[FCCollectionViewDecorationViewMessageModel alloc]init:^(FCCollectionViewDecorationViewMessageModel *dm) {
            dm.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_Two.class);
            dm.zIndex = 99;
//                dm.decorationViewSize = @(CGSizeMake(100, 50));
//                dm.decorationViewCenter = YES;
            dm.decorationViewEdgeInsets = @(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
        sm.decorationViewType = FCCollectionViewDecorationViewTypeItemsContainer;
        sm.decorationViewMessages = @[dmM,dmM1];
    }];
    [_datas addObject:sectionM1];
    
    //--------
    FCSectionModel *sectionM2 = [[FCSectionModel alloc]init:^(FCSectionModel *sm) {
        sm.sectionHeaderSize = CGSizeMake(100, 10);
        sm.sectionFooterSize = CGSizeMake(10, 20);
//        sm.insetForSection = UIEdgeInsetsMake(10, 10, 10, 10);
        sm.horizontalAlignment = horizontalAlign;
        sm.verticalAlignment = verticalAlign;
        sm.flowDirection = flowDirection;
        sm.layoutType = FCCollectionViewItemsLayoutTypeFlow;
        //
        sm.sectionSpace = 20;
        //
        FCItemModel *m1 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(1, 1, 2, 2);
        }];
        [sm.items addObject:m1];
        //
        FCItemModel *m2 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(50, 1, 40, 2);
        }];
        [sm.items addObject:m2];
        //
        FCItemModel *m3 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(5, 2, 7, 2);
        }];
        [sm.items addObject:m3];
        //
        FCItemModel *m4 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(3, 2, 1, 2);
        }];
        [sm.items addObject:m4];
        //
        FCItemModel *m5 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(10, 2, 10, 2);
        }];
        [sm.items addObject:m5];
        //
        FCItemModel *m6 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(21, 2, 23, 5);
        }];
        [sm.items addObject:m6];
        //
        FCItemModel *m7 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 23, 24);
        }];
        [sm.items addObject:m7];
        //
        FCItemModel *m8 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 23, 24);
        }];
        [sm.items addObject:m8];
        
        FCCollectionViewDecorationViewMessageModel *dmM = [[FCCollectionViewDecorationViewMessageModel alloc]init:^(FCCollectionViewDecorationViewMessageModel *dm) {
            dm.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_One.class);
            dm.zIndex = -1;
            dm.customLayoutAttributesClass = FCCollectionViewLayoutAttributes.class;
            dm.customParams = @{
                @"backgroundColor" : UIColor.linkColor,
            };
        }];
        
        FCCollectionViewDecorationViewMessageModel *dmM1 = [[FCCollectionViewDecorationViewMessageModel alloc]init:^(FCCollectionViewDecorationViewMessageModel *dm) {
            dm.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_Two.class);
            dm.zIndex = 99;
            dm.decorationViewEdgeInsets = @(UIEdgeInsetsMake(20, 20, 0, 0));
            dm.decorationViewSize = @(CGSizeMake(100, 50));
//                dm.decorationViewCenter = YES;
        }];
        sm.decorationViewType = FCCollectionViewDecorationViewTypeItemsContainer;
        sm.decorationViewMessages = @[dmM,dmM1];
    }];
    [_datas addObject:sectionM2];
    
    //--------
    FCSectionModel *sectionM3 = [[FCSectionModel alloc]init:^(FCSectionModel *sm) {
        sm.sectionHeaderSize = CGSizeMake(100, 10);
        sm.sectionFooterSize = CGSizeMake(10, 200);
//        sm.insetForSection = UIEdgeInsetsMake(10, 10, 10, 10);
        sm.horizontalAlignment = horizontalAlign;
        sm.verticalAlignment = verticalAlign;
        sm.flowDirection = flowDirection;
        sm.layoutType = FCCollectionViewItemsLayoutTypeFlow;
        //
        sm.sectionSpace = 20;
        //
        FCItemModel *m1 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(1, 1, 2, 2);
        }];
        [sm.items addObject:m1];
        //
        FCItemModel *m2 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(50, 1, 40, 2);
        }];
        [sm.items addObject:m2];
        //
        FCItemModel *m3 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(5, 2, 7, 2);
        }];
        [sm.items addObject:m3];
        //
        FCItemModel *m4 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(3, 2, 1, 2);
        }];
        [sm.items addObject:m4];
        //
        FCItemModel *m5 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(10, 2, 10, 2);
        }];
        [sm.items addObject:m5];
        //
        FCItemModel *m6 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(21, 2, 23, 5);
        }];
        [sm.items addObject:m6];
        //
        FCItemModel *m7 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 23, 24);
        }];
        [sm.items addObject:m7];
        //
        FCItemModel *m8 = [[FCItemModel alloc]init:^(FCItemModel *im) {
            im.itemSize = CGSizeMake(50, 20);
            im.contentEdgeInsets = UIEdgeInsetsMake(2, 3, 23, 24);
        }];
        [sm.items addObject:m8];
        
        FCCollectionViewDecorationViewMessageModel *dmM = [[FCCollectionViewDecorationViewMessageModel alloc]init:^(FCCollectionViewDecorationViewMessageModel *dm) {
            dm.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_One.class);
            dm.zIndex = -1;
            dm.customLayoutAttributesClass = FCCollectionViewLayoutAttributes.class;
            dm.customParams = @{
                @"backgroundColor" : UIColor.purpleColor,
            };
        }];
        
        FCCollectionViewDecorationViewMessageModel *dmM1 = [[FCCollectionViewDecorationViewMessageModel alloc]init:^(FCCollectionViewDecorationViewMessageModel *dm) {
            dm.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_Two.class);
            dm.zIndex = 99;
            dm.decorationViewSize = @(CGSizeMake(100, 50));
//                dm.decorationViewCenter = YES;
        }];
        sm.decorationViewType = FCCollectionViewDecorationViewTypeItemsContainer;
        sm.decorationViewMessages = @[dmM,dmM1];
    }];
    [_datas addObject:sectionM3];
    
    return _data;
}

- (NSString *)titleStr:(FCCollectionViewItemsHorizontalAlignment)horizontalAlignment verticalAlignment:(FCCollectionViewItemsVerticalAlignment)verticalAlignment flowDirection:(FCCollectionViewItemsFlowDirection)flowDirection{
    NSMutableString *string = NSMutableString.new;
    switch (horizontalAlignment) {
        case FCCollectionViewItemsHorizontalAlignmentFlow:{
            [string appendString:@"FCCollectionViewItemsHorizontalAlignmentFlow"];
        }break;
        case FCCollectionViewItemsHorizontalAlignmentFlowDirection:{
            [string appendString:@"FCCollectionViewItemsHorizontalAlignmentFlowLeft"];
        }break;
        case FCCollectionViewItemsHorizontalAlignmentFlowFill:{
            [string appendString:@"FCCollectionViewItemsHorizontalAlignmentFlowFill"];
        }break;
        case FCCollectionViewItemsHorizontalAlignmentLeft:{
            [string appendString:@"FCCollectionViewItemsHorizontalAlignmentLeft"];
        }break;
        case FCCollectionViewItemsHorizontalAlignmentCenter:{
            [string appendString:@"FCCollectionViewItemsHorizontalAlignmentCenter"];
        }break;
        case FCCollectionViewItemsHorizontalAlignmentRight:{
            [string appendString:@"FCCollectionViewItemsHorizontalAlignmentRight"];
        }break;
        default:{}break;
    }
    switch (verticalAlignment) {
        case FCCollectionViewItemsVerticalAlignmentCenter:{
            
        }break;
        case FCCollectionViewItemsVerticalAlignmentTop:{
            
        }break;
        case FCCollectionViewItemsVerticalAlignmentBottom:{
            
        }break;
            
        default:{}break;
    }
    return string;
}

@end
