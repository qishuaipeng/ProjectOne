//
//  UIView+Category.h
//  JDZBorrower
//
//  Created by QSP on 2018/4/13.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

- (UITapGestureRecognizer *)addTapWithBlock:(void (^)(UIView *view, UITapGestureRecognizer *tap))block;
- (UISwipeGestureRecognizer *)addSwipeWithBlock:(void (^)(UIView *view, UISwipeGestureRecognizer *swipe))block;
- (UIPanGestureRecognizer *)addPanWithBlock:(void (^)(UIView *view, UIPanGestureRecognizer *pan))block;

@end
