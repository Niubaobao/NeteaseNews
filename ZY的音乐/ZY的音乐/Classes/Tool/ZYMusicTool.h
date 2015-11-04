//
//  ZYMusicTool.h
//  ZY的音乐
//
//  Created by 张亚超 on 15/11/2.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYMusic;
@interface ZYMusicTool : NSObject
//获得所有的音乐数据
+(NSArray*)musics;

//获得正在播放的音乐
+(ZYMusic*)playingMusic;
//设置正在播放的音乐
+(void)setplayingMusic:(ZYMusic*)playingMusic;
//下一首音乐
+(ZYMusic*)nextMusic;
//获取上一首音乐
+(ZYMusic*)previousMusic;


@end
