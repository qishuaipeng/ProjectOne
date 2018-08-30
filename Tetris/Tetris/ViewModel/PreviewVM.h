//
//  PreviewVM.h
//  Tetris
//
//  Created by QSP on 2018/8/28.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"
#import "ShapeM.h"

@interface PreviewVM : BaseVM

@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) ShapeM *shapeM;
@property (assign, nonatomic) TetrisVMType type;

@end
