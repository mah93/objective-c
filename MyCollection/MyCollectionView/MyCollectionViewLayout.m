//
//  MyCollectionViewLayout.m
//  MyCollectionView
//
//  Created by login on 16/1/29.
//  Copyright © 2016年 login. All rights reserved.
//

#import "MyCollectionViewLayout.h"

@interface MyCollectionViewLayout () {

    NSMutableArray *_coiumHeightArray;
    NSMutableArray *_attributeArray;
}

@end

@implementation MyCollectionViewLayout

- (void)setColNumber:(NSInteger)colNumber {
    if (_colNumber != colNumber) {
        _colNumber = colNumber;
        [self invalidateLayout];
    }
}
- (void)setInterSpace:(CGFloat)interSpace {
    if (_interSpace != interSpace) {
        _interSpace = interSpace;
        [self invalidateLayout];
    }
}
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    if (!UIEdgeInsetsEqualToEdgeInsets(_edgeInsets, edgeInsets)) {
        _edgeInsets = edgeInsets;
        [self invalidateLayout];
    }
}
- (void)prepareLayout {
    [super prepareLayout];
    _coiumHeightArray = [NSMutableArray arrayWithCapacity:_colNumber];
    _attributeArray = [[NSMutableArray alloc]init];
    for (int index = 0; index < _colNumber; index++) {
        _coiumHeightArray[index] = @(_edgeInsets.top);
    }
    CGFloat totalWidth = self.collectionView.bounds.size.width;
//
    CGFloat totalItemWidth = totalWidth - _edgeInsets.left - _edgeInsets.right - _interSpace * (_colNumber - 1);
    CGFloat intemWidth = totalItemWidth/_colNumber;
//    拿到每个分区所有的item的个数
    NSInteger totalItems = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < totalItems; i++) {
        NSInteger currentCol = [self getMinY];
//        这个item的x
        CGFloat xPos = _edgeInsets.left + (intemWidth + _interSpace) * currentCol;
//        这个item的y
        CGFloat yPos = [_coiumHeightArray[currentCol] floatValue];
//        拿到这个item
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGFloat itemHeight = 0.0;
        if (_delegate && [_delegate respondsToSelector:@selector(itemHeightLayOut:indexPath:)]) {
            itemHeight = [_delegate itemHeightLayOut:self indexPath:indexPath];
        }
        CGRect frame = CGRectMake(xPos, yPos, intemWidth, itemHeight);
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = frame;
        [_attributeArray addObject:attributes];
        CGFloat upDateY = [_coiumHeightArray[currentCol] floatValue] + itemHeight + _interSpace;
        _coiumHeightArray[currentCol] = @(upDateY);
    }
}
/**
 *  每次获取最小y的列数
 */
- (NSInteger)getMinY {
    __block CGFloat minHeight = MAXFLOAT;
    __block NSInteger minCol = 0;
    [_coiumHeightArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat heightInArray = [_coiumHeightArray[idx] floatValue];
        if (heightInArray < minHeight) {
            minHeight = heightInArray;
            minCol = idx;
        }
    }];
    return minCol;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *resultArray = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in _attributeArray) {
        CGRect rect1 = attributes.frame;
        if (CGRectIntersectsRect(rect1, rect)) {
            [resultArray addObject:attributes];
        }
    }
    return resultArray;
}
- (CGSize)collectionViewContentSize {
    CGFloat width = self.collectionView.frame.size.width;
    NSInteger index = [self maxCurrentCol];
    CGFloat height = [_coiumHeightArray[index] floatValue];
    return CGSizeMake(width, height);
}
- (NSInteger)maxCurrentCol {
    __block CGFloat maxHeight = 0.0;
    __block NSInteger maxIndex = 0;
    [_coiumHeightArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat heightInArray = [_coiumHeightArray[idx] floatValue];
        if (heightInArray > maxHeight ) {
            maxHeight = heightInArray;
            maxIndex = idx;
        }
    }];
    return maxIndex;
}
@end
