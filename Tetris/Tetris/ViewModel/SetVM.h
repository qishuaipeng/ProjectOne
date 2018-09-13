//
//  SetVM.h
//  Tetris
//
//  Created by QSP on 2018/9/2.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"
#import "QSPTableViewVM.h"

@interface SetVM : BaseVM

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) TetrisVMType tetrisVMType;
@property (strong, nonatomic) QSPTableViewVM *tableViewVM;
@property (assign, nonatomic) BOOL statusBarHidden;

@end
