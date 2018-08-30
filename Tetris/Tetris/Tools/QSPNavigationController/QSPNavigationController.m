//
//  QSPNavigationController.m
//  QSPNavigationCotroller_Demo
//
//  Created by QSP on 2017/6/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "QSPNavigationController.h"
#import <objc/runtime.h>

//屏幕宽度
#define K_QSPNAV_SreenWith                          [UIScreen mainScreen].bounds.size.width
//状态栏类型
#define K_QSPNAV_StatusBarStyle                     UIStatusBarStyleLightContent
//canSlidingBack属性名称
//QSP_Delegate属性名称
#define K_QSPNAV_CanSlidingBack_Key                 "canSlidingBack"
#define K_QSPNAV_QSP_Delegate_Key                   "QSP_Delegate"
//导航栏背景图片
//#define K_QSPNAV_BarBackgoundImage                  [UIImage imageNamed:@"navigation_bar"]
//导航栏tintColor
#define K_QSPNAV_BarTintColor                       [UIColor whiteColor]
//导航栏标题字体大小
#define K_QSPNAV_BarTitleFont                       [UIScreen mainScreen].bounds.size.width > 320 ? [UIFont systemFontOfSize:20] : [UIFont systemFontOfSize:17]
//导航栏标题颜色
#define K_QSPNAV_BarTitleColor                      [UIColor blackColor]
//导航栏item字体大小
#define K_QSPNAV_ItemTitleFont                      [UIFont systemFontOfSize:K_QSPNAV_SreenWith > 320 ? 17 : 15]
//导航栏item文字normal状态下颜色
#define K_QSPNAV_ItemTitleColor_Normal              [UIColor whiteColor]
//导航栏item文字highlighted状态下颜色
#define K_QSPNAV_ItemTitleColor_Highlighted         [UIColor lightGrayColor]
//导航栏item文字disabled状态下颜色
#define K_QSPNAV_ItemTitleColor_Disabled            [UIColor grayColor]

@implementation QSPDelegateObject

@end

@implementation UIBarButtonItem (QSPCategory)

+ (UIBarButtonItem *)customBarButtonItemWithTitle:(NSString *)title titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor highTitleColor:(UIColor *)highTitleColor  imageName:(NSString *)imageName highImageName:(NSString *)highImageName isLeft:(BOOL)left isRight:(BOOL)right taget:(id)taget andAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleFont) {
        [button.titleLabel setFont:titleFont];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (highTitleColor) {
        [button setTitleColor:highTitleColor forState:UIControlStateHighlighted];
    }
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (highImageName) {
        [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    }
    CGFloat offset = K_QSPNAV_SreenWith > 375 ? 12 : 8;
    if (imageName || highImageName) {
        CGRect rect = (CGRect){CGPointZero,button.currentImage.size};
        button.frame = rect;
        if (left) {
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, -offset, 0, offset)];
        }
        else if (right) {
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, offset, 0, -offset)];
        }
    }
    if (title) {
        button.frame = (CGRect){CGPointZero, [button.currentTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: button.titleLabel.font} context:nil].size};
        if (left) {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -offset, 0, offset)];
        }
        else if (right) {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, offset, 0, -offset)];
        }
    }
    if (taget && action) {
        [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+ (UIBarButtonItem *)systemBarButtonItemWithTitle:(NSString *)title taget:(id)taget andAction:(SEL)action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:taget action:action];
    
    return item;
}
+ (UIBarButtonItem *)systemBarButtonItemWithImage:(UIImage *)image taget:(id)taget andAction:(SEL)action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:taget action:action];
    
    return item;
}

@end


@implementation UINavigationController (QSPCategory)

