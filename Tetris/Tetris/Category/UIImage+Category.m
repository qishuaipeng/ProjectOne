//
//  UIImage+Category.m
//  JDZBorrower
//
//  Created by QSP on 2018/4/9.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color andSize:CGSizeMake(1, 1)];
}
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    //CGRect rect = CGRectMake(0, 0, CGFLOAT_MIN + 1, CGFLOAT_MIN + 1);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
- (UIImage *)changeTosize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
+ (UIImage *)dottedLineWithSize:(CGSize)size horizontal:(BOOL)horizontal color:(UIColor *)color phase:(CGFloat)phase lengths:(NSArray<NSNumber *> *)lengths {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (horizontal) {
        CGContextMoveToPoint(context, 0, size.height/2.0);
        CGContextAddLineToPoint(context, size.width, size.height/2.0);
        CGContextSetLineWidth(context, size.width);
    } else {
        CGContextMoveToPoint(context, size.width/2.0, 0);
        CGContextAddLineToPoint(context, size.width/2.0, size.height);
        CGContextSetLineWidth(context, size.height);
    }
    /*
     CGContextRef c：图形上下文,
     CGFloat phase：相位,
     const CGFloat *lengths：虚实相间的像素点（c语言的数组）,
     size_t count：lengths数组中元素个数
     */
    CGFloat fLengths[lengths.count - 1];
    for (NSNumber *value in lengths) {
        fLengths[[lengths indexOfObject:value]] = (CGFloat)[value floatValue];
    }
    CGContextSetLineDash(context, phase, fLengths, lengths.count);
    [color setStroke];
    CGContextStrokePath(context);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
- (UIImage *)stretch {
    return [self stretchFromLeft:0.5 fromTop:0.5];
}
- (UIImage *)stretchFromLeft:(float)left fromTop:(float)top {
    CGFloat imageW = self.size.width*left;
    CGFloat imageH = self.size.height*top;
    
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW)];
}
- (UIImage *)roundCornerWithRadius:(CGFloat)radius {
    return [self roundCornerWithRadius:radius strokeColor:nil strokeWidth:0];
}
- (UIImage *)roundCornerWithRadius:(CGFloat)radius strokeColor:(UIColor *)color strokeWidth:(CGFloat)width {
    //1.开启一个基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //2.创建裁剪路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:radius];
    //3.裁剪
    [path addClip];
    //4.画图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //5.描边
    if (color) {
        UIBezierPath *strokePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:radius];
        [color setStroke];
        [strokePath setLineWidth:width*2];
        [strokePath stroke];
    }
    //6.取图
    UIImage *endImage = UIGraphicsGetImageFromCurrentImageContext();
    //7.结束上下文
    UIGraphicsEndImageContext();
    
    return endImage;
}
- (UIImage *)roundCornerWithScale:(CGFloat)scale {
    return [self roundCornerWithRadius:self.size.width > self.size.height ? self.size.height/2.0*scale : self.size.width/2.0*scale];
}
- (UIImage *)roundCornerWithScale:(CGFloat)scale strokeColor:(UIColor *)color strokeWidth:(CGFloat)width {
    return [self roundCornerWithRadius:self.size.width > self.size.height ? self.size.height/2.0*scale : self.size.width/2.0*scale strokeColor:color strokeWidth:width];
}

@end

/**
 UIImageView (Category)
 */
@implementation UIImageView (Category)

//提示无数据图片
+ (UIImageView *)imageRemindWithOutDataWithFrame:(CGRect)frame {
    
    UIImageView * remindImage = [[UIImageView alloc]initWithFrame:frame];
    remindImage.hidden = NO;
    remindImage.image = [UIImage imageNamed:@"img_data"];
    return remindImage;
}

@end
