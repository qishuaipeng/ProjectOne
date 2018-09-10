//
//  SetViewController.h
//  Tetris
//
//  Created by QSP on 2018/9/2.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseViewController.h"
#import "SetVM.h"

@interface SetViewController : BaseViewController

@property (strong, nonatomic, readonly) SetVM *vm;

+ (instancetype)controllerWithVM:(SetVM *)vm;
- (instancetype)initWithVM:(SetVM *)vm;

@end
