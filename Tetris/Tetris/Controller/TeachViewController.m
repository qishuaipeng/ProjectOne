//
//  TeachViewController.m
//  Tetris
//
//  Created by QSP on 2018/9/10.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "TeachViewController.h"
#import "PreviewV.h"
#import "AppDelegate.h"

@interface TeachViewController ()

@property (weak, nonatomic) UIButton *closeB;
@property (weak, nonatomic) PreviewV *previewV;
@property (weak, nonatomic) UIButton *nextB;
@property (weak, nonatomic) UIButton *lastB;
@property (weak, nonatomic) UILabel *disL;
@property (weak, nonatomic) UIImageView *iconIV;

@end

@implementation TeachViewController

+ (instancetype)controllerWithVM:(TeachVM *)vm {
    return [[self alloc] initWithVM:vm];
}
- (instancetype)initWithVM:(TeachVM *)vm {
    if (self = [super init]) {
        _vm = vm;
    }
    
    return self;
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
    UIButton *closeB = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeB setTitle:@"跳过" forState:UIControlStateNormal];
    closeB.titleLabel.font = K_SystemFont(12*K_ScreenScale_X);
    [closeB setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:closeB];
    self.closeB = closeB;
    CGSize size = [closeB.currentTitle sizeWithWidth:CGFLOAT_MAX andFont:closeB.titleLabel.font];
    [closeB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(K_StatusMoreHeight + 10);
        make.width.equalTo(@(size.width + 2));
        make.height.equalTo(@(size.height + 10));
    }];
    
    CGFloat spacing = K_TetrisSpacing;
    PreviewV *previewV = [[PreviewV alloc] init];
    [self.view addSubview:previewV];
    self.previewV = previewV;
    [previewV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(closeB.mas_bottom).offset(10);
        make.width.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
        make.height.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
    }];
    
    UIButton *nextB = [UIButton buttonWithType:UIButtonTypeCustom];
    nextB.titleLabel.font = K_SystemFont(12*K_ScreenScale_X);
    [nextB setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [nextB setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:nextB];
    self.nextB = nextB;
    size = [nextB.currentTitle sizeWithWidth:CGFLOAT_MAX andFont:nextB.titleLabel.font];
    [nextB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-K_TabBarMoreHeight - 10);
        make.width.equalTo(@(size.width + 2));
        make.height.equalTo(@(size.height + 10));
    }];
    
    UIButton *lastB = [UIButton buttonWithType:UIButtonTypeCustom];
    lastB.titleLabel.font = K_SystemFont(12*K_ScreenScale_X);
    [lastB setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [lastB setTitle:@"上一步" forState:UIControlStateNormal];
    [self.view addSubview:lastB];
    self.lastB = lastB;
    size = [lastB.currentTitle sizeWithWidth:CGFLOAT_MAX andFont:lastB.titleLabel.font];
    [lastB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(-K_TabBarMoreHeight - 10);
        make.width.equalTo(@(size.width + 2));
        make.height.equalTo(@(size.height + 10));
    }];
    
    UILabel *disL = [[UILabel alloc] init];
    disL.font = K_SystemFont(15*K_ScreenScale_X);
    disL.textColor = [UIColor blackColor];
    disL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:disL];
    self.disL = disL;
    [disL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-K_TabBarHeight);
        make.height.equalTo(@(K_TabBarHeight));
    }];

    UIImageView *iconIV = [[UIImageView alloc] init];
    [self.view addSubview:iconIV];
    self.iconIV = iconIV;
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(disL.mas_top);
        make.width.equalTo(@(K_Screen_Width/3));
        make.height.equalTo(iconIV.mas_width);
    }];
}
- (void)bindViewModel {
    @weakify(self);
    self.closeB.rac_command = self.vm.closeCommand;
    [self.vm.closeCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        } else {
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate gotoMainController];
        }
    }];
    
    self.previewV.vm = self.vm.previewVM;
    [self.previewV reload];
    
    self.lastB.rac_command = self.vm.lastCommand;
    [self.vm.lastCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    if (self.navigationController.viewControllers.count == 1) {
        self.lastB.hidden = YES;
    } else if (self.navigationController.viewControllers.count == 3) {
        self.nextB.hidden = YES;
    }
    
    self.nextB.rac_command = self.vm.nextCommand;
    [self.vm.nextCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        switch (self.vm.type) {
            case TeachVMTypeTap:
            {
                TeachViewController *nextCtr = [TeachViewController controllerWithVM:[TeachVM teachVMWithType:TeachVMTypePan]];
                [self.navigationController pushViewController:nextCtr animated:YES];
            }
                break;
            case TeachVMTypePan:
            {
                TeachVMType type;
                if (K_PublicInformation.tetrisType == TetrisTypeReverse) {
                    type = TeachVMTypeSwipeUp;
                } else {
                    type = TeachVMTypeSwipeDown;
                }
                TeachViewController *nextCtr = [TeachViewController controllerWithVM:[TeachVM teachVMWithType:type]];
                [self.navigationController pushViewController:nextCtr animated:YES];
            }
                break;
            case TeachVMTypeSwipeDown:
            {
                [self resetPreview];
                self.nextB.hidden = YES;
            }
                break;
            case TeachVMTypeSwipeUp:
            {
                [self resetPreview];
                self.nextB.hidden = YES;
            }
                break;
                
            default:
                break;
        }
    }];
    
    CGFloat spacing = K_TetrisSpacing;
    switch (self.vm.type) {
        case TeachVMTypeTap:
        {
            self.disL.text = @"点击屏幕可以旋转";
            self.iconIV.image = [UIImage imageNamed:@"tetris_tap"];
            [self.view addTapWithBlock:^(UIView *view, UITapGestureRecognizer *tap) {
                @strongify(self);
                [self.vm.previewVM.shapeM rotationNext];
                [self.previewV reload];
            }];
        }
            break;
        case TeachVMTypePan:
        {
            self.disL.text = @"拖曳可以移动";
            self.iconIV.image = [UIImage imageNamed:@"tetris_pan"];
            [self.view addPanWithBlock:^(UIView *view, UIPanGestureRecognizer *pan) {
                @strongify(self);
                static CGPoint began;
                static CGFloat beganCenterX = 0;
                CGPoint current = [pan locationInView:self.view];
                NSInteger distance = (int)((current.x - began.x)/10);
                switch (pan.state) {
                    case UIGestureRecognizerStateBegan:
                    {
                        began = [pan locationInView:self.view];
                        beganCenterX = self.previewV.centerX;
                    }
                        break;
                    case UIGestureRecognizerStateChanged:
                    {
                        if (distance != 0) {
                            do {
                                began = [pan locationInView:self.view];
                                CGFloat X = distance > 0 ? self.previewV.frameRight + spacing + K_TetrisElementW : self.previewV.frameX - spacing - K_TetrisElementW;
                                if (X < 0 || X > K_Screen_Width) {
                                    break;
                                }
                                
                                [self.previewV mas_updateConstraints:^(MASConstraintMaker *make) {
                                    make.centerX.equalTo(self.view).offset(beganCenterX - self.view.centerX + (spacing + K_TetrisElementW)*(distance > 0 ? 1 : -1));
                                }];
                                [self.previewV.superview layoutIfNeeded];
                                beganCenterX = self.previewV.centerX;
                                
                                if (distance > 0) {
                                    distance--;
                                } else {
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
        }
            break;
        case TeachVMTypeSwipeDown:
        {
            self.disL.text = @"向下轻扫可以快速降落";
            self.iconIV.image = [UIImage imageNamed:@"tetris_swipe_down"];
            [self.nextB setTitle:@"复位" forState:UIControlStateNormal];
            [self.nextB mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@([self.nextB.currentTitle sizeWithWidth:CGFLOAT_MAX andFont:self.nextB.titleLabel.font].width + 2));
            }];
            UISwipeGestureRecognizer *swipe = [self.view addSwipeWithBlock:^(UIView *view, UISwipeGestureRecognizer *swipe) {
                @strongify(self);
                [self.previewV mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.view);
                    make.bottom.equalTo(self.iconIV.mas_top).offset(10);
                    make.width.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
                    make.height.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
                }];
                self.nextB.hidden = NO;
                [self.closeB setTitle:@"完成" forState:UIControlStateNormal];
            }];
            swipe.direction = UISwipeGestureRecognizerDirectionDown;
        }
            break;
        case TeachVMTypeSwipeUp:
        {
            self.disL.text = @"向上轻扫可以快速上升";
            self.iconIV.image = [UIImage imageNamed:@"tetris_swipe_up"];
            [self.nextB setTitle:@"复位" forState:UIControlStateNormal];
            [self.nextB mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@([self.nextB.currentTitle sizeWithWidth:CGFLOAT_MAX andFont:self.nextB.titleLabel.font].width + 2));
            }];
            [self.previewV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view);
                make.bottom.equalTo(self.iconIV.mas_top).offset(10);
                make.width.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
                make.height.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
            }];
            UISwipeGestureRecognizer *swipe = [self.view addSwipeWithBlock:^(UIView *view, UISwipeGestureRecognizer *swipe) {
                @strongify(self);
                [self.previewV mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.view);
                    make.top.equalTo(self.closeB.mas_bottom).offset(10);
                    make.width.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
                    make.height.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
                }];
                self.nextB.hidden = NO;
                [self.closeB setTitle:@"完成" forState:UIControlStateNormal];
            }];
            swipe.direction = UISwipeGestureRecognizerDirectionUp;
        }
            break;
            
        default:
            break;
    }
}
- (void)resetPreview {
    CGFloat spacing = K_TetrisSpacing;
    if (K_PublicInformation.tetrisType == TetrisTypeNormal) {
        [self.previewV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.closeB.mas_bottom).offset(10);
            make.width.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
            make.height.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
        }];
    } else if (K_PublicInformation.tetrisType == TetrisTypeReverse) {
        [self.previewV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.iconIV.mas_top).offset(10);
            make.width.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
            make.height.equalTo(@(K_TetrisElementW*4 + spacing*(4 - 1) + spacing*2));
        }];
    }
}

@end
