//
//  CommonDefine.h
//  MiningInterestingly
//
//  Created by QSP on 2018/8/16.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#import "ConFunc.h"
#import "NSString+Category.h"
#import "UIImage+Category.h"
#import "UIView+Category.h"
#import "UIView+FrameAdjust.h"
#import "NSDate+Category.h"
#import "PublicInformation.h"

typedef NS_ENUM(NSInteger, TetrisVMType) {
    TetrisVMTypePrepare = 0, //准备状态（默认）
    TetrisVMTypePaused = 1, //已暂停
    TetrisVMTypePlaying = 2, //游戏中
    TetrisVMTypeOver = 3, //游戏结束
    TetrisVMTypeReset = 4, //重置
};

#define K_Screen_Bounds              [UIScreen mainScreen].bounds
#define K_Screen_Width               K_Screen_Bounds.size.width
#define K_Screen_Height              K_Screen_Bounds.size.height
#define K_StatusBar_Height           [[UIApplication sharedApplication] statusBarFrame].size.height


//状态栏高度
#define K_StatusHeight              (OSScreenIsAtiPhone5_8() ? 44.0f : 20.0f)
//iPhone X状态栏多出高度 44-20
#define K_StatusMoreHeight          (OSScreenIsAtiPhone5_8() ? 24.0f : 0.0f)
//导航条高度
#define K_NavBarHeight              (OSScreenIsAtiPhone5_8() ? 44.0f+44.0f : 44.0f+20.0f)
//底部tab高度
#define K_TabBarHeight              (OSScreenIsAtiPhone5_8() ? 83.0f : 49.0f)
//底部tab多出高度
#define K_TabBarMoreHeight          (OSScreenIsAtiPhone5_8() ? 83.0f-49.0f : 49.0f-49.0f)


#define K_ScreenScale_Y              (K_Screen_Height/667)
#define K_ScreenScale_X              (K_Screen_Width/375)
#define K_ScreenScale_Y_S              (K_Screen_Height > 667 ? 1 : K_Screen_Height/667)

#define K_TetrisElementW             ((int)((K_Screen_Width - 21)/16.4) > (int)((K_Screen_Height - K_StatusHeight - K_TabBarHeight - 14)/25.45) ? (int)((K_Screen_Height - K_StatusHeight - K_TabBarHeight - 14)/25.45) : (int)((K_Screen_Width - 21)/16.4))//(10.0*K_ScreenScale_Y)//(K_Screen_Height == 480 ? 8.0 : K_Screen_Height == 568 ? 10.0 : K_Screen_Height == 667 ? 12.0 : K_Screen_Height == 736 ? 14.0 : 16.0)
#define K_TetrisSpacing              (K_TetrisElementW*0.15)
#define K_TetrisCount_H              10
#define K_TetrisCount_V              22
#define K_Tetris_PreviewCount        4

#define K_ScreenScale_Y              (K_Screen_Height/667)
#define K_ScreenScale_X              (K_Screen_Width/375)


#define K_ControllerView_Color      [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]
#define K_RandomColor          [UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1.0f]
#define K_GrayColor(value)          [UIColor colorWithRed:value/255.0f green:value/255.0f blue:value/255.0f alpha:1.0f]
#define K_GrayAlphaColor(value, a)          [UIColor colorWithRed:value/255.0f green:value/255.0f blue:value/255.0f alpha:a/1.0f]
#define K_RGBColor(r, g, b)         [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define K_RGBAColor(r, g, b, a)         [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/1.0f]

#define K_TetrisBackColor               @"FFFFFF".generateColor
#define K_TetrisForeColor               @"010601".generateColor//@"ff00f6".generateColor//

#define K_PublicInformation          [PublicInformation shareInstance]
#define K_User_Defaults              [NSUserDefaults standardUserDefaults]
#define K_Default_NotificationCenter        [NSNotificationCenter defaultCenter]
#define K_ShapeM_NextNotificationName       @"K_ShapeM_NextNotificationName"

/**
 系统文字文字大小
 
 @param size 大小
 @return UIFont
 */
#define K_GBFont(size)              [UIFont systemFontOfSize:size]//[UIFont fontWithName:@"FZLTTHJW--GB1-0" size:size]
#define K_SystemFont(size)          [UIFont systemFontOfSize:size]
#define K_SystemBoldFont(size)      [UIFont boldSystemFontOfSize:size]


// 是否是iOS11以上
__attribute__((unused)) static BOOL OSVersionIsAtLeastiOS_11_0()
{
    if (@available(iOS 11.0, *)) {
        return YES;
    }
    return NO;
}

// 是否是iPhone5.8寸的屏幕
__attribute__((unused)) static BOOL OSScreenIsAtiPhone5_8()
{
    return CGRectGetHeight([[UIScreen mainScreen] bounds]) == 812.f;
}

// 是否是iPhone5.5寸的屏幕
__attribute__((unused)) static BOOL OSScreenIsAtiPhone5_5()
{
    return CGRectGetHeight([[UIScreen mainScreen] bounds]) == 736.f;
}

// 是否是iPhone4.7寸的屏幕
__attribute__((unused)) static BOOL OSScreenIsAtiPhone4_7()
{
    return CGRectGetHeight([[UIScreen mainScreen] bounds]) == 667.f;
}

// 是否是iPhone4.0寸的屏幕
__attribute__((unused)) static BOOL OSScreenIsAtiPhone4_0()
{
    return CGRectGetHeight([[UIScreen mainScreen] bounds]) == 568.f;
}

// 是否是iPhone3.5寸的屏幕
__attribute__((unused)) static BOOL OSScreenIsAtiPhone3_5()
{
    return CGRectGetHeight([[UIScreen mainScreen] bounds]) == 480.f;
}

#endif /* CommonDefine_h */
