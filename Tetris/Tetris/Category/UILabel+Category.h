//
//  UILabel+Category.h
//  VCHelper
//
//  Created by WangXueqi on 2017/9/28.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UILabel (Category)
 */
@interface UILabel (Category)

//修改label指定区域文本颜色
- (void)changeLabelTextColorWithText:(NSString *)text
                          startRange:(NSInteger)star
                            endRange:(NSInteger)end
                               color:(UIColor *)color;

+ (UILabel *)addLabelText:(NSString *)text
                alignment:(NSTextAlignment)textAlignment
                 textFont:(NSInteger)Font
                textColor:(UIColor *)color;

@end

/**
 UIButton (Category)
 */
@interface UIButton (Category)

//只有文字
+ (UIButton *)addButtonTitle:(NSString *)title
                        font:(NSInteger)font
                  titleColor:(UIColor *)titleColor
                      Target:(id)target
                      action:(SEL)action;

//图片和文字
+ (UIButton *)addButtonImage:(NSString *)normalImage
                       title:(NSString *)title
                        font:(NSInteger)font
                  titleColor:(UIColor *)titleColor
                      Target:(id)target
                      action:(SEL)action;

@end

/**
 UITextField (Category)
 */
@interface UITextField (Category)

+ (UITextField *)addTextFieldFrame:(CGRect)frame
                    andPlaceholder:(NSString *)placeholder
                      andTextColor:(UIColor *)color
                       andTextFont:(CGFloat)font
                    andBorderStyle:(UITextBorderStyle)borderStyle
                  andTextAlignment:(NSTextAlignment)textAlignment;

@end

/**
 UIScrollView (Category)
 */
@interface UIScrollView (Category)
//UITableView适配iOS11
- (void)automaticallyAdjustsScrollViewInsetsiOS_11;

@end
