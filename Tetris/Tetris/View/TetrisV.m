//
//  TetrisV.m
//  Tetris
//
//  Created by QSP on 2018/8/26.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "TetrisV.h"
#import "ElementV.h"

@interface TetrisV ()

@property (strong, nonatomic) NSMutableArray *shapes;

@end

@implementation TetrisV
@synthesize vm = _vm;

- (NSMutableArray *)shapes {
    if (_shapes == nil) {
        _shapes = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _shapes;
}
- (void)setVm:(TetrisVM *)vm {
    _vm = vm;
    CGFloat spacing = K_TetrisSpacing;
    for (NSInteger section = 0; section < vm.sourceData.count; section++) {
        NSArray *sectionData = [vm.sourceData objectAtIndex:section];
        for (NSInteger row = 0; row < sectionData.count; row++) {
            SourceM *sourceM = [sectionData objectAtIndex:row];
            if (sourceM.solid) {
                ElementV *elementV = [[ElementV alloc] init];
                [self addSubview:elementV];
                elementV.frameX = spacing + (spacing + K_TetrisElementW)*row;
                elementV.frameY = spacing + (spacing + K_TetrisElementW)*section;
                sourceM.elementV = elementV;
            }
        }
    }
}

+ (instancetype)tetrisVWithVM:(TetrisVM *)vm {
    return [[self alloc] initWithVM:vm];
}
- (instancetype)initWithVM:(TetrisVM *)vm {
    if (self = [super init]) {
        self.vm = vm;
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkAction:)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    return self;
}
static NSInteger timeCount = 0;
- (void)linkAction:(CADisplayLink *)sender {
    timeCount++;
    if (timeCount%(30 - 2*self.vm.speed) == 0) {
        if (self.vm && self.vm.type == TetrisVMTypePlaying && (!self.vm.removeAnimating) && (![self downMove])) {
        }
        timeCount = 0;
    }
}
- (void)drawRect:(CGRect)rect {
    CGFloat spacing = K_TetrisSpacing;
    UIImage *image = [ConFunc image:K_PublicInformation.elementImage andAlpha:0.2];
    for (NSInteger section = 0; section < K_TetrisCount_V; section++) {
        for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
            CGRect rect = CGRectMake(spacing + row*(K_TetrisElementW + spacing), spacing + section*(K_TetrisElementW + spacing), K_TetrisElementW, K_TetrisElementW);
            [image drawInRect:rect];
        }
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);
    [K_TetrisForeColor setStroke];
    CGContextSetLineWidth(context, 3);
    CGContextStrokePath(context);
}

/**
 检查是否游戏结束
 */
- (BOOL)checkOver {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:-self.vm.shapeM.nextFirst.section];
    for (NSInteger index = 0; index < 4; index++) {
        NSIndexPath *element = [self.vm.shapeM indexPathOfNextWithIndex:index];
        NSIndexPath *loction = [NSIndexPath indexPathForRow:indexPath.row + element.row inSection:indexPath.section + element.section];
        SourceM *sourceM = [[self.vm.sourceData objectAtIndex:loction.section] objectAtIndex:loction.row];
        if (sourceM.solid) {//游戏结束
            self.vm.type = TetrisVMTypeOver;
            
            return YES;
        }
    }
    
    return NO;
}
- (void)creatShapes {
    CGFloat spacing = K_TetrisSpacing;
    self.vm.location = [NSIndexPath indexPathForRow:3 inSection:-self.vm.shapeM.first.section];
    
    ElementV *elementV;
    
    //创建形状
    for (NSInteger index = 0; index < 4; index++) {
        elementV = [[ElementV alloc] init];
        [self addSubview:elementV];
        NSIndexPath *indexPath = [self.vm.shapeM indexPathWithIndex:index];
        elementV.frameX = spacing + (spacing + K_TetrisElementW)*(self.vm.location.row + indexPath.row);
        elementV.frameY = spacing + (spacing + K_TetrisElementW)*(self.vm.location.section + indexPath.section);
        [self.shapes addObject:elementV];
    }
    
    timeCount = 0;
}

