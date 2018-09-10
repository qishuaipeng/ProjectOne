//
//  SetVM.m
//  Tetris
//
//  Created by QSP on 2018/9/2.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "SetVM.h"
#import "CellM.h"
#import "SetTableViewCell.h"

@implementation SetVM

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"设置";
        self.statusBarHidden = NO;
        self.tableViewVM = [QSPTableViewVM create:^(QSPTableViewVM *vm) {
            vm.cellClassSet(SetTableViewCell.class).sectionHeaderColorSet(K_ControllerView_Color).sectionHeaderHeightSet(10).addQSPSectionVMCreate(^(QSPTableViewSectionVM *sectionVM){
                sectionVM.addQSPRowVMCreate(^(QSPTableViewCellVM *cellVM){
                    cellVM.dataMCreate(CellM.class, ^(CellM *model){
                        model.title = @"模式";
                        model.icon = @"mode";
                        model.subTitle = @"经典";
                        model.arrow = YES;
                    });
                }).addQSPRowVMCreate(^(QSPTableViewCellVM *cellVM){
                    cellVM.dataMCreate(CellM.class, ^(CellM *model){
                        model.title = @"操作方式";
                        model.icon = @"operation";
                        model.subTitle = @"按键";
                        model.arrow = YES;
                    });
                }).addQSPRowVMCreate(^(QSPTableViewCellVM *cellVM){
                    cellVM.dataMCreate(CellM.class, ^(CellM *model){
                        model.title = @"存档";
                        model.icon = @"saves";
                        model.subTitle = @"当前";
                        model.arrow = YES;
                    });
                }).addQSPRowVMCreate(^(QSPTableViewCellVM *cellVM){
                    cellVM.dataMCreate(CellM.class, ^(CellM *model){
                        model.title = @"皮肤";
                        model.icon = @"background";
                        model.subTitle = @"经典黑";
                        model.arrow = YES;
                    });
                });
            });
        }];
    }
    
    return self;
}

@end
