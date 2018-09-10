//
//  SelectVM.m
//  Tetris
//
//  Created by QSP on 2018/9/6.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "SelectVM.h"
#import "SetTableViewCell.h"

@implementation SelectVM


+ (instancetype)selectVMWithM:(CellM *)model {
    return [[self alloc] initWithM:model];
}
- (instancetype)initWithM:(CellM *)model {
    if (self = [super init]) {
        self.model = model;
    }
    
    return self;
}
- (void)setModel:(CellM *)model {
    _model = model;
    if (model) {
        _title = model.title;
        _tableViewVM = [QSPTableViewVM create:^(QSPTableViewVM *vm) {
            vm.cellClassSet(SetTableViewCell.class).sectionHeaderColorSet(K_ControllerView_Color).sectionHeaderHeightSet(10).addQSPSectionVMCreate(^(QSPTableViewSectionVM *sectionVM){
                sectionVM.addQSPRowVMCreate(^(QSPTableViewCellVM *cellVM){
                    cellVM.dataMCreate(CellM.class, ^(CellM *theM){
                        theM.title = model.subTitle;
                    });
                });
            });
        }];
    }
}

@end
