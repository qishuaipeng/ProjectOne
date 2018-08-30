//
//  TetrisVM.m
//  Tetris
//
//  Created by QSP on 2018/8/26.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "TetrisVM.h"

@interface TetrisVM ()

@end

@implementation TetrisVM
@synthesize sourceData = _sourceData;
@synthesize shapeM = _shapeM;

- (NSMutableArray<NSMutableArray<SourceM *> *> *)sourceData {
    if (_sourceData == nil) {
        _sourceData = [NSMutableArray arrayWithCapacity:1];
        for (NSInteger section = 0; section < K_TetrisCount_V; section++) {
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
            for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
                SourceM *sourceM = [[SourceM alloc] init];
                sourceM.section = section;
                sourceM.row = row;
                [arr addObject:sourceM];
            }
            [_sourceData addObject:arr];
        }
    }
    
    return _sourceData;
}
- (ShapeM *)shapeM {
    if (_shapeM == nil) {
        _shapeM = [ShapeM randomShape];
    }
    
    return _shapeM;
}
- (instancetype)init {
    if (self = [super init]) {
        self.type = TetrisVMTypePrepare;
        self.score = 0;
        self.speed = 1;
        self.location = [NSIndexPath indexPathForRow:3 inSection:-self.shapeM.first.section];
    }
    
    return self;
}

@end
