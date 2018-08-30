//
//  SourceM.h
//  Tetris
//
//  Created by QSP on 2018/8/27.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseM.h"

@interface SourceM : BaseM

@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger row;
@property (assign, nonatomic) BOOL solid;
@property (weak, nonatomic) UIView *elementV;

@end
