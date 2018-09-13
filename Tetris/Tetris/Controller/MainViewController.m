//
//  MainViewController.m
//  Tetris
//
//  Created by QSP on 2018/8/26.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "MainViewController.h"
#import "ElementV.h"
#import "TetrisV.h"
#import "MainVM.h"
#import "PreviewV.h"
#import "SoundPlayer.h"
#import "SetViewController.h"

@interface VerticalButton : UIButton


@end

@implementation VerticalButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        self.backgroundColor = K_RandomColor;
//        self.imageView.backgroundColor = K_RandomColor;
//        self.titleLabel.backgroundColor = K_RandomColor;
    }

    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat W = 30*K_ScreenScale_X;
    return CGRectMake((contentRect.size.width - W)/2.0, 0, W, W);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat Y = 30*K_ScreenScale_X;
    return CGRectMake(0, Y, contentRect.size.width, contentRect.size.height - Y);
}

@end

@interface MainViewController ()

@property (strong, nonatomic) MainVM *vm;
@property (weak, nonatomic) UIView *screenV;
@property (weak, nonatomic) TetrisV *tetrisV;
@property (weak, nonatomic) PreviewV *previewV;
@property (weak, nonatomic) UILabel *modeL;
@property (weak, nonatomic) UILabel *scoreL;
@property (weak, nonatomic) UILabel *highestL;
@property (weak, nonatomic) UILabel *speedL;
@property (weak, nonatomic) UIImageView *soundIV;
@property (weak, nonatomic) UIImageView *pauseIV;
@property (weak, nonatomic) UIButton *resetB;
@property (weak, nonatomic) UIButton *soundB;
@property (weak, nonatomic) UIButton *setB;
@property (weak, nonatomic) UIButton *pauseB;
@property (weak, nonatomic) UIButton *upB;
@property (weak, nonatomic) UIButton *leftB;
@property (weak, nonatomic) UIButton *rightB;
@property (weak, nonatomic) UIButton *downB;
@property (weak, nonatomic) UIButton *rotationB;
@property (weak, nonatomic) UIImageView *prepareIV;
@property (weak, nonatomic) UIImageView *resetIV;
@property (weak, nonatomic) UIImageView *overIV;

@end

@implementation MainViewController

