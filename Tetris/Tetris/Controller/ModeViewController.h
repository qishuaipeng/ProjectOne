//
//  ModeViewController.h
//  Tetris
//
//  Created by QSP on 2018/9/12.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseViewController.h"
#import "ModeVM.h"

@interface ModeViewController : BaseViewController

@property (strong, nonatomic, readonly) ModeVM *vm;

+ (instancetype)controllerWithVM:(ModeVM *)vm;
- (instancetype)initWithVM:(ModeVM *)vm;

@end
