//
//  ZYLrcCell.h
//  ZY的音乐
//
//  Created by 张亚超 on 15/11/5.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYlrcLine;
@interface ZYLrcCell : UITableViewCell

@property(nonatomic,strong)ZYlrcLine *lrcLine;
+(instancetype)lreCellWithTableView:(UITableView*)tableView;

@end
