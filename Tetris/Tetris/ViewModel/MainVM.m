//
//  MainVM.m
//  MiningInterestingly
//
//  Created by QSP on 2018/8/16.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "MainVM.h"

@implementation MainVM

- (instancetype)init {
    if (self = [super init]) {
        _tetrisVM = [[TetrisVM alloc] init];
        _previewVM = [[PreviewVM alloc] init];
        self.previewVM.shapeM = self.tetrisVM.shapeM;
        RAC(self.previewVM, type) = RACObserve(self.tetrisVM, type);
        _pauseCommand = [self emptyCommand];
        _upCommand = [self emptyCommand];
        _leftCommand = [self emptyCommand];
        _rightCommand = [self emptyCommand];
        _downCommand = [self emptyCommand];
        _rotationCommand = [self emptyCommand];
    }
    
    return self;
}

@end
