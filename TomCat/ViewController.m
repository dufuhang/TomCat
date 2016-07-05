//
//  ViewController.m
//  TomCat
//
//  Created by 11 on 16/7/4.
//  Copyright (c) 2016年 Oracle. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

//------------------------视图----------------------------
@property(nonatomic,strong)UIImageView *catImgView;//显示汤姆猫的图形视图
@property(nonatomic,strong)UIButton *cymbalBtn;//敲锣按钮
@property(nonatomic,strong)UIButton *scratchBtn;//抓玻璃按钮
@property(nonatomic,strong)UIButton *drinkBtn;//喝牛奶按钮
@property(nonatomic,strong)UIButton *eatBtn;//吃小鸟按钮
@property(nonatomic,strong)UIButton *pieBtn;//扔苹果派按钮
//------------------------数组----------------------------
@property(nonatomic,strong)NSMutableArray *yawnArr;//打哈欠的图片数组
@property(nonatomic,strong)NSMutableArray *cymbalArr;//敲锣的图片数组
@property(nonatomic,strong)NSMutableArray *scratchArr;//抓玻璃数组
//----------------------音乐播放器-------------------------
@property(nonatomic,strong)AVAudioPlayer *player;//播放器
//----------------------触摸点对象-------------------------
@property(nonatomic,strong)UITouch *touch;//触摸点对象

@end

@implementation ViewController

#pragma mark - 创建图片数组
-(NSMutableArray *)creatImageArrWithPrefixName:(NSString *)name count:(int)count{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i <= count; i++) {
        //图片名字字符串
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@00%02d.jpg",name,i]]];
    }
    return [arr mutableCopy];//实现一个深拷贝？
}

#pragma mark - 控件实例化
//显示汤姆猫的图形视图
-(UIImageView *)catImgView{
    if (!_catImgView) {
        _catImgView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _catImgView.image = [UIImage imageNamed:@"cat_blink0002.jpg"];
    }
    return _catImgView;
}

