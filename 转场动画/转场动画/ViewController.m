//
//  ViewController.m
//  转场动画
//
//  Created by 张亚超 on 15/11/11.
//  Copyright © 2015年 zhaoyan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
static int i = 2;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (i == 4) {
        i = 1;
    }
    NSString *image = [NSString stringWithFormat:@"%d",i];
        self.imageName.image = [UIImage imageNamed:image];
    i++;
    CATransition *anim = [CATransition animation];
    anim.type = @"cubu";
    anim.duration = 2;
    [self.imageName.layer addAnimation:anim forKey:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
