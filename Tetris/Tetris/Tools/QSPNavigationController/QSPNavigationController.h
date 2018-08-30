//
//  QSPNavigationController.h
//  QSPNavigationCotroller_Demo
//
//  Created by QSP on 2017/6/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (QSPCategory)

+ (UIBarButtonItem *)customBarButtonItemWithTitle:(NSString *)title titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor highTitleColor:(UIColor *)highTitleColor  imageName:(NSString *)imageName highImageName:(NSString *)highImageName isLeft:(BOOL)left isRight:(BOOL)right taget:(id)taget andAction:(SEL)action;
+ (UIBarButtonItem *)systemBarButtonItemWithTitle:(NSString *)title taget:(id)taget andAction:(SEL)action;
+ (UIBarButtonItem *)systemBarButtonItemWithImage:(UIImage *)image taget:(id)taget andAction:(SEL)action;

@end

@class QSPNavigationController;
@protocol QSPNavigationControllerDelegate <NSObject>

- (void)navigationControllerAfterReturn:(QSPNavigationController *)controller;

@end

@interface UINavigationController (QSPCategory)

@property (assign, nonatomic) BOOL canSlidingReturn;
@property (weak, nonatomic) id<QSPNavigationControllerDelegate> QSP_Delegate;

@end

@interface QSPNavigationController : UINavigationController

@property (strong, nonatomic) UIImage *returnImage;
@property (strong, nonatomic) UIButton *returnButton;

@end

@interface QSPDelegateObject: NSObject

@property (weak, nonatomic) id<QSPNavigationControllerDelegate> QSP_Delegate;

@end
