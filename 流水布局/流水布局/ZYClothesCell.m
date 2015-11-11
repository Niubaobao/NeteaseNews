//
//  ZYClothesCell.m
//  流水布局
//
//  Created by 张亚超 on 15/11/8.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import "ZYClothesCell.h"
#import <UIImageView+WebCache.h>
#import "ZYClothes.h"

@interface ZYClothesCell()
@property (weak, nonatomic) IBOutlet UIImageView *ClothesView;
@property (weak, nonatomic) IBOutlet UILabel *ClothesPriceLabel;


@end


@implementation ZYClothesCell

-(void)setClothes:(ZYClothes *)clothes{
    _clothes = clothes;
//    设置图片
    [self.ClothesView sd_setImageWithURL:[NSURL URLWithString:clothes.img]placeholderImage:[UIImage imageNamed:@"loading"]];
//    设置价格
    self.ClothesPriceLabel.text = clothes.price;
    

}

@end
