//
//  ConFunc.m
//  JDZBorrower
//
//  Created by QSP on 2018/4/9.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "ConFunc.h"
#import <UIKit/UIKit.h>

@implementation ConFunc

+ (BOOL)blankOfStr:(NSString *)str {
    if (str == nil || str == NULL)
        return YES;
    
    if ([str isKindOfClass:[NSNull class]])
        return YES;
    
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        return YES;
    
    return NO;
}
+ (void)deleteCookies {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
}
+ (NSString *)currentApplicationVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}
+ (UIView *)firstResponderFrom:(UIView *)view {
    if (view.isFirstResponder) {
        return view;
    } else {
        for (UIView *theView in view.subviews) {
            UIView *first = [self firstResponderFrom:theView];
            if (first) {
                return first;
            }
        }
    }
    
    return nil;
}
+ (UIImage *)elementImage {
    return [self elementImageWithColor:K_TetrisForeColor];
}
+ (UIImage *)elementImageWithColor:(UIColor *)color {
    CGFloat SW = K_TetrisElementW;
    CGFloat SH = K_TetrisElementW;
    CGFloat scale = 0.6;
    UIGraphicsBeginImageContext(CGSizeMake(K_TetrisElementW, K_TetrisElementW));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat W = (int)(SW*scale);
    CGFloat H = W;
    CGFloat X = (SW - W)/2.0;
    CGFloat Y = (SH - H)/2.0;
    CGContextAddRect(context, CGRectMake(X, Y, W, H));
    [color setFill];
    [color setStroke];
    CGContextFillPath(context);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, SW, SH) cornerRadius:0];//(1 - scale)*SW/2.0
    path.lineWidth = (int)(SW*0.2);
    [path stroke];
    
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnImage;
}

+ (UIImage *)image:(UIImage *)image andAlpha:(CGFloat )alpha {
    UIGraphicsBeginImageContext(image.size);
    [image drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:alpha];
    
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnImage;
}

@end
