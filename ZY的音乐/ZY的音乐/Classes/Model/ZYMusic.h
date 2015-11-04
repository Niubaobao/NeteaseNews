//
//  ZYMusic.h
//  ZY的音乐
//
//  Created by 张亚超 on 15/10/31.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYMusic : NSObject
/**<dict>
<key>name</key>
<string>月半小夜曲</string>
<key>filename</key>
<string>1201111234.mp3</string>
<key>lrcname</key>
<string>月半小夜曲.lrc</string>
<key>singer</key>
<string>李克勤</string>
<key>singerIcon</key>
<string>lkq_icon.jpg</string>
<key>icon</key>
<string>lkq.jpg</string>
*/
//歌曲名称
@property (nonatomic, copy)NSString *name;
//歌曲对应的文件名
@property(nonatomic, copy) NSString *filename;
//歌词名称
@property (nonatomic, copy) NSString *lrcname;
//歌手名字
@property (nonatomic, copy) NSString *singer;
//歌手头像
@property (nonatomic, copy) NSString *singerIcon;
//歌手封面
@property (nonatomic, copy) NSString *icon;




@end
