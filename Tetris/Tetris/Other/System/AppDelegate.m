//
//  AppDelegate.m
//  Tetris
//
//  Created by QSP on 2018/8/26.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "QSPNavigationController.h"
#import "TeachViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:K_Screen_Bounds];
    if (!K_PublicInformation.noFirst) {
        K_PublicInformation.noFirst = YES;
        K_PublicInformation.tetrisType = TetrisTypeReverse;
        K_PublicInformation.sound = YES;
        TeachViewController *nextCtr = [TeachViewController controllerWithVM:[TeachVM teachVMWithType:TeachVMTypeTap]];
        QSPNavigationController *navCtr = [[QSPNavigationController alloc] initWithRootViewController:nextCtr];
        self.window.rootViewController = navCtr;
    } else {
        [self gotoMainController];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)gotoMainController {
    QSPNavigationController *navCtr = [[QSPNavigationController alloc] initWithRootViewController:[MainViewController controllerWithVM:[[MainVM alloc] init]]];
    [navCtr.navigationBar setBackgroundImage:[UIImage imageWithColor:K_RGBColor(58,61,65) andSize:CGSizeMake(K_Screen_Width, K_NavBarHeight)] forBarMetrics:UIBarMetricsDefault];
    [navCtr.navigationBar setTitleTextAttributes:@{NSFontAttributeName: K_SystemBoldFont(19), NSForegroundColorAttributeName: K_GrayColor(254)}];
    [navCtr.navigationBar setShadowImage:nil];
    navCtr.returnImage = [UIImage imageNamed:@"return_key"];
    self.window.rootViewController = navCtr;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
