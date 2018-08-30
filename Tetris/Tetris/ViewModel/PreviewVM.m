//
//  PreviewVM.m
//  Tetris
//
//  Created by QSP on 2018/8/28.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "PreviewVM.h"

@implementation PreviewVM

- (instancetype)init {
    if (self = [super init]) {
        self.count = K_Tetris_PreviewCount;
        self.shapeM = [ShapeM randomShape];
    }
    
    return self;
}

@end
