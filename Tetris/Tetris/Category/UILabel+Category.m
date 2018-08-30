//
//  UILabel+Category.m
//  VCHelper
//
//  Created by WangXueqi on 2017/9/28.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "UILabel+Category.h"

/**
 UILabel (Category)
 */
@implementation UILabel (Category)

- (void)changeLabelTextColorWithText:(NSString *)text
                          startRange:(NSInteger)star
                            endRange:(NSInteger)end
                               color:(UIColor *)color
{
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:text];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:color
                          range:NSMakeRange(star, end)];
    self.attributedText = AttributedStr;
}

+ (UILabel *)addLabelText:(NSString *)text
                alignment:(NSTextAlignment)textAlignment
                 textFont:(NSInteger)Font
                textColor:(UIColor *)color
{
    
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:Font];
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.text = text;
    return label;
}

@end


/**
 UIButton (Category)
 */
@implementation UIButton (Category)

//只有文字
+ (UIButton *)addButtonTitle:(NSString *)title
                        font:(NSInteger)font
                  titleColor:(UIColor *)titleColor
                      Target:(id)target
                      action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//图片和文字
+ (UIButton *)addButtonImage:(NSString *)normalImage
                       title:(NSString *)title
                        font:(NSInteger)font
                  titleColor:(UIColor *)titleColor
                      Target:(id)target
                      action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end

/**
 UITextField (Category)
 */
@implementation UITextField (Category)

+ (UITextField *)addTextFieldFrame:(CGRect)frame
                    andPlaceholder:(NSString *)placeholder
                      andTextColor:(UIColor *)color
                       andTextFont:(CGFloat)font
                    andBorderStyle:(UITextBorderStyle)borderStyle
                  andTextAlignment:(NSTextAlignment)textAlignment
{    
    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.textColor = color;
    textField.font = [UIFont systemFontOfSize:font];
    textField.borderStyle = borderStyle;
    textField.textAlignment = textAlignment;
    return textField;
}

@end

/**
 UIScrollView (Category)
 */
@implementation UIScrollView (Category)

- (void)automaticallyAdjustsScrollViewInsetsiOS_11 {
        if (@available(iOS 11.0, *)) {
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        } else {

        }
//        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.contentInset = UIEdgeInsetsMake(K_StatusHeight,0,0,0);
//        [UITableView appearance].estimatedSectionFooterHeight = 0;
//        [UITableView appearance].estimatedSectionHeaderHeight = 0;
//        [UITableView appearance].estimatedRowHeight = 0;
}

@end
