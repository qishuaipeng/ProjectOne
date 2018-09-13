//
//  PreviewV.m
//  Tetris
//
//  Created by QSP on 2018/8/28.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "PreviewV.h"
#import "ElementV.h"

@interface PreviewV ()

@property (weak, nonatomic) ElementV *firstV;
@property (weak, nonatomic) ElementV *secondV;
@property (weak, nonatomic) ElementV *thirdV;
@property (weak, nonatomic) ElementV *fourthV;

@end

@implementation PreviewV

- (void)setVm:(PreviewVM *)vm {
    _vm = vm;
    [self bindViewModel];
}
- (ElementV *)firstV {
    if (_firstV == nil) {
        ElementV *view = [[ElementV alloc] init];
        [self addSubview:view];
        _firstV = view;
    }
    
    return _firstV;
}
- (ElementV *)secondV {
    if (_secondV == nil) {
        ElementV *view = [[ElementV alloc] init];
        [self addSubview:view];
        _secondV = view;
    }
    
    return _secondV;
}
- (ElementV *)thirdV {
    if (_thirdV == nil) {
        ElementV *view = [[ElementV alloc] init];
        [self addSubview:view];
        _thirdV = view;
    }
    
    return _thirdV;
}
- (ElementV *)fourthV {
    if (_fourthV == nil) {
        ElementV *view = [[ElementV alloc] init];
        [self addSubview:view];
        _fourthV = view;
    }
    
    return _fourthV;
}

- (void)dealloc {
    [K_Default_NotificationCenter removeObserver:self];
}
- (instancetype)initWithFrame:(CGRect)frame {
    CGFloat spacing = K_TetrisSpacing;
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, K_TetrisElementW*K_Tetris_PreviewCount + spacing*(K_Tetris_PreviewCount - 1) + spacing*2, K_TetrisElementW*K_Tetris_PreviewCount + spacing*(K_Tetris_PreviewCount - 1) + spacing*2)]) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}
- (void)drawRect:(CGRect)rect {
    if (self.vm.showBack) {
        CGFloat spacing = K_TetrisSpacing;
        UIImage *image = [ConFunc image:K_PublicInformation.elementImage andAlpha:0.2];
        for (NSInteger section = 0; section < K_Tetris_PreviewCount; section++) {
            for (NSInteger row = 0; row < K_Tetris_PreviewCount; row++) {
                CGRect rect = CGRectMake(spacing + row*(K_TetrisElementW + spacing), spacing + section*(K_TetrisElementW + spacing), K_TetrisElementW, K_TetrisElementW);
                [image drawInRect:rect];
            }
        }
    }
}

- (void)bindViewModel {
    [K_Default_NotificationCenter addObserver:self selector:@selector(nextAction:) name:K_ShapeM_NextNotificationName object:self.vm.shapeM];
    [self nextAction:nil];
    @weakify(self);
    [RACObserve(self.vm, type) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self nextAction:nil];
    }];
    [RACObserve(self.vm, showBack) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self setNeedsDisplay];
    }];
}
- (void)nextAction:(NSNotification *)sender {
    if (self.vm.type == TetrisVMTypePaused || self.vm.type == TetrisVMTypePlaying) {
        [self reload];
    }
}
- (void)reload {
    CGFloat spacing = K_TetrisSpacing;
    NSIndexPath *indexPath = [self.vm.shapeM indexPathOfNextWithIndex:0];
    NSIndexPath *location = [NSIndexPath indexPathForRow:0 inSection:-indexPath.section];
    self.firstV.frameX = spacing + (location.row + indexPath.row)*(spacing + K_TetrisElementW);
    self.firstV.frameY = spacing + (location.section + indexPath.section)*(spacing + K_TetrisElementW);
    indexPath = [self.vm.shapeM indexPathOfNextWithIndex:1];
    self.secondV.frameX = spacing + (location.row + indexPath.row)*(spacing + K_TetrisElementW);
    self.secondV.frameY = spacing + (location.section + indexPath.section)*(spacing + K_TetrisElementW);
    indexPath = [self.vm.shapeM indexPathOfNextWithIndex:2];
    self.thirdV.frameX = spacing + (location.row + indexPath.row)*(spacing + K_TetrisElementW);
    self.thirdV.frameY = spacing + (location.section + indexPath.section)*(spacing + K_TetrisElementW);
    indexPath = [self.vm.shapeM indexPathOfNextWithIndex:3];
    self.fourthV.frameX = spacing + (location.row + indexPath.row)*(spacing + K_TetrisElementW);
    self.fourthV.frameY = spacing + (location.section + indexPath.section)*(spacing + K_TetrisElementW);
}

@end
