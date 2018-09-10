//
//  SelectVM.h
//  Tetris
//
//  Created by QSP on 2018/9/6.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"
#import "CellM.h"
#import "QSPTableViewVM.h"

@interface SelectVM : BaseVM

@property (copy, nonatomic, readonly) NSString *title;
@property (strong, nonatomic) CellM *model;
@property (strong, nonatomic, readonly) QSPTableViewVM *tableViewVM;

+ (instancetype)selectVMWithM:(CellM *)model;
- (instancetype)initWithM:(CellM *)model;

@end
