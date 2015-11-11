//
//  ZYWaterFlowLayout.m
//  流水布局
//
//  Created by 张亚超 on 15/11/6.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import "ZYWaterFlowLayout.h"

#define ZYCollectionViewWidth self.collectionView.frame.size.width
// 默认行间距
static const CGFloat ZYDefaultRowSpacing = 10;
// 默认列间距
static const CGFloat ZYDefaultColumnSpacing = 20;
// 默认边距
static const UIEdgeInsets ZYDefaultEdgeInsets = {10, 10, 10, 10};
// 默认列数
static const NSUInteger ZYDefaultColumnCount = 3;
@interface ZYWaterFlowLayout()
//每一列的最大Y坐标
@property(nonatomic,strong)NSMutableArray *MaxYArray;
//存所有cell的布局属性
@property(nonatomic,strong)NSMutableArray *attrsArray;
// 声明get方法
- (CGFloat)rowSpacing;
- (NSInteger)columnSpacing;
- (UIEdgeInsets)edgeInsets;
- (NSUInteger)columnCount;
@end



@implementation ZYWaterFlowLayout
//oooo

//懒加载
-(NSMutableArray *)MaxYArray{
    if (!_MaxYArray) {
        _MaxYArray = [[NSMutableArray alloc]init];
        
    }
    return _MaxYArray;
}
-(NSMutableArray *)attrsArray{

    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc ]init];
    }
    return _attrsArray;
}



-(CGSize)collectionViewContentSize{
//找出最长那一列的最大y值
    CGFloat destMaxY = [self.MaxYArray[0] doubleValue];
    for (int i = 1; i < self.MaxYArray.count; i++) {
        CGFloat MaxY = [self.MaxYArray[i] doubleValue];
        if (MaxY < destMaxY ) {
            destMaxY = MaxY;
        }
}
    return CGSizeMake(ZYCollectionViewWidth, destMaxY + ZYDefaultEdgeInsets.bottom);
}
//重置每一列的最大y坐标
-(void)prepareLayout{
    [super prepareLayout];
    
    [self.MaxYArray removeAllObjects];
    
    for (int i = 0 ; i < ZYDefaultColumnCount; i++) {
        [self.MaxYArray addObject:@(0)];
    }
//   计算所有Cell的布局
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
        
    }
    
    
    
}
//说明所有元素最终显示出来的属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *array = [NSMutableArray array];
    
//    NSInteger count =[self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < self.attrsArray.count; i++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = self.attrsArray[i];
        [array addObject:attrs];
    }
    return array;


}

//说明indexPath位置cell的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    计算indexpath位置cell的布局
//    attrs.center = CGPointMake(100, 100);
//    attrs.size = CGSizeMake(200, 200);
//找出最短y值那一列列号和最大y坐标
    CGFloat destMaxY = [self.MaxYArray[0] doubleValue];
    NSUInteger destIndex = 0;
    for (int i = 0; i < self.MaxYArray.count; i++) {
        CGFloat MaxY = [self.MaxYArray[i] doubleValue];
        if (MaxY < destMaxY ) {
            destMaxY = MaxY;
            destIndex = i;
        }
    }
    CGFloat totalColumnSpacing = (ZYDefaultColumnCount - 1) * ZYDefaultColumnSpacing;
    CGFloat width = (ZYCollectionViewWidth - ZYDefaultEdgeInsets.left - ZYDefaultEdgeInsets.right - totalColumnSpacing) / ZYDefaultColumnCount;
    
    CGFloat height = [self.delegate waterFlowLayout:self heightForItemAtIndexPath:indexPath WithItemWidth:width];
    CGFloat X = ZYDefaultEdgeInsets.left + destIndex * (width + ZYDefaultColumnSpacing );
    
    CGFloat Y = destMaxY + ZYDefaultRowSpacing;
    attrs.frame = CGRectMake(X, Y, width, height);
//更新最大y坐标
    self.MaxYArray[destIndex] = @(CGRectGetMaxY(attrs.frame));
    
    
    
    return attrs;

}
// 声明get方法
- (CGFloat)rowSpacing{
    if ([self.delegate respondsToSelector:@selector(rowSpacingInWaterFlowLayout:)]) {
        return [self.delegate rowSpacingInWaterFlowLayout:self];
    }
    return ZYDefaultRowSpacing;
}


- (NSInteger)columnSpacing{
    if ([self.delegate respondsToSelector:@selector(columnSpacingInWaterFlowLayout:)]) {
        return [self.delegate columnSpacingInWaterFlowLayout:self];
    }
    return ZYDefaultColumnSpacing;

}
- (UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterFlowLayout:)]) {
        return [self.delegate edgeInsetsInWaterFlowLayout:self];
    }
    return ZYDefaultEdgeInsets;
    
}
- (NSUInteger)columnCount{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFlowLayout:)]) {
        return [self.delegate columnCountInWaterFlowLayout:self];
    }
    return ZYDefaultColumnCount;
}


@end