- (BOOL)canSlidingReturn
{
    return [objc_getAssociatedObject(self, K_QSPNAV_CanSlidingBack_Key) boolValue];
}
- (void)setCanSlidingReturn:(BOOL)canSlidingBack
{
    objc_setAssociatedObject(self, K_QSPNAV_CanSlidingBack_Key, @(canSlidingBack), OBJC_ASSOCIATION_ASSIGN);
}
- (id)QSP_Delegate
{
    QSPDelegateObject *obj = objc_getAssociatedObject(self, K_QSPNAV_QSP_Delegate_Key);
    return obj.QSP_Delegate;
}
- (void)setQSP_Delegate:(id)QSP_Delegate
{
    QSPDelegateObject *obj = [[QSPDelegateObject alloc] init];
    obj.QSP_Delegate = QSP_Delegate;
    objc_setAssociatedObject(self, K_QSPNAV_QSP_Delegate_Key, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@interface QSPNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic)UIViewController *currentShowVC;

@end

@implementation QSPNavigationController

#define mark - 控制器生命周期
- (UIButton *)returnButton {
    if (_returnButton == nil) {
        _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnButton setFrame:CGRectMake(0, 0, 44, 44)];
        [_returnButton setImage:self.returnImage forState:UIControlStateNormal];
        [_returnButton.imageView setContentMode:UIViewContentModeLeft];
        [_returnButton addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
        _returnButton.exclusiveTouch = YES;
    }
    
    return _returnButton;
}
/**
 第一次使用这个类的时候调用（一个类只调用一次）
 */
+ (void)initialize
{
    //1.设置导航栏主题
    [self settingNavigationBarTheme];
    
    //2.设置导航栏按钮主题
    [self settingNavigationBarItemTheme];
}
/**
 设置状态栏类型

 @return 状态栏类型
 */
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return K_QSPNAV_StatusBarStyle;
//}
- (instancetype)init
{
    if (self = [super init]) {
        [self initSetting];
    }
    
    return self;
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self initSetting];
    }
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initSetting];
    }
    
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initSetting];
    }
    
    return self;
}
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
- (void)initSetting
{
    self.canSlidingReturn = YES;
    self.returnImage = [UIImage imageNamed:@"nav_return"];
}
- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    if (self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass]) {
        self.canSlidingReturn = YES;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
    self.delegate = self;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (!self.canSlidingReturn) {
        return self.canSlidingReturn;
    }
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return self.currentShowVC == self.topViewController;
    }
    
    return YES;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
        if (self.viewControllers.count == 1) {
            [self.navigationBar addSubview:self.returnButton];
        }
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count == 1) {
        self.currentShowVC = nil;
        if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    else
    {
        self.currentShowVC = viewController;
        if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

#pragma mark - 触摸手势方法
- (void)backItemAction:(UIButton *)sender
{
    id delegate = self.QSP_Delegate;
    if ([delegate respondsToSelector:@selector(navigationControllerAfterReturn:)]) {
        [delegate navigationControllerAfterReturn:self];
    }
    else
    {
        [self popViewControllerAnimated:YES];
    }
}
+ (UIImage *)image:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImg;
}
+ (void)settingNavigationBarTheme
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
//    UIImage *image = [UIImage imageNamed:@"navigation_bar"];
//    [navigationBar setBackgroundImage:[self image:image toSize:CGSizeMake(K_QSPNAV_SreenWith, image.size.height)] forBarMetrics:UIBarMetricsDefault];
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame = CGRectMake(0, 0, K_QSPNAV_SreenWith, 64);
//    imageView.image = K_QSPNAV_BarBackgoundImage;
//    [navigationBar insertSubview:imageView atIndex:0];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: K_QSPNAV_BarTitleColor, NSFontAttributeName: K_QSPNAV_BarTitleFont}];
    [navigationBar setTintColor:K_QSPNAV_BarTintColor];
}
+ (void)settingNavigationBarItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = K_QSPNAV_ItemTitleColor_Disabled;
    textAttrs[NSShadowAttributeName] = nil;
    textAttrs[NSFontAttributeName] = K_QSPNAV_ItemTitleFont;
    [item setTitleTextAttributes:textAttrs forState:UIControlStateDisabled];
    
    textAttrs[NSForegroundColorAttributeName] = K_QSPNAV_ItemTitleColor_Normal;
    textAttrs[NSShadowAttributeName] = nil;
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    textAttrs[NSForegroundColorAttributeName] = K_QSPNAV_ItemTitleColor_Highlighted;
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
}

/**
 根据颜色获取图片

 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, CGFLOAT_MIN + 1, CGFLOAT_MIN + 1);
    
    return [self imageFromColor:color andFrame:rect];
}

+ (UIImage *)imageFromColor:(UIColor *)color andFrame:(CGRect)frame
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
