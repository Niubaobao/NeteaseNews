//
//  ZYClothesViewController.m
//  流水布局
//
//  Created by 张亚超 on 15/11/6.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import "ZYClothesViewController.h"
#import "ZYWaterFlowLayout.h"

@interface ZYClothesViewController ()

@end

@implementation ZYClothesViewController

static NSString * const reuseIdentifier = @"ClothesCell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
//    切换布局
    self.collectionView.collectionViewLayout = [[ZYWaterFlowLayout alloc]init];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 200;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    

    cell.backgroundColor = [UIColor redColor];
    return cell;
}





@end
