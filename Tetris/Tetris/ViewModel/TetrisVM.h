//
//  TetrisVM.h
//  Tetris
//
//  Created by QSP on 2018/8/26.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"
#import "ShapeM.h"
#import "SourceM.h"

@interface TetrisVM : BaseVM

@property (strong, nonatomic, readonly) NSMutableArray<NSMutableArray<SourceM *> *> *sourceData;
@property (strong, nonatomic, readonly) ShapeM *shapeM;
@property (assign, nonatomic) BOOL removeAnimating;//是否正在执行消除动画
@property (assign, nonatomic) TetrisVMType type;
@property (strong, nonatomic) NSIndexPath *location;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) NSInteger speed;

@end
