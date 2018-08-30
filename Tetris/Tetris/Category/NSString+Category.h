//
//  NSString+Category.h
//  JDZBorrower
//
//  Created by QSP on 2018/4/9.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Category)

/**
 是否为手机号码
 */
@property (assign, nonatomic, readonly) BOOL phoneNumber;
/**
 是否为数字
 */
@property (assign, nonatomic, readonly) BOOL number;
/**
 生成颜色
 */
@property (strong, nonatomic, readonly) UIColor *generateColor;
/**
 是否包含表情符号
 */
@property (assign, nonatomic, readonly) BOOL containsEmoji;
@property (copy, nonatomic, readonly) NSString *md5;


/**
 获取文字自适应所占区域大小
 
 @param width 宽度
 @param font 字体
 @return CGSize
 */
- (CGSize)sizeWithWidth:(CGFloat)width andFont:(UIFont *)font;
/**
 生成颜色

 @param alpha 透明度
 */
- (UIColor *)generateColorWithAlpha:(CGFloat)alpha;

// 获取由当前的NSString转换来的UIColor
- (UIColor *)color;

//去掉字符串中的左右两边空格
- (NSString *)RemoveInterval;

//去除所有空格
- (NSString *)RemoveAllInterval;

//手机号正则
- (BOOL)ISPhoneNumber;
//身份证号正则
- (BOOL)ISvalidateIdentityCard;

//调整标题行间距
+ (CGSize)getLabelTextSelfAdaptionWithLabel:(UILabel *)label
                                  withTitle:(NSString *)title
                               withLineHigh:(NSInteger)lineHigh
                              withTitleFont:(NSInteger)font
                             withTitleWidth:(CGFloat)width;

// 传内容string和字体大小，就可以计算多少行。
+ (CGFloat)getLineNum:(NSString*)str
                 font:(NSInteger)font
           labelWidth:(CGFloat)width;

//获取文本尺寸
+ (CGSize)getSizeString:(NSString *)string font:(NSInteger)font;
@end