- (NSArray *)resetImages {
    CGFloat spacing = K_TetrisSpacing;
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
    CGFloat W = K_TetrisElementW*K_TetrisCount_H + spacing*(K_TetrisCount_H - 1) + spacing*2;
    CGFloat H = K_TetrisElementW*K_TetrisCount_V + spacing*(K_TetrisCount_V - 1) + spacing*2;
    UIGraphicsBeginImageContext(CGSizeMake(W, H));
    for (NSInteger section = K_TetrisCount_V - 1; section >= 0; section--) {
        for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
            [K_PublicInformation.elementImage drawInRect:CGRectMake(spacing + (spacing + K_TetrisElementW)*row, spacing + (spacing + K_TetrisElementW)*section, K_TetrisElementW, K_TetrisElementW)];
        }
        [mArr addObject:UIGraphicsGetImageFromCurrentImageContext()];
    }
    UIGraphicsEndImageContext();
    
    NSMutableArray *endArr = [NSMutableArray arrayWithArray:mArr];
    [endArr addObjectsFromArray:[[mArr reverseObjectEnumerator] allObjects]];
    
    return endArr;
}
- (UIImage *)overImage {
    CGFloat spacing = K_TetrisSpacing;
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"OverImage" ofType:@"plist"]];
    CGFloat W = K_TetrisElementW*K_TetrisCount_H + spacing*(K_TetrisCount_H - 1) + spacing*2;
    CGFloat H = K_TetrisElementW*K_TetrisCount_V + spacing*(K_TetrisCount_V - 1) + spacing*2;
    UIGraphicsBeginImageContext(CGSizeMake(W, H));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [K_TetrisBackColor setFill];
    CGContextFillRect(context, CGRectMake(spacing, spacing, W - spacing*2, H - spacing*2));
    UIImage *image = [ConFunc image:K_PublicInformation.elementImage andAlpha:0.2];
    for (NSInteger section = 0; section < K_TetrisCount_V; section++) {
        for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
            CGRect rect = CGRectMake(spacing + row*(K_TetrisElementW + spacing), spacing + section*(K_TetrisElementW + spacing), K_TetrisElementW, K_TetrisElementW);
            [image drawInRect:rect];
        }
    }
    for (NSDictionary *dic in arr) {
        NSInteger section = [dic[@"section"] integerValue];
        NSInteger row = [dic[@"row"] integerValue];
        [K_PublicInformation.elementImage drawInRect:CGRectMake(spacing + (spacing + K_TetrisElementW)*row, spacing + (spacing + K_TetrisElementW)*section, K_TetrisElementW, K_TetrisElementW)];
    }
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnImage;
}
- (UIImage *)prepareImage {
    CGFloat spacing = K_TetrisSpacing;
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PrepareImage" ofType:@"plist"]];
    CGFloat W = K_TetrisElementW*K_TetrisCount_H + spacing*(K_TetrisCount_H - 1) + spacing*2;
    CGFloat H = K_TetrisElementW*K_TetrisCount_V + spacing*(K_TetrisCount_V - 1) + spacing*2;
    UIGraphicsBeginImageContext(CGSizeMake(W, H));
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [K_TetrisBackColor setFill];
//    CGContextFillRect(context, CGRectMake(spacing, spacing, W - spacing*2, H - spacing*2));
//    UIImage *image = [ConFunc image:K_PublicInformation.elementImage andAlpha:0.2];
//    for (NSInteger section = 0; section < K_TetrisCount_V; section++) {
//        for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
//            CGRect rect = CGRectMake(spacing + row*(K_TetrisElementW + spacing), spacing + section*(K_TetrisElementW + spacing), K_TetrisElementW, K_TetrisElementW);
//            [image drawInRect:rect];
//        }
//    }
    for (NSDictionary *dic in arr) {
        NSInteger section = [dic[@"section"] integerValue];
        NSInteger row = [dic[@"row"] integerValue];
        [K_PublicInformation.elementImage drawInRect:CGRectMake(spacing + (spacing + K_TetrisElementW)*row, spacing + (spacing + K_TetrisElementW)*(section + 3), K_TetrisElementW, K_TetrisElementW)];//
    }
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnImage;
}
- (MainVM *)vm {
    if (_vm == nil) {
        _vm = [[MainVM alloc] init];
    }
    
    return _vm;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
+ (instancetype)controllerWithVM:(MainVM *)vm {
    return [[self alloc] initWithVM:vm];
}
- (instancetype)initWithVM:(MainVM *)vm {
    if (self = [super init]) {
        _vm = vm;
    }
    
    return self;
}

- (void)effectsAnimation {
    [UIView animateKeyframesWithDuration:1 delay:0.0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0 animations:^{
            self.prepareIV.alpha = 0.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0 animations:^{
            self.prepareIV.alpha = 1.0;
        }];
    } completion:^(BOOL finished) {
    }];
    [UIView animateKeyframesWithDuration:1 delay:0.0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0 animations:^{
            self.pauseIV.alpha = 0.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0 animations:^{
            self.pauseIV.alpha = 1.0;
        }];
    } completion:^(BOOL finished) {
    }];
    [UIView animateKeyframesWithDuration:2 delay:0.0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0 animations:^{
            self.overIV.alpha = 0.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0 animations:^{
            self.overIV.alpha = 1.0;
        }];
    } completion:^(BOOL finished) {
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden {
    return !self.vm.statusBarShow;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.vm.statusBarShow = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.vm.statusBarShow = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    [self effectsAnimation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUI];
    [self bindViewModel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(effectsAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (void)settingUI {
    UIImageView *backIV = [[UIImageView alloc] init];
    backIV.image = [UIImage imageNamed:@"tetris_back5"];
    [self.view addSubview:backIV];
    [backIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    CGFloat spacing = K_TetrisSpacing;
    UIView *screenV = [[UIView alloc] init];
    screenV.backgroundColor = [UIColor clearColor];//K_TetrisBackColor
    screenV.layer.borderWidth = 4;
    screenV.layer.borderColor = K_TetrisForeColor.CGColor;
    [self.view addSubview:screenV];
    self.screenV = screenV;
    [screenV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(K_StatusHeight);
        make.width.equalTo(@(K_TetrisElementW*K_TetrisCount_H + spacing*(K_TetrisCount_H - 1) + spacing*2 + K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2 + 21));
        make.height.equalTo(@(K_TetrisElementW*K_TetrisCount_V + spacing*(K_TetrisCount_V - 1) + spacing*2 + 14));
    }];
    
    UIView *boxV = [[UIView alloc] init];
    boxV.backgroundColor = [UIColor clearColor];//[UIColor whiteColor];
    [self.view insertSubview:boxV belowSubview:screenV];
    [boxV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(screenV).offset(-3);
        make.top.equalTo(screenV).offset(-3);
        make.right.equalTo(screenV).offset(3);
        make.bottom.equalTo(screenV).offset(3);
    }];
    
    TetrisV *tetrisV = [[TetrisV alloc] init];
    tetrisV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tetrisV];
    self.tetrisV = tetrisV;
    [tetrisV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(screenV).offset(7);
        make.top.equalTo(screenV).offset(7);
        make.width.equalTo(@(K_TetrisElementW*K_TetrisCount_H + spacing*(K_TetrisCount_H - 1) + spacing*2));
        make.height.equalTo(@(K_TetrisElementW*K_TetrisCount_V + spacing*(K_TetrisCount_V - 1) + spacing*2));
    }];
    
    UIImageView *prepareIV = [[UIImageView alloc] init];
    prepareIV.image = [self prepareImage];
    [self.view addSubview:prepareIV];
    self.prepareIV = prepareIV;
    [prepareIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV);
        make.right.equalTo(tetrisV);
        make.top.equalTo(tetrisV);
        make.bottom.equalTo(tetrisV);
    }];
    
    UIImageView *resetIV = [[UIImageView alloc] init];
    [self.view addSubview:resetIV];
    self.resetIV = resetIV;
    [resetIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV);
        make.right.equalTo(tetrisV);
        make.top.equalTo(tetrisV);
        make.bottom.equalTo(tetrisV);
    }];
    
    UIImageView *overIV = [[UIImageView alloc] init];
    overIV.image = [self overImage];
    [self.view addSubview:overIV];
    self.overIV = overIV;
    [overIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV);
        make.right.equalTo(tetrisV);
        make.top.equalTo(tetrisV);
        make.bottom.equalTo(tetrisV);
    }];
    
    UIFont *font = K_SystemFont(12*K_ScreenScale_Y);
    CGFloat height = 15*K_ScreenScale_Y;
    UILabel *nextL = [[UILabel alloc] init];
    nextL.text = @"下一个：";
    nextL.font = font;
    nextL.textColor = K_TetrisForeColor;
    [self.view addSubview:nextL];
    [nextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(tetrisV);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(spacing*2 + K_TetrisElementW*2));
    }];
    
    PreviewV *previewV = [[PreviewV alloc] init];
    [self.view addSubview:previewV];
    self.previewV = previewV;
    [previewV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(tetrisV).offset(2*(spacing + K_TetrisElementW));
        make.width.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
        make.height.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
    }];
    
    UILabel *modeVL = [[UILabel alloc] init];
    modeVL.text = @"模式：";
    modeVL.font = font;
    modeVL.textColor = K_TetrisForeColor;
    [self.view addSubview:modeVL];
    [modeVL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(previewV.mas_bottom).offset(K_TetrisElementW);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(height));
    }];
    
    UILabel *modeL = [[UILabel alloc] init];
    modeL.font = font;
    modeL.textColor = K_TetrisForeColor;
    modeL.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:modeL];
    self.modeL = modeL;
    [modeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(modeVL.mas_bottom).offset(0);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(height));
    }];
    
    UILabel *scoreVL = [[UILabel alloc] init];
    scoreVL.text = @"得分：";
    scoreVL.font = font;
    scoreVL.textColor = K_TetrisForeColor;
    [self.view addSubview:scoreVL];
    [scoreVL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(modeL.mas_bottom).offset(K_TetrisElementW);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(height));
    }];
    
    UILabel *scoreL = [[UILabel alloc] init];
    scoreL.font = font;
    scoreL.textColor = K_TetrisForeColor;
    scoreL.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:scoreL];
    self.scoreL = scoreL;
    [scoreL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(scoreVL.mas_bottom).offset(0);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(height));
    }];
    
    UILabel *highestVL = [[UILabel alloc] init];
    highestVL.text = @"最高分：";
    highestVL.font = font;
    highestVL.textColor = K_TetrisForeColor;
    [self.view addSubview:highestVL];
    [highestVL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(scoreL.mas_bottom).offset(K_TetrisElementW);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(height));
    }];
    
    UILabel *highestL = [[UILabel alloc] init];
    highestL.font = font;
    highestL.textColor = K_TetrisForeColor;
    highestL.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:highestL];
    self.highestL = highestL;
    [highestL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(highestVL.mas_bottom).offset(0);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(height));
    }];
    
    UILabel *speedVL = [[UILabel alloc] init];
    speedVL.text = @"速度：";
    speedVL.font = font;
    speedVL.textColor = K_TetrisForeColor;
    [self.view addSubview:speedVL];
    [speedVL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(highestL.mas_bottom).offset(K_TetrisElementW);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(height));
    }];
    
    UILabel *speedL = [[UILabel alloc] init];
    speedL.font = font;
    speedL.textColor = K_TetrisForeColor;
    speedL.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:speedL];
    self.speedL = speedL;
    [speedL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(speedVL.mas_bottom).offset(0);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(15));
    }];
    
