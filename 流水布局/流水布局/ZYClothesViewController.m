//
//  ZYClothesViewController.m
//  流水布局
//
//  Created by 张亚超 on 15/11/6.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import "ZYClothesViewController.h"
#import "ZYWaterFlowLayout.h"
#import "ZYClothes.h"
#import "ZYClothesCell.h"
#import <MJExtension.h>
#import <MJRefresh.h>


@interface ZYClothesViewController ()<ZYWaterFlowLayoutDelegate>
//衣服的模型数组
@property(nonatomic ,strong) NSMutableArray *clothesArray;

@end

@implementation ZYClothesViewController

static NSString * const reuseIdentifier = @"ClothesCell";
//懒加载

-(NSMutableArray *)clothesArray{
    if (!_clothesArray) {
        _clothesArray = [[NSMutableArray alloc] init];
    }
    return _clothesArray;

}


- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    使用框架字典转模型
    NSArray *tempArray = [ZYClothes objectArrayWithFilename:@"clothes.plist"];
    [self.clothesArray addObjectsFromArray:tempArray];
//    切换布局
    ZYWaterFlowLayout *layout = [[ZYWaterFlowLayout alloc]init];
    layout.delegate = self;
    
    
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
     __weak typeof(self) weakSelf = self;
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        加载数据
        NSArray *tempArray = [ZYClothes objectArrayWithFilename:@"clothes.plist"];
        [weakSelf.clothesArray insertObjects:tempArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempArray.count)]];
        [weakSelf.collectionView reloadData];
        
//        结束刷新
        [weakSelf.collectionView.header endRefreshing];
        
        }];
//    上拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSArray *tempArray = [ZYClothes objectArrayWithFilename:@"clothes.plict"];
//        添加
        [weakSelf.clothesArray addObjectsFromArray:tempArray];
//        刷新
        [weakSelf.collectionView reloadData];
        
//        结束刷新
        [weakSelf.collectionView.footer endRefreshing];
        
    }];

    

}




#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return self.clothesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYClothesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.clothes = self.clothesArray[indexPath.item];

//    cell.backgroundColor = [UIColor redColor];
    return cell;
}
//实现代理的方法
-(CGFloat)waterFlowLayout:(ZYWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath WithItemWidth:(CGFloat)width{

    ZYClothes *clotdes = self.clothesArray[indexPath.item];
//    要拿到的衣服的高 得先拿出衣服的模型
    return clotdes.h * width / clotdes.w;

}





@end
