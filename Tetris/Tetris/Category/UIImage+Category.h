//
//  UIImage+Category.h
//  JDZBorrower
//
//  Created by QSP on 2018/4/9.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/**
 生成颜色图片
 
 @param color 颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 生成颜色图片

 @param color 颜色
 @param size 大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
/**
 改变尺寸

 @param size 尺寸
 */
- (UIImage *)changeTosize:(CGSize)size;
/**
 拉伸图片
 */
- (UIImage *)stretch;
- (UIImage *)stretchFromLeft:(float)left fromTop:(float)top;
/**
 *  图片圆角
 *
 *  @param scale 圆角的比例
 */
- (UIImage *)roundCornerWithScale:(CGFloat)scale;
- (UIImage *)roundCornerWithScale:(CGFloat)scale strokeColor:(UIColor *)color strokeWidth:(CGFloat)width;
- (UIImage *)roundCornerWithRadius:(CGFloat)radius;
- (UIImage *)roundCornerWithRadius:(CGFloat)radius strokeColor:(UIColor *)color strokeWidth:(CGFloat)width;

/**
 虚线图片

 @param size 尺寸
 @param horizontal 水平
 @param color 颜色
 @param phase 相位
 @param lengths 虚实间隔
 */
+ (UIImage *)dottedLineWithSize:(CGSize)size horizontal:(BOOL)horizontal color:(UIColor *)color phase:(CGFloat)phase lengths:(NSArray<NSNumber *> *)lengths;

@end

/**
 UIImageView (Category)
 */
@interface UIImageView (Category)

//提示无数据图片
+ (UIImageView *)imageRemindWithOutDataWithFrame:(CGRect)frame;

@end