//    UIImageView *soundIV = [[UIImageView alloc] init];
//    soundIV.image = K_PublicInformation.sound ? [UIImage imageNamed:@"Sound12"] : [UIImage imageNamed:@"Sound22"];
//    soundIV.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:soundIV];
//    self.soundIV = soundIV;
    CGFloat width = K_TetrisElementW*2 + spacing;
//    [soundIV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(tetrisV.mas_right).offset(5);
//        make.bottom.equalTo(tetrisV);
//        make.width.equalTo(@(width));
//        make.height.equalTo(@(width*soundIV.image.size.height/soundIV.image.size.width));
//    }];
//
//    UIImageView *pauseIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Paused2"]];
//    pauseIV.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:pauseIV];
//    self.pauseIV = pauseIV;
//    width += 5 + spacing;
//    [pauseIV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(screenV).offset(-7);
//        make.bottom.equalTo(tetrisV);
//        make.width.equalTo(@(width));
//        make.height.equalTo(@(width*soundIV.image.size.height/soundIV.image.size.width));
//    }];
    
    UIButton *pauseB = [VerticalButton buttonWithType:UIButtonTypeCustom];
    [pauseB setTitle:@"开始" forState:UIControlStateNormal];
    pauseB.titleLabel.font = font;
    [pauseB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pauseB.titleLabel.textAlignment = NSTextAlignmentCenter;
    [pauseB setImage:[UIImage imageNamed:@"tetris_red"] forState:UIControlStateNormal];
    [self.view addSubview:pauseB];
    self.pauseB = pauseB;
    width = K_TetrisElementW*2 + spacing;
    [pauseB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5 + spacing);
        make.bottom.equalTo(tetrisV);
        make.width.equalTo(@(width));
        make.height.equalTo(@(50*K_ScreenScale_X));
    }];
