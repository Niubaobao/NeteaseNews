//
//  ZYWaterFlowLayout.h
//  流水布局
//
//  Created by 张亚超 on 15/11/6.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYWaterFlowLayout;
@protocol ZYWaterFlowLayoutDelegate <NSObject>
//必须实现的方法
@required
//返回indexpath位置的cell的行高
-(CGFloat)waterFlowLayout:(ZYWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath WithItemWidth:(CGFloat)width;
//返回布局的行间距
-(NSInteger)rowSpacingInWaterFlowLayout:(ZYWaterFlowLayout *)layout;
//返回布局的列间距
-(NSInteger)columnSpacingInWaterFlowLayout:(ZYWaterFlowLayout *)layout;
//fanhui布局的边距
-(UIEdgeInsets)edgeInsetsInWaterFlowLayout:(ZYWaterFlowLayout *)layout;
//返回列数
-(NSUInteger)columnCountInWaterFlowLayout:(ZYWaterFlowLayout *)layout;

@end

@interface ZYWaterFlowLayout : UICollectionViewLayout
@property(nonatomic,weak)id<ZYWaterFlowLayoutDelegate>  delegate;

@end
