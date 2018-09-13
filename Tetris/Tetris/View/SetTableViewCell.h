//
//  SetTableViewCell.h
//  Tetris
//
//  Created by QSP on 2018/9/2.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "QSPTableViewCell.h"

@interface SetTableViewCell : QSPTableViewCell

@property (weak, nonatomic, readonly) UIImageView *iconIV;
@property (weak, nonatomic, readonly) UILabel *titleL;
@property (weak, nonatomic, readonly) UILabel *subL;
@property (weak, nonatomic, readonly) UIImageView *arrowIV;

@end
