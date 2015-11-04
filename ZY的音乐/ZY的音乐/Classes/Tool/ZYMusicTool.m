//
//  ZYMusicTool.m
//  ZY的音乐
//
//  Created by 张亚超 on 15/11/2.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import "ZYMusicTool.h"
#import "ZYMusic.h"
#import "MJExtension.h"

@implementation ZYMusicTool

static ZYMusic *_playingMusic;
static NSArray *_musics;
//第一次调用本类的时候调用
+ (void)initialize
{
   _musics = [ZYMusic objectArrayWithFilename:@"Musics.plist"];
    }

+(NSArray*)musics{
    return _musics;

}
//获得正在播放的音乐
+(ZYMusic*)playingMusic{
    return _playingMusic;
}
+(void)setplayingMusic:(ZYMusic*)playingMusic{
//    断言
    assert(playingMusic);
    _playingMusic = playingMusic;

}
//下一首音乐
+(ZYMusic*)nextMusic{
//1 获取当前正在播放的音乐
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
//    2索引加1
    currentIndex++;
//    3判断是否越界
    if (currentIndex > _musics.count - 1) {
        currentIndex = 0;
    }
//    4取出下一首音乐
    ZYMusic *nextMusic = _musics[currentIndex];
    _playingMusic = nextMusic;
    return nextMusic;

}
//获取上一首音乐
+(ZYMusic*)previousMusic{
//    /1 获取当前正在播放的音乐
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    //    2索引加1
    currentIndex--;
    //    3判断是否越界
    if (currentIndex < 0) {
        currentIndex =  _musics.count - 1;
    }
    //    4取出下一首音乐
    ZYMusic *previousMusic = _musics[currentIndex];
    _playingMusic = previousMusic;
    return previousMusic;
 
}




@end
