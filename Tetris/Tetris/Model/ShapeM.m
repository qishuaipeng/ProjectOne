//
//  ShapeM.m
//  Tetris
//
//  Created by QSP on 2018/8/26.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "ShapeM.h"

@implementation ShapeM

+ (instancetype)randomShape {
    return [self shapeMWithType:arc4random()%7 direction:arc4random()%4 nextType:arc4random()%7 andNextDirection:arc4random()%4];
}
+ (instancetype)shapeMWithType:(ShapeMType)type direction:(ShapeMDirection)direction nextType:(ShapeMType)nType andNextDirection:(ShapeMDirection)nDirection {
    return [[self alloc] initMWithType:type direction:direction nextType:nType andNextDirection:nDirection];
}
- (instancetype)initMWithType:(ShapeMType)type direction:(ShapeMDirection)direction nextType:(ShapeMType)nType andNextDirection:(ShapeMDirection)nDirection {
    if (self = [super init]) {
        _type = type;
        _direction = direction;
        _nextType = nType;
        _nextDirection = nDirection;
        [self reloadWithType:type direction:direction andNext:NO];
        [self reloadWithType:nType direction:nDirection andNext:YES];
    }
    
    return self;
}
- (void)nextRandom {
    ShapeMType type = arc4random()%7;
    [self nextWithType:type andDirection:arc4random()%4];//type == ShapeMType6 ? (arc4random()%2 == 0 ? type : arc4random()%7) : type
}
- (void)nextWithType:(ShapeMType)type andDirection:(ShapeMDirection)direction {
    _type = _nextType;
    _direction = _nextDirection;
    _first = _nextFirst;
    _second = _nextSecond;
    _third = _nextThird;
    _fourth = _nextFourth;
    _nextType = type;
    _nextDirection = direction;
    [self reloadWithType:type direction:direction andNext:YES];
    
    [K_Default_NotificationCenter postNotificationName:K_ShapeM_NextNotificationName object:self];
}
- (void)rotation {
    _direction = (self.direction + 1)%4;
    [self reloadWithType:self.type direction:self.direction andNext:NO];
}
- (void)rotationNext {
    _nextDirection = (self.nextDirection + 1)%4;
    [self reloadWithType:self.nextType direction:self.nextDirection andNext:YES];
}
- (void)changedWithType:(ShapeMType)type andDirection:(ShapeMDirection)direction {
    _type = type;
    _direction = direction;
    [self reloadWithType:type direction:direction andNext:NO];
}
- (void)changedNextWithType:(ShapeMType)type andDirection:(ShapeMDirection)direction {
    _nextType = type;
    _nextDirection = direction;
    [self reloadWithType:type direction:direction andNext:YES];
}
- (void)reloadWithType:(ShapeMType)type direction:(ShapeMDirection)direction andNext:(BOOL)next {
    NSIndexPath *first, *second, *third, *fourth;
    switch (type) {
        case ShapeMType1:
        {
            if (direction == ShapeMDirectionLeft|| direction == ShapeMDirectionRight ) {
                first = [NSIndexPath indexPathForRow:1 inSection:2];
                second = [NSIndexPath indexPathForRow:2 inSection:2];
                third = [NSIndexPath indexPathForRow:0 inSection:3];
                fourth = [NSIndexPath indexPathForRow:1 inSection:3];
            } else {
                first = [NSIndexPath indexPathForRow:1 inSection:1];
                second = [NSIndexPath indexPathForRow:1 inSection:2];
                third = [NSIndexPath indexPathForRow:2 inSection:2];
                fourth = [NSIndexPath indexPathForRow:2 inSection:3];
            }
            break;
        }
        case ShapeMType2:
        {
            if (direction == ShapeMDirectionLeft|| direction == ShapeMDirectionRight ) {
                first = [NSIndexPath indexPathForRow:0 inSection:2];
                second = [NSIndexPath indexPathForRow:1 inSection:2];
                third = [NSIndexPath indexPathForRow:1 inSection:3];
                fourth = [NSIndexPath indexPathForRow:2 inSection:3];
            } else {
                first = [NSIndexPath indexPathForRow:2 inSection:1];
                second = [NSIndexPath indexPathForRow:1 inSection:2];
                third = [NSIndexPath indexPathForRow:2 inSection:2];
                fourth = [NSIndexPath indexPathForRow:1 inSection:3];
            }
            break;
        }
        case ShapeMType3:
        {
            switch (direction) {
                case ShapeMDirectionLeft:
                {
                    first = [NSIndexPath indexPathForRow:1 inSection:1];
                    second = [NSIndexPath indexPathForRow:2 inSection:1];
                    third = [NSIndexPath indexPathForRow:2 inSection:2];
                    fourth = [NSIndexPath indexPathForRow:2 inSection:3];
                    break;
                }
                case ShapeMDirectionTop:
                {
                    first = [NSIndexPath indexPathForRow:2 inSection:2];
                    second = [NSIndexPath indexPathForRow:0 inSection:3];
                    third = [NSIndexPath indexPathForRow:1 inSection:3];
                    fourth = [NSIndexPath indexPathForRow:2 inSection:3];
                    break;
                }
                case ShapeMDirectionRight:
                {
                    first = [NSIndexPath indexPathForRow:1 inSection:1];
                    second = [NSIndexPath indexPathForRow:1 inSection:2];
                    third = [NSIndexPath indexPathForRow:1 inSection:3];
                    fourth = [NSIndexPath indexPathForRow:2 inSection:3];
                    break;
                }
                    
                default:
                {
                    first = [NSIndexPath indexPathForRow:0 inSection:2];
                    second = [NSIndexPath indexPathForRow:1 inSection:2];
                    third = [NSIndexPath indexPathForRow:2 inSection:2];
                    fourth = [NSIndexPath indexPathForRow:0 inSection:3];
                    break;
                }
            }
            break;
        }
        case ShapeMType4:
        {
            switch (direction) {
                case ShapeMDirectionLeft:
                {
                    first = [NSIndexPath indexPathForRow:2 inSection:1];
                    second = [NSIndexPath indexPathForRow:2 inSection:2];
                    third = [NSIndexPath indexPathForRow:1 inSection:3];
                    fourth = [NSIndexPath indexPathForRow:2 inSection:3];
                    break;
                }
                case ShapeMDirectionTop:
                {
                    first = [NSIndexPath indexPathForRow:0 inSection:2];
                    second = [NSIndexPath indexPathForRow:0 inSection:3];
                    third = [NSIndexPath indexPathForRow:1 inSection:3];
                    fourth = [NSIndexPath indexPathForRow:2 inSection:3];
                    break;
                }
                case ShapeMDirectionRight:
                {
                    first = [NSIndexPath indexPathForRow:1 inSection:1];
                    second = [NSIndexPath indexPathForRow:2 inSection:1];
                    third = [NSIndexPath indexPathForRow:1 inSection:2];
                    fourth = [NSIndexPath indexPathForRow:1 inSection:3];
                    break;
                }
                    
                default:
                {
                    first = [NSIndexPath indexPathForRow:0 inSection:2];
                    second = [NSIndexPath indexPathForRow:1 inSection:2];
                    third = [NSIndexPath indexPathForRow:2 inSection:2];
                    fourth = [NSIndexPath indexPathForRow:2 inSection:3];
                    break;
                }
            }
            break;
        }
        case ShapeMType5:
        {
            switch (direction) {
                case ShapeMDirectionLeft:
                {
                    first = [NSIndexPath indexPathForRow:2 inSection:1];
                    second = [NSIndexPath indexPathForRow:1 inSection:2];
                    third = [NSIndexPath indexPathForRow:2 inSection:2];
                    fourth = [NSIndexPath indexPathForRow:2 inSection:3];
                    break;
                }
                case ShapeMDirectionTop:
                {
                    first = [NSIndexPath indexPathForRow:1 inSection:2];
                    second = [NSIndexPath indexPathForRow:0 inSection:3];
                    third = [NSIndexPath indexPathForRow:1 inSection:3];
                    fourth = [NSIndexPath indexPathForRow:2 inSection:3];
                    break;
                }
                case ShapeMDirectionRight:
                {
                    first = [NSIndexPath indexPathForRow:1 inSection:1];
                    second = [NSIndexPath indexPathForRow:1 inSection:2];
                    third = [NSIndexPath indexPathForRow:2 inSection:2];
                    fourth = [NSIndexPath indexPathForRow:1 inSection:3];
                    break;
                }
                    
                default:
                {
                    first = [NSIndexPath indexPathForRow:0 inSection:2];
                    second = [NSIndexPath indexPathForRow:1 inSection:2];
                    third = [NSIndexPath indexPathForRow:2 inSection:2];
                    fourth = [NSIndexPath indexPathForRow:1 inSection:3];
                    break;
                }
            }
            break;
        }
        case ShapeMType6:
        {
            if (direction == ShapeMDirectionLeft|| direction == ShapeMDirectionRight ) {
                first = [NSIndexPath indexPathForRow:0 inSection:3];
                second = [NSIndexPath indexPathForRow:1 inSection:3];
                third = [NSIndexPath indexPathForRow:2 inSection:3];
                fourth = [NSIndexPath indexPathForRow:3 inSection:3];
            } else {
                first = [NSIndexPath indexPathForRow:1 inSection:0];
                second = [NSIndexPath indexPathForRow:1 inSection:1];
                third = [NSIndexPath indexPathForRow:1 inSection:2];
                fourth = [NSIndexPath indexPathForRow:1 inSection:3];
            }
            break;
        }
        default:
        {
            first = [NSIndexPath indexPathForRow:1 inSection:2];
            second = [NSIndexPath indexPathForRow:2 inSection:2];
            third = [NSIndexPath indexPathForRow:1 inSection:3];
            fourth = [NSIndexPath indexPathForRow:2 inSection:3];
            break;
        }
    }
    
    if (next) {
        _nextFirst = first;
        _nextSecond = second;
        _nextThird = third;
        _nextFourth = fourth;
    } else {
        _first = first;
        _second = second;
        _third = third;
        _fourth = fourth;
    }
}
- (NSIndexPath *)indexPathWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return self.first;
            break;
        case 1:
            return self.second;
            break;
        case 2:
            return self.third;
            break;
            
        default:
            return self.fourth;
            break;
    }
}
- (NSIndexPath *)indexPathOfNextWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return self.nextFirst;
            break;
        case 1:
            return self.nextSecond;
            break;
        case 2:
            return self.nextThird;
            break;
            
        default:
            return self.nextFourth;
            break;
    }
}

@end
