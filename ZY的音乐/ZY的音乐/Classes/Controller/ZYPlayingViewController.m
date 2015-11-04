//
//  ZYPlayingViewController.m
//  ZY的音乐
//
//  Created by 张亚超 on 15/11/1.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import "ZYPlayingViewController.h"
#import "UIView+AdjustFrame.h"
#import "ZYMusicTool.h"
#import "ZYMusic.h"
#import "HMAudioTool.h"

@interface ZYPlayingViewController ()
//jilu 正在播放的音乐
@property(nonatomic,strong)ZYMusic* playingMusic;

//添加进度的定时器
@property(nonatomic,strong)NSTimer* progressTimer;
@property(nonatomic,strong)AVAudioPlayer* player;

- (IBAction)exit;
//音乐的label
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
//歌手的label
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
//歌手封面
@property (weak, nonatomic) IBOutlet UIImageView *singerIcon;
//音乐总时长
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *sliderButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *silderLeftConstraint;




@end

@implementation ZYPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//退出控制器
- (IBAction)exit {
//   拿到window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
//    执行动画
    [UIView animateWithDuration:1.0 animations:^{
        self.view.y = self.view.height;
    } completion:^(BOOL finished) {
        window.userInteractionEnabled = YES;
        [self removeProgressTimer];
    }];
    
    
}
-(void)show{
    if (self.playingMusic && self.playingMusic != [ZYMusicTool playingMusic]) {
        [self stopPlayingMusic];
    }
    
//1 拿到window
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
//    2设置view的frame
    self.view.frame = window.bounds;
//    3将自身的view添加到window
    [window addSubview:self.view];
//    4给self。view添加动画
    self.view.y = self.view.height;
    [UIView animateWithDuration:1.0 animations:^{
        self.view.y = 0;
        
    } completion:^(BOOL finished) {
        window.userInteractionEnabled = YES;
    }];
//    开始比方音乐并展示数据
    [self startPlayingMusic];


}
-(void)startPlayingMusic{
//拿到正在播放音乐
    ZYMusic *playingMusic = [ZYMusicTool playingMusic];
    if (playingMusic == self.playingMusic) {
        [self addProgressTimer];
        return;
    
    }
        self.playingMusic = playingMusic;
        
//        设置界面数据
        self.songLabel.text = playingMusic.name;
        self.singerLabel.text = playingMusic.singer;
        self.singerIcon.image = [UIImage imageNamed:playingMusic.icon];
//        播放音乐
       
     self.player = [HMAudioTool playMusicWithName:playingMusic.filename];
        self.totalTimeLabel.text =[self stringWithTime:self.player.duration];
//    添加控制器
    [self addProgressTimer];
    [self updateInfor];
    


}
//停止播放音乐
-(void)stopPlayingMusic{
//清楚数据界面
    self.songLabel.text = nil;
    self.singerLabel.text = nil;
    self.singerIcon.image = [UIImage imageNamed:@"play_cover_pic_bg"];
//停止播放音乐
    [HMAudioTool stopMusicWithName:self.playingMusic.filename];
    [self removeProgressTimer];

}
//添加定时器
-(void)addProgressTimer{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateInfor) userInfo:nil repeats:YES];
//    把定时器添加到主运行循环
    [[NSRunLoop mainRunLoop]addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}
//移除定时器
-(void)removeProgressTimer{
    [self.progressTimer invalidate];
    self.progressTimer = nil;


}
-(void)updateInfor{
    NSLog(@"更新数据");
//    计算比方比例
    CGFloat progressRatio = self.player.currentTime / self.player.duration;
//    gengxin滑块位置
    self.silderLeftConstraint.constant = progressRatio * (self.view.width - self.sliderButton.width );
    // 2.更新滑块的文字
    NSString *currentTimeStr = [self stringWithTime:self.player.currentTime];
    
    [self.sliderButton setTitle:currentTimeStr forState:UIControlStateNormal];
    

}



-(NSString*)stringWithTime:(NSTimeInterval)time{
    NSInteger minute = time / 60;
    NSInteger second = (NSInteger)time % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", minute , second];

}




@end
