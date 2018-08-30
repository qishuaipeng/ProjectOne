//
//  NSString+Category.m
//  JDZBorrower
//
//  Created by QSP on 2018/4/9.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Category)

- (BOOL)phoneNumber {
    if ([ConFunc blankOfStr:self]) {
        return NO;
    } else {
        /**
         中国电信号段
         133、149、153、173、177、180、181、189、199
         中国联通号段
         130、131、132、145、155、156、166、175、176、185、186
         中国移动号段
         134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、178、182、183、184、187、188、198
         其他号段
         14号段以前为上网卡专属号段，如中国联通的是145，中国移动的是147等等。
         虚拟运营商
         电信：1700、1701、1702
         移动：1703、1705、1706
         联通：1704、1707、1708、1709、171
         */
        NSString *regular = @"^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
        
        return [predicate evaluateWithObject:self];
    }
}
- (BOOL)number {
    if ([ConFunc blankOfStr:self]) {
        return NO;
    } else {
        //表示以数字开头，间接至少一个同样的字符，并以此字符结尾
        NSString *regular = @"^[0-9]+$";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
        
        return [predicate evaluateWithObject:self];
    }
}
- (UIColor *)generateColor {
    return [self generateColorWithAlpha:1];
}
- (BOOL)containsEmoji {
    if ([ConFunc blankOfStr:self]) {
        return NO;
    } else {
        __block BOOL returnValue = NO;
        
        [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                                   options:NSStringEnumerationByComposedCharacterSequences
                                usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                    const unichar hs = [substring characterAtIndex:0];
                                    if (0xd800 <= hs && hs <= 0xdbff) {
                                        if (substring.length > 1) {
                                            const unichar ls = [substring characterAtIndex:1];
                                            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                            if (0x1d000 <= uc && uc <= 0x1f77f) {
                                                returnValue = YES;
                                            }
                                        }
                                    } else if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        if (ls == 0x20e3) {
                                            returnValue = YES;
                                        }
                                        
                                    } else {
                                        if (0x2100 <= hs && hs <= 0x27ff) {
                                            returnValue = YES;
                                        } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                            returnValue = YES;
                                        } else if (0x2934 <= hs && hs <= 0x2935) {
                                            returnValue = YES;
                                        } else if (0x3297 <= hs && hs <= 0x3299) {
                                            returnValue = YES;
                                        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                            returnValue = YES;
                                        }else if (hs == 0x200d){
                                            returnValue = YES;
                                        }
                                    }
                                }];
        
        return returnValue;
    }
}
- (NSString *)md5 {
    
    //1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [self UTF8String];
    
    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    
    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    
    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return saveResult;
}

- (CGSize)sizeWithWidth:(CGFloat)width andFont:(UIFont *)font
{
    if ([ConFunc blankOfStr:self]) {
        return CGSizeMake(0, 0);
    } else {
        return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    }
}
- (UIColor *)generateColorWithAlpha:(CGFloat)alpha
{
    if ([ConFunc blankOfStr:self]) {
        return nil;
    } else {
        //删除字符串中的空格
        NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        // String should be 6 or 8 characters
        if ([cString length] < 6)
        {
            return [UIColor clearColor];
        }
        // strip 0X if it appears
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        if ([cString hasPrefix:@"0X"])
        {
            cString = [cString substringFromIndex:2];
        }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if ([cString hasPrefix:@"#"])
        {
            cString = [cString substringFromIndex:1];
        }
        if ([cString length] != 6)
        {
            return [UIColor clearColor];
        }
        
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        //r
        NSString *rString = [cString substringWithRange:range];
        //g
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        //b
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    }
}

// 获取由当前的NSString转换来的UIColor
- (UIColor*)color {
    // 判断长度先
    if (self.length < 6) return nil;
    // 去掉空格等其他字符
    NSString *cString = [[self stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] < 6 || [cString length] > 8) return nil;
    
    static int COLOR_LENGTH = 4;
    // Alpha Red Green Blue
    unsigned int colorARGB[COLOR_LENGTH];
    for (int i = 0; i < 4; i++) {
        // 先初始化为所有都是255
        colorARGB[COLOR_LENGTH-i-1] = 255;
        
        // 根据子字符串进行数字转换
        NSString *subString = [cString substringFromIndex: cString.length < 2 ? 0 : cString.length - 2];
        cString = [cString substringToIndex:cString.length < 2 ? cString.length : cString.length - 2];
        if (subString.length) {
            [[NSScanner scannerWithString:subString] scanHexInt:&colorARGB[COLOR_LENGTH-i-1]];
        }
    }
    
    return [UIColor colorWithRed:((float) colorARGB[1] / 255.0f)
                           green:((float) colorARGB[2] / 255.0f)
                            blue:((float) colorARGB[3] / 255.0f)
                           alpha:((float) colorARGB[0] / 255.0f)];
}

- (NSString *)RemoveInterval {    
    NSString * outStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return outStr;
}

- (NSString *)RemoveAllInterval {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//手机号正则
- (BOOL)ISPhoneNumber {
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(16[0-9])|(17[^4,\\D])|(18[0-9])|(19[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//身份证号正则
- (BOOL)ISvalidateIdentityCard {    
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString * regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

// 调整标题行间距
+ (CGSize)getLabelTextSelfAdaptionWithLabel:(UILabel *)label
                                  withTitle:(NSString *)title
                               withLineHigh:(NSInteger)lineHigh
                              withTitleFont:(NSInteger)font
                             withTitleWidth:(CGFloat)width
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineHigh];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    
    label.attributedText = attributedString;
    label.lineBreakMode = NSLineBreakByTruncatingTail;//重新设置，防止超出不显示省略号
    
    CGSize labSize = [title boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    [label sizeToFit];
    CGSize labelSize = [label sizeThatFits:labSize];
    return labelSize;
}

// 传内容string和字体大小，计算行数
+ (CGFloat)getLineNum:(NSString*)str
                 font:(NSInteger)font
           labelWidth:(CGFloat)width
{
    if (str.length<1) {
        return 0;
    }
    CGFloat oneRowHeight = [@"占位" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}].height;
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    CGFloat rows = textSize.height / oneRowHeight;
    return rows;
}

//获取文本尺寸
+ (CGSize)getSizeString:(NSString *)string font:(NSInteger)font {
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
