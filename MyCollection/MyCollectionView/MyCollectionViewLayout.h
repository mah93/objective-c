//
//  MyCollectionViewLayout.h
//  MyCollectionView
//
//  Created by login on 16/1/29.
//  Copyright © 2016年 login. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class MyCollectionViewLayout;
@protocol MyCollectionViewLayoutDelegate <NSObject>
/**
 *  设置每个item的自身高度
 *
 *  @param layout    layout
 *  @param indexPath 所在的位置
 *
 *  @return 高度
 */
- (CGFloat)itemHeightLayOut:(MyCollectionViewLayout *)layout indexPath:(NSIndexPath *)indexPath;

@end

@interface MyCollectionViewLayout : UICollectionViewLayout
/**
 *  列数
 */
@property (nonatomic,assign) NSInteger colNumber;
/**
 *  每个item之间的间隔
 */
@property (nonatomic,assign) CGFloat interSpace;
/**
 *  整个CollectionView的间隔
 */
@property (nonatomic,assign) UIEdgeInsets edgeInsets;
@property (nonatomic,assign) id <MyCollectionViewLayoutDelegate> delegate;
@end
NS_ASSUME_NONNULL_END