//
//  SelectViewController.h
//  Tetris
//
//  Created by QSP on 2018/9/6.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseViewController.h"
#import "SelectVM.h"

@interface SelectViewController : BaseViewController

@property (strong, nonatomic, readonly) SelectVM *vm;

+ (instancetype)controllerWithVM:(SelectVM *)vm;
- (instancetype)initWithVM:(SelectVM *)vm;

@end