//    [pauseB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-44);
//        make.top.equalTo(boxV.mas_bottom).offset(10);
//        make.width.equalTo(@(30));
//        make.height.equalTo(@(50));
//    }];
    
    UIButton *resetB = [VerticalButton buttonWithType:UIButtonTypeCustom];
    [resetB setTitle:@"重置" forState:UIControlStateNormal];
    resetB.titleLabel.font = font;
    [resetB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    resetB.titleLabel.textAlignment = NSTextAlignmentCenter;
    [resetB setImage:[UIImage imageNamed:@"tetris_green"] forState:UIControlStateNormal];
    [self.view addSubview:resetB];
    self.resetB = resetB;
    [resetB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pauseB.mas_right).offset(spacing);
        make.bottom.equalTo(tetrisV);
        make.width.equalTo(pauseB);
        make.height.equalTo(pauseB);
    }];
//    [resetB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(pauseB.mas_left).offset(-15);
//        make.top.equalTo(boxV.mas_bottom).offset(10);
//        make.width.equalTo(@(30));
//        make.height.equalTo(@(50));
//    }];

    UIButton *soundB = [VerticalButton buttonWithType:UIButtonTypeCustom];
    [soundB setTitle:@"音效" forState:UIControlStateNormal];
    soundB.titleLabel.font = font;
    [soundB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    soundB.titleLabel.textAlignment = NSTextAlignmentCenter;
    [soundB setImage:[UIImage imageNamed:@"tetris_blue"] forState:UIControlStateNormal];
    [self.view addSubview:soundB];
    self.soundB = soundB;
    [soundB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pauseB);
        make.bottom.equalTo(pauseB.mas_top).offset(-5);
        make.width.equalTo(pauseB);
        make.height.equalTo(pauseB);
    }];
