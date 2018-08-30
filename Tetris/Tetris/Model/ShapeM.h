//
//  ShapeM.h
//  Tetris
//
//  Created by QSP on 2018/8/26.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseM.h"

typedef NS_ENUM(NSInteger, ShapeMType) {
    ShapeMType1 = 0,
    ShapeMType2 = 1,
    ShapeMType3 = 2,
    ShapeMType4 = 3,
    ShapeMType5 = 4,
    ShapeMType6 = 5,
    ShapeMType7 = 6,
};
typedef NS_ENUM(NSInteger, ShapeMDirection) {
    ShapeMDirectionLeft = 0,
    ShapeMDirectionTop = 1,
    ShapeMDirectionRight = 2,
    ShapeMDirectionBottom = 3
};

@interface ShapeM : BaseM

@property (assign, nonatomic, readonly) ShapeMType type;
@property (assign, nonatomic, readonly) ShapeMDirection direction;
@property (strong, nonatomic, readonly) NSIndexPath *first;
@property (strong, nonatomic, readonly) NSIndexPath *second;
@property (strong, nonatomic, readonly) NSIndexPath *third;
@property (strong, nonatomic, readonly) NSIndexPath *fourth;

@property (assign, nonatomic, readonly) ShapeMType nextType;
@property (assign, nonatomic, readonly) ShapeMDirection nextDirection;
@property (strong, nonatomic, readonly) NSIndexPath *nextFirst;
@property (strong, nonatomic, readonly) NSIndexPath *nextSecond;
@property (strong, nonatomic, readonly) NSIndexPath *nextThird;
@property (strong, nonatomic, readonly) NSIndexPath *nextFourth;

+ (instancetype)randomShape;
+ (instancetype)shapeMWithType:(ShapeMType)type direction:(ShapeMDirection)direction nextType:(ShapeMType)nType andNextDirection:(ShapeMDirection)nDirection;
- (instancetype)initMWithType:(ShapeMType)type direction:(ShapeMDirection)direction nextType:(ShapeMType)nType andNextDirection:(ShapeMDirection)nDirection;
- (void)changedWithType:(ShapeMType)type andDirection:(ShapeMDirection)direction;
- (void)changedNextWithType:(ShapeMType)type andDirection:(ShapeMDirection)direction;
- (NSIndexPath *)indexPathWithIndex:(NSInteger)index;
- (NSIndexPath *)indexPathOfNextWithIndex:(NSInteger)index;
- (void)nextRandom;
- (void)nextWithType:(ShapeMType)type andDirection:(ShapeMDirection)direction;
- (void)rotation;
- (void)rotationNext;

@end
