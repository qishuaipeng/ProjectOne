//
//  TetrisV.h
//  Tetris
//
//  Created by QSP on 2018/8/26.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TetrisVM.h"

@interface TetrisV : UIView

@property (strong, nonatomic) TetrisVM *vm;

+ (instancetype)tetrisVWithVM:(TetrisVM *)vm;
- (instancetype)initWithVM:(TetrisVM *)vm;

- (void)rotationShape;
- (BOOL)upMove;
- (BOOL)leftMove;
- (BOOL)rightMove;
- (BOOL)downMove;
- (void)start;
- (void)pause;
- (void)newStart;
- (void)reset;

@end
