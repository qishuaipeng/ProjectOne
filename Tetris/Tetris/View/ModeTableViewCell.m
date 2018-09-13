//
//  ModeTableViewCell.m
//  Tetris
//
//  Created by QSP on 2018/9/12.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "ModeTableViewCell.h"
#import "CellM.h"

@implementation ModeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconIV.contentMode = UIViewContentModeCenter;
    }
    
    return self;
}

- (QSPTableViewCell *(^)(QSPTableViewCellVM *))cellVMSet {
    return ^(QSPTableViewCellVM *vm){
        super.cellVMSet(vm);
        
        CellM *model = (CellM *)vm.dataM;
        [RACObserve(model, selected) subscribeNext:^(id  _Nullable x) {
            BOOL value = [x boolValue];
            self.iconIV.image = [UIImage imageNamed:value ? @"project_record_photo_choice" : @"project_record_photo_nochoice"];
        }];
        
        return self;
    };
}

@end
