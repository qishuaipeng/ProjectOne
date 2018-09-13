//
//  ModeVM.h
//  Tetris
//
//  Created by QSP on 2018/9/12.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"
#import "QSPTableViewVM.h"
#import "CellM.h"

@interface ModeVM : BaseVM

@property (copy, nonatomic, readonly) NSString *title;
@property (assign, nonatomic) TetrisType tetrisType;
@property (assign, nonatomic) TetrisVMType tetrisVMType;
@property (strong, nonatomic, readonly) QSPTableViewVM *tableViewVM;

@end
