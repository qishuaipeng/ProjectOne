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

@interface VerticalButton : UIButton


@end

@implementation VerticalButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, contentRect.size.width, contentRect.size.width, contentRect.size.height - contentRect.size.width);
}

@end

@interface MainViewController ()

@property (strong, nonatomic) MainVM *vm;
@property (weak, nonatomic) UIView *screenV;
@property (weak, nonatomic) TetrisV *tetrisV;
@property (weak, nonatomic) UILabel *scoreL;
@property (weak, nonatomic) UILabel *highestL;
@property (weak, nonatomic) UILabel *speedL;
@property (weak, nonatomic) PreviewV *previewV;
@property (weak, nonatomic) UIButton *resetB;
@property (weak, nonatomic) UIButton *soundB;
@property (weak, nonatomic) UIButton *setB;
@property (weak, nonatomic) UIButton *pauseB;
@property (weak, nonatomic) UIButton *upB;
@property (weak, nonatomic) UIButton *leftB;
@property (weak, nonatomic) UIButton *rightB;
@property (weak, nonatomic) UIButton *downB;
@property (weak, nonatomic) UIButton *rotationB;

@end

@implementation MainViewController

- (MainVM *)vm {
    if (_vm == nil) {
        _vm = [[MainVM alloc] init];
    }
    
    return _vm;
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

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUI];
    [self bindViewModel];
}
- (void)settingUI {
    UIImageView *backIV = [[UIImageView alloc] init];
    backIV.image = [UIImage imageNamed:@"tetris_back"];
    [self.view addSubview:backIV];
    [backIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    CGFloat spacing = K_TetrisSpacing;
    UIView *screenV = [[UIView alloc] init];
    screenV.backgroundColor = K_TetrisBackColor;
    screenV.layer.borderWidth = 4;
    screenV.layer.borderColor = K_TetrisForeColor.CGColor;
    [self.view addSubview:screenV];
    self.screenV = screenV;
    [screenV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(20 + K_StatusMoreHeight);
        make.width.equalTo(@(K_TetrisElementW*K_TetrisCount_H + spacing*(K_TetrisCount_H - 1) + spacing*2 + K_TetrisElementW*4 + spacing*(4 - 1) + spacing*4 + 17));
        make.height.equalTo(@(K_TetrisElementW*K_TetrisCount_V + spacing*(K_TetrisCount_V - 1) + spacing*4 + 10));
    }];
    
    UIView *boxV = [[UIView alloc] init];
    boxV.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:boxV belowSubview:screenV];
    [boxV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(screenV).offset(-3);
        make.top.equalTo(screenV).offset(-3);
        make.right.equalTo(screenV).offset(3);
        make.bottom.equalTo(screenV).offset(3);
    }];
    
    TetrisV *tetrisV = [[TetrisV alloc] init];
    [self.view addSubview:tetrisV];
    self.tetrisV = tetrisV;
    [tetrisV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(screenV).offset(7);
        make.top.equalTo(screenV).offset(7);
        make.width.equalTo(@(K_TetrisElementW*K_TetrisCount_H + spacing*(K_TetrisCount_H - 1) + spacing*2));
        make.height.equalTo(@(K_TetrisElementW*K_TetrisCount_V + spacing*(K_TetrisCount_V - 1) + spacing*2));
    }];
    
    UIFont *font = K_SystemFont(12);
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
    
    UILabel *scoreVL = [[UILabel alloc] init];
    scoreVL.text = @"得分：";
    scoreVL.font = font;
    scoreVL.textColor = K_TetrisForeColor;
    [self.view addSubview:scoreVL];
    [scoreVL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(previewV.mas_bottom).offset(spacing + K_TetrisElementW);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(15));
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
        make.height.equalTo(@(15));
    }];
    
    UILabel *highestVL = [[UILabel alloc] init];
    highestVL.text = @"最高分：";
    highestVL.font = font;
    highestVL.textColor = K_TetrisForeColor;
    [self.view addSubview:highestVL];
    [highestVL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(scoreL.mas_bottom).offset(spacing + K_TetrisElementW);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(15));
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
        make.height.equalTo(@(15));
    }];
    
    UILabel *speedVL = [[UILabel alloc] init];
    speedVL.text = @"速度：";
    speedVL.font = font;
    speedVL.textColor = K_TetrisForeColor;
    [self.view addSubview:speedVL];
    [speedVL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tetrisV.mas_right).offset(5);
        make.top.equalTo(highestL.mas_bottom).offset(spacing + K_TetrisElementW);
        make.right.equalTo(screenV).offset(-7);
        make.height.equalTo(@(15));
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
    
    UIButton *pauseB = [VerticalButton buttonWithType:UIButtonTypeCustom];
    [pauseB setTitle:@"开始" forState:UIControlStateNormal];
    pauseB.titleLabel.font = K_SystemFont(12);
    pauseB.titleLabel.textAlignment = NSTextAlignmentCenter;
    [pauseB setImage:[UIImage imageNamed:@"tetris_red"] forState:UIControlStateNormal];
    [self.view addSubview:pauseB];
    self.pauseB = pauseB;
    [pauseB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-44);
        make.top.equalTo(boxV.mas_bottom).offset(10);
        make.width.equalTo(@(30));
        make.height.equalTo(@(50));
    }];
    
    UIButton *resetB = [VerticalButton buttonWithType:UIButtonTypeCustom];
    [resetB setTitle:@"重置" forState:UIControlStateNormal];
    resetB.titleLabel.font = K_SystemFont(12);
    resetB.titleLabel.textAlignment = NSTextAlignmentCenter;
    [resetB setImage:[UIImage imageNamed:@"tetris_green"] forState:UIControlStateNormal];
    [self.view addSubview:resetB];
    self.resetB = resetB;
    [resetB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pauseB.mas_left).offset(-15);
        make.top.equalTo(boxV.mas_bottom).offset(10);
        make.width.equalTo(@(30));
        make.height.equalTo(@(50));
    }];
    
    UIButton *soundB = [VerticalButton buttonWithType:UIButtonTypeCustom];
    [soundB setTitle:@"音效" forState:UIControlStateNormal];
    soundB.titleLabel.font = K_SystemFont(12);
    soundB.titleLabel.textAlignment = NSTextAlignmentCenter;
    [soundB setImage:[UIImage imageNamed:@"tetris_blue"] forState:UIControlStateNormal];
    [self.view addSubview:soundB];
    self.soundB = soundB;
    [soundB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(resetB.mas_left).offset(-15);
        make.top.equalTo(boxV.mas_bottom).offset(10);
        make.width.equalTo(@(30));
        make.height.equalTo(@(50));
    }];
    
    UIButton *setB = [VerticalButton buttonWithType:UIButtonTypeCustom];
    [setB setTitle:@"设置" forState:UIControlStateNormal];
    setB.titleLabel.font = K_SystemFont(12);
    setB.titleLabel.textAlignment = NSTextAlignmentCenter;
    [setB setImage:[UIImage imageNamed:@"tetris_yellow"] forState:UIControlStateNormal];
    [self.view addSubview:setB];
    self.setB = setB;
    [setB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(soundB.mas_left).offset(-30);
        make.top.equalTo(boxV.mas_bottom).offset(10);
        make.width.equalTo(@(30));
        make.height.equalTo(@(50));
    }];
    
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
    
    UIButton *lefB = [UIButton buttonWithType:UIButtonTypeCustom];
    [lefB setBackgroundImage:[UIImage imageNamed:@"tetris_left"] forState:UIControlStateNormal];
    [self.view addSubview:lefB];
    self.leftB = lefB;
    [lefB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(44);
        make.top.equalTo(pauseB.mas_bottom).offset(K_Screen_Height <= 480 ? 10 : 44*K_ScreenScale_Y);
        make.width.equalTo(@(44));
        make.height.equalTo(@(44));
    }];
    UIButton *rightB = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightB setBackgroundImage:[UIImage imageNamed:@"tetris_right"] forState:UIControlStateNormal];
    [self.view addSubview:rightB];
    self.rightB = rightB;
    [rightB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lefB.mas_right).offset(44);
        make.top.equalTo(lefB);
        make.width.equalTo(@(44));
        make.height.equalTo(@(44));
    }];
    
    UIButton *downB = [UIButton buttonWithType:UIButtonTypeCustom];
    [downB setBackgroundImage:[UIImage imageNamed:@"tetris_down"] forState:UIControlStateNormal];
    [self.view addSubview:downB];
    self.downB = downB;
    [downB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lefB.mas_right);
        make.top.equalTo(lefB.mas_bottom);
        make.width.equalTo(@(44));
        make.height.equalTo(@(44));
    }];
    
    UIButton *rotationB = [UIButton buttonWithType:UIButtonTypeCustom];
    [rotationB setBackgroundImage:[UIImage imageNamed:@"tetris_rotation"] forState:UIControlStateNormal];
    [self.view addSubview:rotationB];
    self.rotationB = rotationB;
    [rotationB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-44);
        make.top.equalTo(lefB).offset(10);
        make.width.equalTo(@(66));
        make.height.equalTo(@(66));
    }];
}
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
        if (self.vm.tetrisVM.type == TetrisVMTypePlaying) {
            [self.pauseB setTitle:@"暂停" forState:UIControlStateNormal];
        } else if (self.vm.tetrisVM.type == TetrisVMTypePaused) {
            [self.pauseB setTitle:@"开始" forState:UIControlStateNormal];
        } else {
            [self.pauseB setTitle:@"开始" forState:UIControlStateNormal];
        }
    }];
    self.pauseB.rac_command = self.vm.pauseCommand;
    [self.vm.pauseCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.vm.tetrisVM.type == TetrisVMTypePlaying) {
            [self.tetrisV pause];
        } else {
            [self.tetrisV start];
        }
    }];
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
    }];
}

@end