//    [soundB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(resetB.mas_left).offset(-15);
//        make.top.equalTo(boxV.mas_bottom).offset(10);
//        make.width.equalTo(@(30));
//        make.height.equalTo(@(50));
//    }];

    UIButton *setB = [VerticalButton buttonWithType:UIButtonTypeCustom];
    [setB setTitle:@"设置" forState:UIControlStateNormal];
    setB.titleLabel.font = font;
    [setB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    setB.titleLabel.textAlignment = NSTextAlignmentCenter;
    [setB setImage:[UIImage imageNamed:@"tetris_yellow"] forState:UIControlStateNormal];
    [self.view addSubview:setB];
    self.setB = setB;
    [setB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(resetB);
        make.bottom.equalTo(resetB.mas_top).offset(-5);
        make.width.equalTo(resetB);
        make.height.equalTo(resetB);
    }];
//    [setB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(soundB.mas_left).offset(-30);
//        make.top.equalTo(boxV.mas_bottom).offset(10);
//        make.width.equalTo(@(30));
//        make.height.equalTo(@(50));
//    }];
//
//    UIButton *upB = [UIButton buttonWithType:UIButtonTypeCustom];
//    [upB setTitle:@"U" forState:UIControlStateNormal];
//    [upB setBackgroundImage:[UIImage imageWithColor:[UIColor cyanColor]] forState:UIControlStateNormal];
//    [self.view addSubview:upB];
//    self.upB = upB;
//    [upB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(tetrisV);
//        make.top.equalTo(tetrisV.mas_bottom).offset(10);
//        make.width.equalTo(@(44));
//        make.height.equalTo(@(44));
//    }];
//
//    UIButton *lefB = [UIButton buttonWithType:UIButtonTypeCustom];
//    [lefB setBackgroundImage:[UIImage imageNamed:@"tetris_left"] forState:UIControlStateNormal];
//    [self.view addSubview:lefB];
//    self.leftB = lefB;
//    CGFloat W = K_Screen_Width >320 ? 44*K_ScreenScale_X : 44;
//    [lefB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(W);
//        make.top.equalTo(pauseB.mas_bottom).offset(K_Screen_Height <= 480 ? 10 : 44*K_ScreenScale_Y);
//        make.width.equalTo(@(W));
//        make.height.equalTo(@(W));
//    }];
//    UIButton *rightB = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightB setBackgroundImage:[UIImage imageNamed:@"tetris_right"] forState:UIControlStateNormal];
//    [self.view addSubview:rightB];
//    self.rightB = rightB;
//    [rightB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(lefB.mas_right).offset(W);
//        make.top.equalTo(lefB);
//        make.width.equalTo(@(W));
//        make.height.equalTo(@(W));
//    }];
//
//    UIButton *downB = [UIButton buttonWithType:UIButtonTypeCustom];
//    [downB setBackgroundImage:[UIImage imageNamed:@"tetris_down"] forState:UIControlStateNormal];
//    [self.view addSubview:downB];
//    self.downB = downB;
//    [downB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(lefB.mas_right);
//        make.top.equalTo(lefB.mas_bottom);
//        make.width.equalTo(@(W));
//        make.height.equalTo(@(W));
//    }];
//
//    UIButton *rotationB = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rotationB setBackgroundImage:[UIImage imageNamed:@"tetris_rotation"] forState:UIControlStateNormal];
//    [self.view addSubview:rotationB];
//    self.rotationB = rotationB;
//    [rotationB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-W);
//        make.top.equalTo(lefB).offset(10);
//        make.width.equalTo(@(66*K_ScreenScale_Y));
//        make.height.equalTo(@(66*K_ScreenScale_Y));
//    }];
}

