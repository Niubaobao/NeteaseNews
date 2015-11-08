//
//  ZYLrcCell.m
//  ZY的音乐
//
//  Created by 张亚超 on 15/11/5.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import "ZYLrcCell.h"
#import "ZYlrcLine.h"

@implementation ZYLrcCell

+(instancetype)lreCellWithTableView:(UITableView *)tableView{
static NSString* ID = @"LrcCell";
    ZYLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZYLrcCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //    设置表格样式内容
        
                
        cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.textColor = [UIColor whiteColor];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
        
        
    }

    return cell;

}
-(void)setLrcLine:(ZYlrcLine *)lrcLine{
    _lrcLine = lrcLine;
    self.textLabel.text = lrcLine.text;


}


@end
