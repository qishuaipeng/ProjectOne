//
//  ElementV.m
//  Tetris
//
//  Created by QSP on 2018/8/26.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "ElementV.h"

@implementation ElementV

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, K_TetrisElementW, K_TetrisElementW)];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, K_TetrisElementW, K_TetrisElementW)]) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}
- (void)drawRect:(CGRect)rect {
//    CGFloat SW = rect.size.width;
//    CGFloat SH = rect.size.height;
//    CGFloat scale = 0.6;
//    CGFloat W = SW*scale;
//    CGFloat H = W;
//    CGFloat X = (SW - W)/2.0;
//    CGFloat Y = (SH - H)/2.0;
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddRect(context, CGRectMake(X, Y, W, H));
//    [K_TetrisForeColor setFill];
//    [K_TetrisForeColor setStroke];
//    CGContextFillPath(context);
//
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:(1 - scale)*SW/2.0];
//    path.lineWidth = 2;
//    [path stroke];
    
    [K_PublicInformation.elementImage drawInRect:rect];
}

@end
