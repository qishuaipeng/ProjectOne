//
//  QSPKeyboardManager.h
//  JDZBorrower
//
//  Created by QSP on 2018/4/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QSPKeyboardManagerDelegate <NSObject>

@optional
- (void)keyboardChangeShow:(BOOL)show distance:(CGFloat)distance;

@end

@interface QSPKeyboardObj : NSObject

@property (weak, nonatomic) UIViewController<QSPKeyboardManagerDelegate> *controller;

+ (instancetype)keyboardWithViewController:(UIViewController<QSPKeyboardManagerDelegate> *)controller;
- (instancetype)initWithViewController:(UIViewController<QSPKeyboardManagerDelegate> *)controller;

@end

@interface QSPKeyboardManager : NSObject

+ (instancetype)manager;
+ (void)addViewController:(UIViewController<QSPKeyboardManagerDelegate> *)controller;

@end
