//
//  ZYMusicesViewController.m
//  ZY的音乐
//
//  Created by 张亚超 on 15/10/30.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import "ZYMusicesViewController.h"
#import "ZYMusic.h"

#import "ZYPlayingViewController.h"
#import "UIImage+Circle.h"
#import "ZYMusicTool.h"

@interface ZYMusicesViewController ()
//所有音乐数组
//@property(nonatomic, strong)NSArray* musics;
//正在播放的控制器
@property(nonatomic,strong)ZYPlayingViewController *playingVc;

@end

@implementation ZYMusicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    改变cell的高度
    self.tableView.rowHeight = 80;
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//懒加载数组
//MJExtension.h懒加载框架
//-(NSArray *)musics{
//    if (_musics == nil) {
//
//        self.musics = [ZYMusic objectArrayWithFilename:@"Musics.plist"];
//    }
//
//    return _musics;
//}
-(ZYPlayingViewController *)playingVc{
    if (_playingVc == nil) {
        _playingVc = [[ZYPlayingViewController alloc]init];
    }

    return _playingVc;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//1,让cell变为不选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZYMusic *music = [ZYMusicTool musics][indexPath.row];
//    self.playingVc.music = music;
    [ZYMusicTool setplayingMusic:music];
    
//2弹出控制器
    [self.playingVc show];


}
//数据源代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ZYMusicTool musics].count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString* ID = @"MusicCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
        }
//    取出模型对象
    ZYMusic *music = [ZYMusicTool musics][indexPath.row];
//    根据图片名称返回一个圆形的头像
    cell.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:3.0 borderColor:[UIColor redColor]];
    cell.textLabel.text = music.name;
    cell.detailTextLabel.text = music.singer;

    return cell;
}



@end
