//
//  ZYPlayingViewController.h
//  ZY的音乐
//
//  Created by 张亚超 on 15/11/1.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYMusic;

@interface ZYPlayingViewController : UIViewController

@property(nonatomic,strong)ZYMusic *music;
-(void)show;

@end