static BOOL swiping = NO;
- (void)bindViewModel {
    @weakify(self);
    self.tetrisV.vm = self.vm.tetrisVM;
    self.previewV.vm = self.vm.previewVM;
    [RACObserve(self.vm.tetrisVM, score) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.scoreL.text = [NSString stringWithFormat:@"%li", self.vm.tetrisVM.score];
        if (self.vm.tetrisVM.score > K_PublicInformation.highestScore) {
            K_PublicInformation.highestScore = self.vm.tetrisVM.score;
        }
    }];
    [RACObserve(K_PublicInformation, highestScore) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.highestL.text = [NSString stringWithFormat:@"%li", K_PublicInformation.highestScore];
    }];
    [RACObserve(self.vm.tetrisVM, speed) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.speedL.text = [NSString stringWithFormat:@"%li", self.vm.tetrisVM.speed];
    }];
    [RACObserve(self.vm.tetrisVM, type) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.vm.tetrisVM.type == TetrisVMTypePaused) {
            [self.pauseB setTitle:@"继续" forState:UIControlStateNormal];
        } else if (self.vm.tetrisVM.type == TetrisVMTypePlaying) {
            [self.pauseB setTitle:@"暂停" forState:UIControlStateNormal];
        } else {
            [self.pauseB setTitle:@"开始" forState:UIControlStateNormal];
        }
        
        self.prepareIV.hidden = self.vm.tetrisVM.type != TetrisVMTypePrepare;
        self.pauseIV.hidden = self.vm.tetrisVM.type != TetrisVMTypePaused;
        self.overIV.hidden = self.vm.tetrisVM.type != TetrisVMTypeOver;
    }];
    self.pauseB.rac_command = self.vm.pauseCommand;
    [self.vm.pauseCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.vm.tetrisVM.type == TetrisVMTypePlaying) {
            [self.tetrisV pause];
        } else {
            [self.tetrisV start];
        }
        [SoundPlayer tetrisPhysicalSoundPlaying];
    }];
    self.resetB.rac_command = self.vm.resetCommand;
    [self.vm.resetCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (!self.resetIV.isAnimating) {
            if (!self.resetIV.animationImages) {
                [self.resetIV setAnimationImages:[self resetImages]];
                [self.resetIV setAnimationDuration:2];
                [self.resetIV setAnimationRepeatCount:1];
            }
            [self.resetIV startAnimating];
            [SoundPlayer tetrisNewSoundPlaying];
            [self.tetrisV reset];
        }
    }];
    self.soundB.rac_command = self.vm.soundCommand;
    [self.vm.soundCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        K_PublicInformation.sound = !K_PublicInformation.sound;
        self.soundIV.image = [UIImage imageNamed:K_PublicInformation.sound ? @"Sound12" : @"Sound22"];
        [SoundPlayer tetrisPhysicalSoundPlaying];
    }];
    self.setB.rac_command = self.vm.setCommand;
    [self.vm.setCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [SoundPlayer tetrisPhysicalSoundPlaying];
        SetViewController *nextCtr = [SetViewController controllerWithVM:[[SetVM alloc] init]];
        RAC(nextCtr.vm, tetrisVMType) = RACObserve(self.tetrisV.vm, type);
        [self.navigationController pushViewController:nextCtr animated:YES];
    }];
    
    UITapGestureRecognizer *tap = [self.view addTapWithBlock:^(UIView *view, UITapGestureRecognizer *tap) {
        @strongify(self);
        [self.tetrisV rotationShape];
        [SoundPlayer tetrisRotationSoundPlaying];
    }];
    
    UISwipeGestureRecognizer *downSwipe = [self.view addSwipeWithBlock:^(UIView *view, UISwipeGestureRecognizer *swipe) {
        swiping = YES;
        @strongify(self);
        do {
        } while ([self.tetrisV downMove]);
        swiping = NO;
    }];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    UIPanGestureRecognizer *pan = [self.view addPanWithBlock:^(UIView *view, UIPanGestureRecognizer *pan) {
        @strongify(self);
//        static CGPoint began;
//        static NSInteger beganX;
//        static BOOL beganed = NO;
//        CGPoint current = [pan locationInView:self.view];
//        NSInteger distance = (current.x - began.x)/10;
//        NSInteger moved = self.tetrisV.vm.location.row - beganX;
//        switch (pan.state) {
//            case UIGestureRecognizerStateBegan:
//            {
//                beganed = YES;
//                began = [pan locationInView:self.view];
//                beganX = self.tetrisV.vm.location.row;
//            }
//                break;
//            case UIGestureRecognizerStateChanged:
//            {
//                if (beganed && distance > 0 && moved + 1 < distance) {
//                    do {
//                        moved = self.tetrisV.vm.location.row - beganX;
//                    } while (moved + 1 < distance && [self.tetrisV rightMove]);
//                    began = [pan locationInView:self.view];
//                    beganX = self.tetrisV.vm.location.row;
//                } else if (beganed && distance < 0 && moved - 1 > distance) {
//                    do {
//                        moved = self.tetrisV.vm.location.row - beganX;
//                    } while (moved - 1 > distance && [self.tetrisV leftMove]);
//                    began = [pan locationInView:self.view];
//                    beganX = self.tetrisV.vm.location.row;
//                }
//            }
//                break;
//
//            default:
//            {
//                began = CGPointZero;
//                beganX = 0;
//                beganed = NO;
//            }
//                break;
//        }

        static CGPoint began;
        CGPoint current = [pan locationInView:self.view];
        NSInteger distance = 0;
        if (K_PublicInformation.tetrisType == TetrisTypeNormal) {
            distance = (int)((current.x - began.x)/10);
        } else if (K_PublicInformation.tetrisType == TetrisTypeReverse) {
            distance = (int)((began.x - current.x)/10);
        }
        switch (pan.state) {
            case UIGestureRecognizerStateBegan:
            {
                began = [pan locationInView:self.view];
            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                if (distance != 0) {
                    do {
                        began = [pan locationInView:self.view];
                        if (distance > 0) {
                            if (![self.tetrisV rightMove]) {
                                break;
                            }
                            distance--;
                        } else {
                            if (![self.tetrisV leftMove]) {
                                break;
                            }
                            distance++;
                        }
                    } while (distance != 0);
                }
            }
                break;

            default:
            {
                began = CGPointZero;
            }
                break;
        }
    }];
    [pan requireGestureRecognizerToFail:downSwipe];
    [pan requireGestureRecognizerToFail:tap];
    
    self.upB.rac_command = self.vm.upCommand;
    [self.vm.upCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tetrisV upMove];
    }];
    self.leftB.rac_command = self.vm.leftCommand;
    [self.vm.leftCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tetrisV leftMove];
        [SoundPlayer tetrisMoveSoundPlaying];
    }];
    self.rightB.rac_command = self.vm.rightCommand;
    [self.vm.rightCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tetrisV rightMove];
        [SoundPlayer tetrisMoveSoundPlaying];
    }];
    self.downB.rac_command = self.vm.downCommand;
    [self.vm.downCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        do {

        } while ([self.tetrisV downMove]);
    }];
    self.rotationB.rac_command = self.vm.rotationCommand;
    [self.vm.rotationCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tetrisV rotationShape];
        [SoundPlayer tetrisRotationSoundPlaying];
    }];
    
    [RACObserve(K_PublicInformation, tetrisType) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.vm.resetCommand execute:self.resetB];
        if (K_PublicInformation.tetrisType == TetrisTypeNormal) {
            self.tetrisV.transform = CGAffineTransformIdentity;
            self.modeL.text = @"经典";
        } else if (K_PublicInformation.tetrisType == TetrisTypeReverse) {
            self.tetrisV.transform = CGAffineTransformRotate(self.tetrisV.transform, M_PI);
            self.modeL.text = @"逆向";
        }
    }];
}


@end
