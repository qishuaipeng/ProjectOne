//
//  ConFunc.h
//  JDZBorrower
//
//  Created by QSP on 2018/4/9.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ConFunc : NSObject

/**
 字符串判空
 */
+ (BOOL)blankOfStr:(NSString *)str;
/**
 删除Cookies
 */
+ (void)deleteCookies;
//获取当前app版本
+ (NSString *)currentApplicationVersion;
+ (UIView *)firstResponderFrom:(UIView *)view;
+ (UIImage *)elementImage;
+ (UIImage *)elementImageWithColor:(UIColor *)color;
+ (UIImage *)image:(UIImage *)image andAlpha:(CGFloat )alpha;

@end
