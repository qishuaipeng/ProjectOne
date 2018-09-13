//
//  ModeVM.m
//  Tetris
//
//  Created by QSP on 2018/9/12.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "ModeVM.h"
#import "ModeTableViewCell.h"

@implementation ModeVM

- (instancetype)init {
    if (self = [super init]) {
        _title = @"模式";
        _tableViewVM = [QSPTableViewVM create:^(QSPTableViewVM *vm) {
            vm.cellClassSet(ModeTableViewCell.class).sectionHeaderColorSet(K_ControllerView_Color).sectionHeaderHeightSet(10).addQSPSectionVMCreate(^(QSPTableViewSectionVM *sectionVM){
                sectionVM.addQSPRowVMCreate(^(QSPTableViewCellVM *cellVM){
                    cellVM.dataMCreate(CellM.class, ^(CellM *model){
                        model.title = @"逆向";
                        model.selected = K_PublicInformation.tetrisType == TetrisTypeReverse;
                    });
                });
                sectionVM.addQSPRowVMCreate(^(QSPTableViewCellVM *cellVM){
                    cellVM.dataMCreate(CellM.class, ^(CellM *model){
                        model.title = @"经典";
                        model.selected = K_PublicInformation.tetrisType == TetrisTypeNormal;
                    });
                });
            });
        }];
    }
    CellM *cellM = (CellM *)[self.tableViewVM rowVMWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].dataM;
    [RACObserve(cellM, selected) subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            QSPTableViewCellVM *theVM = [self.tableViewVM rowVMWithIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            CellM *theM = theVM.dataM;
            theM.selected = NO;
        }
    }];
    cellM = (CellM *)[self.tableViewVM rowVMWithIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].dataM;
    [RACObserve(cellM, selected) subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            QSPTableViewCellVM *theVM = [self.tableViewVM rowVMWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            CellM *theM = theVM.dataM;
            theM.selected = NO;
        }
    }];
    self.tetrisType = K_PublicInformation.tetrisType;
    
    return self;
}

@end
