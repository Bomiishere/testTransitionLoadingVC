//
//  AppDelegate.m
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/22.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "AppDelegate.h"
#import "GenerateArchitectureViewController.h"
#import "LandingViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController *navVC = [[UINavigationController alloc] init];
    LandingViewController *landingVC = [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];
    [navVC setViewControllers:@[landingVC]];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = navVC;
    
    return YES;
}

@end
