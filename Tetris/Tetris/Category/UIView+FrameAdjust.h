//
//  UIView+frameAdjust.h
//  CoreText_Learn
//
//  Created by 綦 on 16/11/30.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);
@interface UIView (FrameAdjust)

@property (assign, nonatomic) CGPoint frameOrigin;
@property (assign, nonatomic) CGSize frameSize;

@property (assign, nonatomic) CGFloat frameX;
@property (assign, nonatomic) CGFloat frameY;

@property (assign, nonatomic) CGFloat frameWidth;
@property (assign, nonatomic) CGFloat frameHeight;

@property (assign, nonatomic, readonly) CGFloat frameRight;
@property (assign, nonatomic, readonly) CGFloat frameBottom;

@property (assign, nonatomic) CGFloat centerX;     
@property (assign, nonatomic) CGFloat centerY;

//获取当前视图所在的视图控制器
- (UIViewController *) viewController;

//删除当前视图内的所有子视图
- (void) removeChildViews;

//给视图添加点按事件
- (void)addTapActionWithBlock:(GestureActionBlock)block;

//给视图添加长按事件
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;

@end

/**
 * CALayer (Category)
 */
@interface CALayer (Category)

+ (CALayer *)addSubLayerWithFrame:(CGRect)frame
                  backgroundColor:(UIColor *)color
                         backView:(UIView *)baseView;

@end