- (void)rotationShape {
    if (self.vm && self.vm.type == TetrisVMTypePlaying) {
        if (self.vm.shapeM.type == ShapeMType1 || self.vm.shapeM.type == ShapeMType2) {
            if (self.vm.shapeM.direction == ShapeMDirectionTop || self.vm.shapeM.direction == ShapeMDirectionBottom) {
                if ([self canRotation:[NSIndexPath indexPathForRow:self.vm.location.row inSection:self.vm.location.section + 1] distanceH:3 andDistanceV:3]) {
                    [self.vm.shapeM rotation];
                    [self transformShape];
                } else if ([self canRotation:[NSIndexPath indexPathForRow:self.vm.location.row + 1 inSection:self.vm.location.section + 1] distanceH:3 andDistanceV:3]) {
                    [self.vm.shapeM rotation];
                    self.vm.location = [NSIndexPath indexPathForRow:self.vm.location.row + 1 inSection:self.vm.location.section];
                    [self transformShape];
                }
            } else {
                if ([self canRotation:[NSIndexPath indexPathForRow:self.vm.location.row inSection:self.vm.location.section + 1] distanceH:3 andDistanceV:3]) {
                    [self.vm.shapeM rotation];
                    [self transformShape];
                }
            }
        } else if (self.vm.shapeM.type == ShapeMType3 || self.vm.shapeM.type == ShapeMType4 || self.vm.shapeM.type == ShapeMType5) {
            if (self.vm.shapeM.direction == ShapeMDirectionTop || self.vm.shapeM.direction == ShapeMDirectionBottom) {
                if ([self canRotation:[NSIndexPath indexPathForRow:self.vm.location.row inSection:self.vm.location.section + 1] distanceH:3 andDistanceV:3]) {
                    [self.vm.shapeM rotation];
                    [self transformShape];
                }
            } else {
                if ([self canRotation:[NSIndexPath indexPathForRow:self.vm.location.row inSection:self.vm.location.section + 1] distanceH:3 andDistanceV:3]) {
                    [self.vm.shapeM rotation];
                    [self transformShape];
                } else if ([self canRotation:[NSIndexPath indexPathForRow:self.vm.location.row + 1 inSection:self.vm.location.section + 1] distanceH:3 andDistanceV:3]) {
                    [self.vm.shapeM rotation];
                    self.vm.location = [NSIndexPath indexPathForRow:self.vm.location.row + 1 inSection:self.vm.location.section];
                    [self transformShape];
                }
            }
        } else if (self.vm.shapeM.type == ShapeMType6) {
            if (self.vm.shapeM.direction == ShapeMDirectionTop || self.vm.shapeM.direction == ShapeMDirectionBottom) {
                if ([self canRotation:[NSIndexPath indexPathForRow:self.vm.location.row inSection:self.vm.location.section] distanceH:4 andDistanceV:4]) {
                    [self.vm.shapeM rotation];
                    [self transformShape];
                } else if ([self canRotation:[NSIndexPath indexPathForRow:self.vm.location.row + 1 inSection:self.vm.location.section] distanceH:4 andDistanceV:4]) {
                    [self.vm.shapeM rotation];
                    self.vm.location = [NSIndexPath indexPathForRow:self.vm.location.row + 1 inSection:self.vm.location.section];
                    [self transformShape];
                }
            } else {
                if ([self canRotation:[NSIndexPath indexPathForRow:self.vm.location.row inSection:self.vm.location.section] distanceH:4 andDistanceV:4]) {
                    [self.vm.shapeM rotation];
                    [self transformShape];
                }
            }
        }
    }
}
- (BOOL)canRotation:(NSIndexPath *)indexPath distanceH:(NSInteger)disH andDistanceV:(NSInteger)disV {
    for (NSInteger section = 0; section < disV; section++) {
        for (NSInteger row = 0; row < disH; row++) {
            NSIndexPath *temp = [NSIndexPath indexPathForRow:indexPath.row + row inSection:indexPath.section + section];
            if (temp.row < 0 || temp.row >= K_TetrisCount_H || temp.section >= K_TetrisCount_V) {
                return NO;
            } else {
                if (temp.section >= 0) {
                    SourceM *sourceM = [[self.vm.sourceData objectAtIndex:temp.section] objectAtIndex:temp.row];
                    if (sourceM.solid) {
                        return NO;
                    }
                }
            }
        }
    }
    
    return YES;
}
- (void)transformShape {
    CGFloat spacing = K_TetrisSpacing;
    ElementV *elementV;
    for (NSInteger index = 0; index < 4; index++) {
        elementV = [self.shapes objectAtIndex:index];
        NSIndexPath *indexPath = [self.vm.shapeM indexPathWithIndex:index];
        NSIndexPath *location = [NSIndexPath indexPathForRow:self.vm.location.row + indexPath.row inSection:self.vm.location.section + indexPath.section];
        elementV.frameX = spacing + (spacing + K_TetrisElementW)*location.row;
        elementV.frameY = spacing + (spacing + K_TetrisElementW)*location.section;
        if (location.row < 0 || location.section < 0 || location.row >= K_TetrisCount_H || location.section >= K_TetrisCount_V) {
            elementV.hidden = YES;
        } else {
            elementV.hidden = NO;
        }
    }
}
- (BOOL)upMove {
    if (self.vm && self.vm.type == TetrisVMTypePlaying) {
        BOOL breaked = NO;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.vm.location.row inSection:self.vm.location.section - 1];
        for (NSInteger index = 0; index < 4; index++) {
            NSIndexPath *shape = [self.vm.shapeM indexPathWithIndex:index];
            NSIndexPath *location = [NSIndexPath indexPathForRow:indexPath.row + shape.row inSection:indexPath.section + shape.section];
            
            if (location.section < 0) {
                breaked = YES;
                break;
            } else {
                if (location.section < K_TetrisCount_V && location.row >= 0 && location.row < K_TetrisCount_H) {
                    SourceM *sourceM = [[self.vm.sourceData objectAtIndex:location.section] objectAtIndex:location.row];
                    if (sourceM.solid) {
                        breaked = YES;
                        break;
                    }
                }
            }
        }
        
        if (!breaked) {
            self.vm.location = indexPath;
            [self transformShape];
        }
        
        return !breaked;
    }
    
    return NO;
}
- (BOOL)leftMove {
    if (self.vm && self.vm.type == TetrisVMTypePlaying) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.vm.location.row - 1 inSection:self.vm.location.section];
        BOOL breaked = NO;
        for (NSInteger index = 0; index < 4; index++) {
            NSIndexPath *shape = [self.vm.shapeM indexPathWithIndex:index];
            NSIndexPath *location = [NSIndexPath indexPathForRow:indexPath.row + shape.row inSection:indexPath.section + shape.section];
            
            if (location.row < 0) {
                breaked = YES;
                break;
            } else {
                if (location.row < K_TetrisCount_H && location.section >= 0 && location.section < K_TetrisCount_V) {
                    SourceM *sourceM = [[self.vm.sourceData objectAtIndex:location.section] objectAtIndex:location.row];
                    if (sourceM.solid) {
                        breaked = YES;
                        break;
                    }
                }
            }
        }
        
        if (!breaked) {
            self.vm.location = indexPath;
            [self transformShape];
        }
        
        return !breaked;
    }
    
    return NO;
}
- (BOOL)rightMove {
    if (self.vm && self.vm.type == TetrisVMTypePlaying) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.vm.location.row + 1 inSection:self.vm.location.section];
        BOOL breaked = NO;
        for (NSInteger index = 0; index < 4; index++) {
            NSIndexPath *shape = [self.vm.shapeM indexPathWithIndex:index];
            NSIndexPath *location = [NSIndexPath indexPathForRow:indexPath.row + shape.row inSection:indexPath.section + shape.section];
            if (location.row >= K_TetrisCount_H) {
                breaked = YES;
                break;
            } else {
                if (location.row >= 0 && location.section >= 0 && location.section < K_TetrisCount_V) {
                    SourceM *sourceM = [[self.vm.sourceData objectAtIndex:location.section] objectAtIndex:location.row];
                    if (sourceM.solid) {
                        breaked = YES;
                        break;
                    }
                }
            }
        }
        
        if (!breaked) {
            self.vm.location = indexPath;
            [self transformShape];
        }
        
        return !breaked;
    }
    
    return NO;
}
- (BOOL)downMove {
    if (self.vm && self.vm.type == TetrisVMTypePlaying) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.vm.location.row inSection:self.vm.location.section + 1];
        BOOL breaked = NO;
        for (NSInteger index = 0; index < 4; index++) {
            NSIndexPath *shape = [self.vm.shapeM indexPathWithIndex:index];
            NSIndexPath *location = [NSIndexPath indexPathForRow:indexPath.row + shape.row inSection:indexPath.section + shape.section];
            
            if (location.section >= K_TetrisCount_V) {
                breaked = YES;
                break;
            } else {
                if (location.section >= 0 && location.row >= 0 && location.row < K_TetrisCount_H) {
                    SourceM *sourceM = [[self.vm.sourceData objectAtIndex:location.section] objectAtIndex:location.row];
                    if (sourceM.solid) {
                        breaked = YES;
                        break;
                    }
                }
            }
        }
        
        if (!breaked) {
            self.vm.location = indexPath;
            [self transformShape];
        } else {
            //变更完成的数据
            for (NSInteger index = 0; index < 4; index++) {
                NSIndexPath *element = [self.vm.shapeM indexPathWithIndex:index];
                SourceM *sourceM = [[self.vm.sourceData objectAtIndex:(self.vm.location.section + element.section)] objectAtIndex:self.vm.location.row + element.row];
                sourceM.solid = YES;
                sourceM.elementV = [self.shapes objectAtIndex:index];
            }
            [self.shapes removeAllObjects];
            
            //找出需要消除的行
            NSMutableArray *solidSections = [NSMutableArray arrayWithCapacity:1];
            for (NSInteger index = [self.vm.shapeM indexPathWithIndex:0].section; index < 4; index ++) {
                NSInteger section = self.vm.location.section + index;
                for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
                    SourceM *sourceM = [[self.vm.sourceData objectAtIndex:section] objectAtIndex:row];
                    if (!sourceM.solid) {
                        break;
                    }
                    if (row == K_TetrisCount_H - 1) {
                        [solidSections addObject:@(section)];
                    }
                }
            }
            
            //如果存在需要消除的行
            if (solidSections.count > 0) {
                //计算得分
                NSInteger score = 0;
                for (NSInteger index = 1; index <= solidSections.count; index++) {
                    score += index;
                }
                self.vm.score += score;
                NSInteger speed = self.vm.score/100 + 1;
                
                //计算速度
                self.vm.speed = speed > 10 ? 10 : speed;
                
                //添加消除动画
                self.vm.removeAnimating = YES;
                [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                    [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
                        for (id section in solidSections) {
                            for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
                                SourceM *sourceM = [[self.vm.sourceData objectAtIndex:[section integerValue]] objectAtIndex:row];
                                sourceM.elementV.alpha = 0;
                            }
                        }
                    }];
                    [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
                        for (id section in solidSections) {
                            for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
                                SourceM *sourceM = [[self.vm.sourceData objectAtIndex:[section integerValue]] objectAtIndex:row];
                                sourceM.elementV.alpha = 1;
                            }
                        }
                    }];
                    [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.2 animations:^{
                        for (id section in solidSections) {
                            for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
                                SourceM *sourceM = [[self.vm.sourceData objectAtIndex:[section integerValue]] objectAtIndex:row];
                                sourceM.elementV.alpha = 0;
                            }
                        }
                    }];
                    [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.2 animations:^{
                        for (id section in solidSections) {
                            for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
                                SourceM *sourceM = [[self.vm.sourceData objectAtIndex:[section integerValue]] objectAtIndex:row];
                                sourceM.elementV.alpha = 1;
                            }
                        }
                    }];
                } completion:^(BOOL finished) {
                    if (finished) {
                        //移除消除的行
                        for (id section in solidSections) {
                            for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
                                SourceM *sourceM = [[self.vm.sourceData objectAtIndex:[section integerValue]] objectAtIndex:row];
                                [sourceM.elementV removeFromSuperview];
                                sourceM.solid = NO;
                                sourceM.elementV = nil;
                            }
                        }
                        
                        //平移行
                        for (id removedSection in solidSections) {
                            for (NSInteger section = [removedSection integerValue] - 1; section >= 0; section--) {
                                for (NSInteger row = 0; row < K_TetrisCount_H; row++) {
                                    SourceM *sourceM = [[self.vm.sourceData objectAtIndex:section] objectAtIndex:row];
                                    SourceM *destinationM = [[self.vm.sourceData objectAtIndex:section + 1] objectAtIndex:row];
                                    destinationM.solid = sourceM.solid;
                                    destinationM.elementV = sourceM.elementV;
                                    destinationM.elementV.frameY += K_TetrisSpacing + K_TetrisElementW;
                                    sourceM.solid = NO;
                                    sourceM.elementV = nil;
                                    sourceM.elementV.alpha = 1;
                                }
                            }
                        }
                        
                        self.vm.removeAnimating = NO;
                        
                        //改变形状
                        [self changeShape];
                    }
                }];
            } else {
                //改变形状
                [self changeShape];
            }
        }
        
        return !breaked;
    }
    
    return NO;
}
- (void)changeShape {
    if (![self checkOver]) {
        //更换形状
        [self.vm.shapeM nextRandom];
        
        //创建形状
        [self creatShapes];
    }
}
- (void)start {
    if (self.vm.type == TetrisVMTypeOver) {
        [self newStart];
    } else if (self.vm.type != TetrisVMTypePlaying) {
        timeCount = 0;
        self.vm.type = TetrisVMTypePlaying;
        if (self.shapes.count == 0) {
            [self creatShapes];
        }
    }
}
- (void)pause {
    if (self.vm.type == TetrisVMTypePlaying) {
        self.vm.type = TetrisVMTypePaused;
    }
}
- (void)newStart {
    for (NSArray *arr in self.vm.sourceData) {
        for (SourceM *sourceM in arr) {
            sourceM.solid = NO;
            [sourceM.elementV removeFromSuperview];
        }
    }
    self.vm.removeAnimating = NO;
    self.vm.score = 0;
    self.vm.speed = 1;
    [self.shapes removeAllObjects];
    
    [self.vm.shapeM nextRandom];
    self.vm.type = TetrisVMTypePrepare;
    [self start];
}

@end
