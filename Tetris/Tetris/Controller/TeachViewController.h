//
//  TeachViewController.h
//  Tetris
//
//  Created by QSP on 2018/9/10.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseViewController.h"
#import "TeachVM.h"

@interface TeachViewController : BaseViewController

@property (strong, nonatomic, readonly) TeachVM *vm;

+ (instancetype)controllerWithVM:(TeachVM *)vm;
- (instancetype)initWithVM:(TeachVM *)vm;

@end