//敲锣
-(UIButton *)cymbalBtn{
    if (!_cymbalBtn) {
        //实例化一个自定义图片的按钮
        _cymbalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置位置
        _cymbalBtn.frame = CGRectMake(Width_Scale(15), Height_Scale(400), Width_Scale(60), Height_Scale(60));
        //设置图片
        [_cymbalBtn setImage:[UIImage imageNamed:@"btn_no_walking-60@2x"] forState:UIControlStateNormal];
        //添加动作-动作
        [_cymbalBtn addTarget:self action:@selector(startCymbal) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cymbalBtn;
}

//抓玻璃
-(UIButton *)scratchBtn{
    if (!_scratchBtn) {
        _scratchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _scratchBtn.frame = CGRectMake(Width_Scale(15), Height_Scale(470), Width_Scale(60), Height_Scale(60));
        [_scratchBtn setImage:[UIImage imageNamed:@"btn_cat_print-60@2x"] forState:UIControlStateNormal];
        [_scratchBtn addTarget:self action:@selector(scratchBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scratchBtn;
}

//喝牛奶
-(UIButton *)drinkBtn{
    if (!_drinkBtn) {
        _drinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _drinkBtn.frame = CGRectMake(Width_Scale(15), Height_Scale(540), 60, 60);
        [_drinkBtn setImage:[UIImage imageNamed:@"gumb-milk-60@2x"] forState:UIControlStateNormal];
        [_drinkBtn addTarget:self action:@selector(drinkBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _drinkBtn;
}

//吃小鸟
-(UIButton *)eatBtn{
    if (!_eatBtn) {
        _eatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _eatBtn.frame = CGRectMake(Width_Scale(300), Height_Scale(400), 60, 60);
        [_eatBtn setImage:[UIImage imageNamed:@"gumb-bird2-60@2x"] forState:UIControlStateNormal];
        [_eatBtn addTarget:self action:@selector(eatBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eatBtn;
}

//扔苹果派
-(UIButton *)pieBtn{
    if (!_pieBtn) {
        _pieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pieBtn.frame = CGRectMake(Width_Scale(300), Height_Scale(470), 60, 60);
        [_pieBtn setImage:[UIImage imageNamed:@"btn_shuffle-60@2x"] forState:UIControlStateNormal];
        [_pieBtn addTarget:self action:@selector(pieBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pieBtn;
}

#pragma mark - View Load方法
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     添加视图控件
     */
    [self.view addSubview:self.catImgView];
    [self.view addSubview:self.cymbalBtn];
    [self.view addSubview:self.scratchBtn];
    [self.view addSubview:self.drinkBtn];
    [self.view addSubview:self.eatBtn];
    [self.view addSubview:self.pieBtn];
    
    /*
     进入程序首先开始打哈欠动画
     */
    [self performSelector:@selector(startYawn) withObject:nil afterDelay:0.5];//0.5秒后执行startYawn方法
}


#pragma mark - 执行动画的方法
-(void)startYawn{
    [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"cat_zeh" count:30] soundName:@"p_yawn3_11a" duration:3. SoundDelay:0];
}

//开始敲锣
-(void)startCymbal{
    [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"cat_cymbal" count:12] soundName:@"cymbal" duration:2. SoundDelay:0.8];
}

//开始抓玻璃
-(void)startScratch{
    [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"Scratch" count:55] soundName:@"scratch_kratzen" duration:8. SoundDelay:3.8];
}

//开始喝牛奶
-(void)startDrink{
    [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"cat_drink" count:80] soundName:@"pour_milk" duration:10. SoundDelay:2.4];
    [self performSelector:@selector(playAnnationSound:) withObject:@"p_drink_milk" afterDelay:5.8];
}

//开始吃小鸟
-(void)startEat{
    [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"cat_eat" count:39] soundName:@"p_eat" duration:4. SoundDelay:1.8];
}

//开始扔苹果派
-(void)startPie{
    [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"pie" count:22] soundName:nil duration:4. SoundDelay:0];//未加入声音为什么有声音?
}

//开始摸肚子
-(void)startStomach{
    //随机数
    int randNum = arc4random() % 2;
    NSString *soundName = randNum ? @"p_belly1" : @"p_belly2";
    [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"cat_stomach" count:33] soundName:soundName duration:3 SoundDelay:0];
}

//开始摸左脚
-(void)startFootLeft{
    int randNum = arc4random() % 2;
    NSString *soundName = randNum ? @"p_foot3" : @"p_foot4";
    [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"cat_foot_left" count:29] soundName:soundName duration:3. SoundDelay:0];
}

//开始摸右脚
-(void)startFootRight{
    int randNum = arc4random() % 2;
    NSString *soundName = randNum ? @"p_foot3" : @"p_foot4";
    [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"cat_foot_right" count:29] soundName:soundName duration:3. SoundDelay:0];
}

//摸头动画
-(void)startKnock{
    if (self.touch.tapCount <= 3) {
        int randNum = 1 + arc4random() % 6;
        NSString *soundName = [NSString stringWithFormat:@"slap%d",randNum];
        [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"cat_knockout" count:9] soundName:soundName duration:2. SoundDelay:0];
    }
    if (self.touch.tapCount > 3){
        int randNum = 1 + arc4random() % 6;
        NSString *soundName = [NSString stringWithFormat:@"slap%d",randNum];
        [self startAnimationWithImageArr:[self creatImageArrWithPrefixName:@"cat_knockout" count:80] soundName:soundName duration:10. SoundDelay:0];
        [self performSelector:@selector(playAnnationSound:) withObject:@"fall" afterDelay:1.8];
        [self performSelector:@selector(playAnnationSound:) withObject:@"p_stars2s" afterDelay:2.3];
    }
}

#pragma mark - 触摸回调方法
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    //实例化触摸点
    self.touch = [touches anyObject];
    //获取点击屏幕的坐标
    CGPoint pos = [_touch locationInView:self.view];
    if (pos.x >= Width_Scale(136) && pos.x <= Width_Scale(240) && pos.y >= Height_Scale(428) && pos.y <= Height_Scale(590)) {
        [self startStomach];
    }
    if (pos.x >= Width_Scale(186) && pos.x <= Width_Scale(232) && pos.y >= Width_Scale(609) && pos.y <= Height_Scale(643)){
        [self startFootLeft];
    }
    if (pos.x >= Width_Scale(140) && pos.x <= Width_Scale(185) && pos.y >= Width_Scale(608) && pos.y <= Height_Scale(645)){
        [self startFootRight];
    }
    if (pos.x >= Width_Scale(91) && pos.x <= Width_Scale(279) && pos.y >= Width_Scale(146) && pos.y <= Height_Scale(359)) {
        [self startKnock];
    }
}
#pragma mark - 执行动画
-(void)startAnimationWithImageArr:(NSMutableArray *)imgArr soundName:(NSString *)soundName duration:(NSTimeInterval)dur SoundDelay:(NSTimeInterval)delay{
    //如果正在执行动画，先停止
    if (self.catImgView.isAnimating) {
        [self.catImgView stopAnimating];
    }
    /*
     执行动画
     */
    //把所有图片存入数组中
    self.catImgView.animationImages = imgArr;
    //设置动画持续时间
    self.catImgView.animationDuration = dur;
    //设置动画重复次数
    self.catImgView.animationRepeatCount = 1;
    //执行动画
    [self.catImgView startAnimating];
    
    //如果正在播放声音，先停止并把播放器设置为空nil
    if (self.player.isPlaying) {
        [self.player stop];
        self.player = nil;
    }
    //使用线程终止之前所有self的方法执行
    [NSThread cancelPreviousPerformRequestsWithTarget:self];
    
    [self performSelector:@selector(playAnnationSound:) withObject:soundName afterDelay:delay];
}

#pragma mark - 播放声音
-(void)playAnnationSound:(NSString *)soundName{
    //获取声音文件的路径字符串
    NSString *filePath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
    //封装为地址对象
    NSURL *url = [NSURL fileURLWithPath:filePath];
    //实例化音乐播放器
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //播放
    [self.player play];
}
#pragma mark - 按钮触发的方法
//敲锣按钮触发
-(void)cymbalBtnPress:(id)sender{
    [self startCymbal];
}

//抓玻璃按钮触发
-(void)scratchBtnPress:(id)sender{
    [self startScratch];
}

//抓玻璃按钮触发
-(void)drinkBtnPress:(id)sender{
    [self startDrink];
}

//吃小鸟按钮触发
-(void)eatBtnPress:(id)sender{
    [self startEat];
}

//扔苹果派按钮触发
-(void)pieBtnPress:(id)sender{
    [self startPie];
}


#pragma mark - 收到内存警告执行的方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
