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

#import "FCCollectionViewCell.h"

@interface FCViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FCCollectionViewDelegateFlowLayout>{
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
    
    
    [self _setupData];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = UIColor.redColor;
    btn.frame = CGRectMake(30, 50, 50, 50);
    btn.layer.cornerRadius = 25;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(_addAction) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)_addAction{
    
    
    CGFloat itemW = CGRectGetWidth(self.view.bounds) - 50;
    
    FCSectionModel *sm1 = FCSectionModel.new;
    sm1.sectionHeaderSize = CGSizeMake(itemW, 20);
    sm1.sectionHeaderClass = UICollectionReusableView.class;
    sm1.sectionFooterSize = CGSizeMake(itemW, 10);
    sm1.horizontalAlignment = FCCollectionViewItemsHorizontalAlignmentCenter;
    sm1.lineSpace = 1;
    
    
    FCCollectionViewDecorationViewMessageModel *dm1_1 = FCCollectionViewDecorationViewMessageModel.new;
    dm1_1.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_One.class);
    dm1_1.zIndex = -1;
    dm1_1.decorationViewEdgeInsets = @(UIEdgeInsetsMake(-10, -10, -10, -10));
    sm1.decorationViewMessages = @[dm1_1];
    
    FCItemModel *im1_1 = FCItemModel.new;
    im1_1.itemSize = CGSizeMake(itemW, arc4random_uniform(300));
    im1_1.itemClass = UICollectionViewCell.class;
    [sm1.items addObject:im1_1];
    
    FCItemModel *im1_2 = FCItemModel.new;
    im1_2.itemSize = CGSizeMake(itemW, arc4random_uniform(110));
    im1_2.itemClass = UICollectionViewCell.class;
    [sm1.items addObject:im1_2];
    
    
    [self.datas insertObject:sm1 atIndex:0];
    [self.collectionView reloadData];
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
    if (indexPath.item == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.3 green:0.8 blue:0.4 alpha:0.8];
    }else{
        cell.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.8 alpha:0.8];
    }
    UILabel *label = [cell viewWithTag:101];
    if (!label) {
        label = UILabel.new;
        label.tag = 101;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textColor = UIColor.blackColor;
        [cell addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    label.text = [NSString stringWithFormat:@"%@ - %@",@(indexPath.section),@(indexPath.item)];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *rv = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"aa" forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        rv.backgroundColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.1 alpha:0.2];
    }else{
        rv.backgroundColor = [UIColor colorWithRed:0.7 green:0.1 blue:0.4 alpha:0.4];
    }
    return rv;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.datas[indexPath.section].items[indexPath.item].itemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return self.datas[section].insetForSection;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.datas[section].lineSpace;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.datas[section].itemSpace;
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
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout sectionSpaceAtIndex:(NSInteger)section{
//    return self.datas[section].sectionSpace;
//}

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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.datas[indexPath.section].open = !self.datas[indexPath.section].open;
    [collectionView reloadData];
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
        [_collectionView registerClass:FCCollectionViewCell.class forCellWithReuseIdentifier:@"aa"];
        
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"aa"];
        
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"aa"];
        
    }
    return _collectionView;
}

- (NSMutableArray<FCSectionModel *> *)datas{
    if (!_datas) {
        _datas = NSMutableArray.array;
        
    }
    return _datas;
}

- (void)_setupData{
    CGFloat itemW = CGRectGetWidth(self.view.bounds) - 50;
    
    for (NSInteger t = 0; t < 150; ++t) {
        FCSectionModel *sm1 = FCSectionModel.new;
        sm1.sectionHeaderSize = CGSizeMake(itemW, 20);
        sm1.sectionHeaderClass = UICollectionReusableView.class;
        sm1.sectionFooterSize = CGSizeMake(itemW, 10);
        sm1.horizontalAlignment = FCCollectionViewItemsHorizontalAlignmentCenter;
        sm1.lineSpace = 1;
        
        
        FCCollectionViewDecorationViewMessageModel *dm1_1 = FCCollectionViewDecorationViewMessageModel.new;
        dm1_1.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_One.class);
        dm1_1.zIndex = -1;
        dm1_1.decorationViewEdgeInsets = @(UIEdgeInsetsMake(-10, -10, -10, -10));
        sm1.decorationViewMessages = @[dm1_1];
        
        FCItemModel *im1_1 = FCItemModel.new;
        im1_1.itemSize = CGSizeMake(itemW, 30);
        im1_1.itemClass = UICollectionViewCell.class;
        [sm1.items addObject:im1_1];
        
        FCItemModel *im1_2 = FCItemModel.new;
        im1_2.itemSize = CGSizeMake(itemW, 40);
        im1_2.itemClass = UICollectionViewCell.class;
        [sm1.items addObject:im1_2];
        
        
        [self.datas addObject:sm1];
    }
    
    for (NSInteger t = 0; t < 5; ++t) {
        FCSectionModel *sm1 = FCSectionModel.new;
        sm1.sectionHeaderSize = CGSizeMake(itemW, 20);
        sm1.sectionHeaderClass = UICollectionReusableView.class;
        sm1.sectionFooterSize = CGSizeMake(itemW, 10);
        sm1.horizontalAlignment = FCCollectionViewItemsHorizontalAlignmentCenter;
        sm1.lineSpace = 1;
        
        
        FCCollectionViewDecorationViewMessageModel *dm1_1 = FCCollectionViewDecorationViewMessageModel.new;
        dm1_1.reuseIdentifier = NSStringFromClass(FCCollectionReusableView_One.class);
        dm1_1.zIndex = -1;
        dm1_1.decorationViewEdgeInsets = @(UIEdgeInsetsMake(-10, -10, -10, -10));
        sm1.decorationViewMessages = @[dm1_1];
        
        FCItemModel *im1_1 = FCItemModel.new;
        im1_1.itemSize = CGSizeMake(itemW, 30 * t);
        im1_1.itemClass = UICollectionViewCell.class;
        [sm1.items addObject:im1_1];
        
        FCItemModel *im1_2 = FCItemModel.new;
        im1_2.itemSize = CGSizeMake(itemW, 40);
        im1_2.itemClass = UICollectionViewCell.class;
        [sm1.items addObject:im1_2];
        [self.datas addObject:sm1];
    }
    
    
    
}

@end
