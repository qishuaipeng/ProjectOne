//
//  MainViewController.h
//  Tetris
//
//  Created by QSP on 2018/8/26.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseViewController.h"
#import "MainVM.h"

@interface MainViewController : BaseViewController

@property (strong, nonatomic, readonly) MainVM *vm;

+ (instancetype)controllerWithVM:(MainVM *)vm;
- (instancetype)initWithVM:(MainVM *)vm;

@end
