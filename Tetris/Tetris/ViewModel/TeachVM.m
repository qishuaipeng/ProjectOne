//
//  TeachVM.m
//  Tetris
//
//  Created by QSP on 2018/9/10.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "TeachVM.h"

@implementation TeachVM

- (instancetype)init {
    if (self = [super init]) {
        _lastCommand = [self emptyCommand];
        _nextCommand = [self emptyCommand];
        _closeCommand = [self emptyCommand];
        _previewVM = [[PreviewVM alloc] init];
        self.previewVM.showBack = NO;
        [self.previewVM.shapeM changedNextWithType:ShapeMType3 andDirection:ShapeMDirectionLeft];
    }
    
    return self;
}

+ (instancetype)teachVMWithType:(TeachVMType)type {
    return [[self alloc] initWithType:type];
}
- (instancetype)initWithType:(TeachVMType)type {
    if (self = [self init]) {
        self.type = type;
    }
    
    return self;
}

@end
