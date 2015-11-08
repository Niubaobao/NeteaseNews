//
//  ZYLrcView.m
//  ZY的音乐
//
//  Created by 张亚超 on 15/11/5.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import "ZYLrcView.h"
#import "UIView+AdjustFrame.h"
#import "ZYLrcCell.h"
#import "ZYlrcLine.h"

@interface ZYLrcView() <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,weak)UITableView* tableView;
@property(nonatomic,strong)NSArray * lrcLines;
@end

@implementation ZYLrcView
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//
//    if ([super initWithCoder:aDecoder]) {
//        [self setupTableView];
//    }
//    return self;
//
//}
//-(id)initWithCoder:(NSCoder *)aDecoder{
//    if ([super initWithCoder:aDecoder]) {
//        [self setupTableView];
//    }
//    return self;
//}

- (void)awakeFromNib{
     [self setupTableView];
}

-(void)setupTableView{
    
    UITableView *tableView = [[UITableView alloc]init];
    
//    tableView.alpha = 0.2;
    tableView.backgroundColor = [UIColor clearColor];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    设置控制器为自己的代理
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self addSubview:tableView];
    self.tableView = tableView;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
   self.tableView.frame = self.bounds;
//    
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.height *0.5, 0, self.tableView.height * 0.5, 0);

}
//数据源代理实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.lrcLines.count ;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//创建cell
    ZYLrcCell *cell = [ZYLrcCell lreCellWithTableView:tableView ];
  
//    cell.textLabel.text = self.lrcLines[indexPath.row];
    
    cell.lrcLine = self.lrcLines[indexPath.row];
    return cell;
}
-(void)setLrcname:(NSString *)lrcname{
//    baocub歌词的文件名称
    _lrcname = lrcname;
//    加载对应的歌词
    NSString *path = [[NSBundle mainBundle]pathForResource:lrcname ofType:nil];
   NSString *lrcString  = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",lrcString);
//解析歌词
//    截取字符串放到数组里面
    NSArray * lrcLineStrs = [lrcString componentsSeparatedByString:@"\n"];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString * lrcLineStr in lrcLineStrs) {
//        [tempArray addObject:lrcLineStr];
//        移除不需要的行
        if ([lrcLineStr hasPrefix:@"[ti"] || [lrcLineStr hasPrefix:@"[ar"] || [lrcLineStr hasPrefix:@"al"] || ![lrcLineStr hasPrefix:@"["]) {
            continue;
        }
//        jie截取每一行歌词的字符串
        NSArray *lrcLineStrParts  = [lrcLineStr componentsSeparatedByString:@"]"];
        ZYlrcLine * lrcLine = [[ZYlrcLine alloc] init];
        lrcLine.time = [[lrcLineStrParts firstObject] substringFromIndex:1];
        lrcLine.text = [lrcLineStrParts lastObject];
        
//        将模型对象添加到数组中
        [tempArray addObject:lrcLine];
        
        
    }
    self.lrcLines = tempArray;
    
    
    
    
    
    
    
    
    
    
    
    
    
    [self.tableView reloadData];
}


@end
