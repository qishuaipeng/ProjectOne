//
//  QSPKeyboardManager.m
//  JDZBorrower
//
//  Created by QSP on 2018/4/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPKeyboardManager.h"

static QSPKeyboardManager *_shareInstance;

@implementation QSPKeyboardObj

+ (instancetype)keyboardWithViewController:(UIViewController<QSPKeyboardManagerDelegate> *)controller {
    return [[self alloc] initWithViewController:controller];
}
- (instancetype)initWithViewController:(UIViewController<QSPKeyboardManagerDelegate> *)controller {
    if (self = [super init]) {
        _controller = controller;
    }
    
    return self;
}

@end

@interface QSPKeyboardManager ()

@property (strong, nonatomic) NSMutableArray *controllers;

@end

@implementation QSPKeyboardManager

- (void)dealloc {
    [K_Default_NotificationCenter removeObserver:self];
}
- (NSMutableArray *)controllers {
    if (_controllers == nil) {
        _controllers = [NSMutableArray arrayWithCapacity:1];
        [K_Default_NotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [K_Default_NotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return _controllers;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [super allocWithZone:zone];
    });
    
    return _shareInstance;
}
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc] init];
    });
    
    return _shareInstance;
}
+ (void)addViewController:(UIViewController<QSPKeyboardManagerDelegate> *)controller {
    QSPKeyboardManager *manager = [self manager];
    [manager.controllers addObject:[QSPKeyboardObj keyboardWithViewController:controller]];
}

- (void)keyboardWillShow:(NSNotification *)sender {
    [self keyboardChange:sender show:YES];
}
- (void)keyboardWillHide:(NSNotification *)sender {
    [self keyboardChange:sender show:NO];
}

- (void)keyboardChange:(NSNotification *)notification show:(BOOL)show {
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
    for (QSPKeyboardObj *obj in self.controllers) {
        if (obj.controller && [obj.controller isKindOfClass:[UIViewController class]]) {
            [self transform:obj notification:notification show:show];
        } else {
            [mArr addObject:obj];
        }
    }
    
    [self.controllers removeObjectsInArray:mArr];
}
- (void)transform:(QSPKeyboardObj *)keyboard notification:(NSNotification *)notification show:(BOOL)show {
    UIView *firstView = [ConFunc firstResponderFrom:keyboard.controller.view];
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[firstView convertRect:firstView.bounds toView:window];
    CGFloat distance = rect.origin.y + rect.size.height - [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    if ([keyboard.controller respondsToSelector:@selector(keyboardChangeShow:distance:)]) {
        [keyboard.controller keyboardChangeShow:show distance:distance];
    } else {
        //首尾式动画
        [UIView beginAnimations:nil context:nil];
        //设置动画时间
        [UIView setAnimationDuration:[[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
        //设置动画节奏
        [UIView setAnimationCurve:[[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]];
        if (show) {
            if (distance > 0)
                keyboard.controller.view.transform = CGAffineTransformMakeTranslation(0, -(distance + 10));
        } else {
            keyboard.controller.view.transform = CGAffineTransformIdentity;
        }
        
        [UIView commitAnimations];
    }
}

@end
