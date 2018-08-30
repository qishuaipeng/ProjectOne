//
//  UIView+Category.m
//  JDZBorrower
//
//  Created by QSP on 2018/4/13.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "UIView+Category.h"
#import <ReactiveObjC.h>

@implementation UIView (Category)

- (UITapGestureRecognizer *)addTapWithBlock:(void (^)(UIView *view, UITapGestureRecognizer *tap))block {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self);
    [tap.rac_gestureSignal subscribeNext:^(__kindof UITapGestureRecognizer * _Nullable x) {
        @strongify(self);
        if (block) {
            block(self, x);
        }
    }];
    [self addGestureRecognizer:tap];
    
    return tap;
}

@end
