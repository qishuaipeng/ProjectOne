//
//  TeachVM.h
//  Tetris
//
//  Created by QSP on 2018/9/10.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"
#import "PreviewVM.h"

typedef NS_ENUM(NSInteger, TeachVMType) {
    TeachVMTypeTap = 0,
    TeachVMTypePan = 1,
    TeachVMTypeSwipeDown = 2,
    TeachVMTypeSwipeUp = 3
};

@interface TeachVM : BaseVM

@property (assign, nonatomic) TeachVMType type;
@property (strong, nonatomic) RACCommand *lastCommand;
@property (strong, nonatomic) RACCommand *nextCommand;
@property (strong, nonatomic) RACCommand *closeCommand;
@property (strong, nonatomic) PreviewVM *previewVM;

+ (instancetype)teachVMWithType:(TeachVMType)type;
- (instancetype)initWithType:(TeachVMType)type;

@end
