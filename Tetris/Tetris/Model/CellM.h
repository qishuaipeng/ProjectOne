//
//  CellM.h
//  Tetris
//
//  Created by QSP on 2018/9/2.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseM.h"

@interface CellM : BaseM

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subTitle;
@property (assign, nonatomic) BOOL arrow;
@property (assign, nonatomic) BOOL selected;

@end
