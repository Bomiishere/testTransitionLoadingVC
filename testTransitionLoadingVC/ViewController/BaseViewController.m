//
//  BaseViewController.m
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/25.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "UIViewController+Transition.h"
#import "BaseViewController.h"
#import "ViewController2.h"
#import "WebViewController.h"
#import "ErrorMessageViewController.h"
#import "LoadingViewController.h"
#import "RequestDataViewController.h"

@interface BaseViewController ()
@property (weak, nonatomic) IBOutlet UIButton *presentButton;
@property (weak, nonatomic) IBOutlet UIButton *pushButton;
@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UIButton *pushLoadButton;
@property (weak, nonatomic) IBOutlet UIButton *naviStackButton;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.presentButton addTarget:self action:@selector(presentButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.pushButton addTarget:self action:@selector(pushButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.loadButton addTarget:self action:@selector(loadButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.pushLoadButton addTarget:self action:@selector(pushLoadButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.naviStackButton addTarget:self action:@selector(naviStackButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)presentButtonTapped {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewController2 *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController2"];
    RequestDataViewController *vc = [[RequestDataViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{}];
}

- (void)pushButtonTapped {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController2 *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController2"];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 Example for push Web View Controllers.
 */
- (void)loadButtonTapped {
    WebViewController *vc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 Example for push view controllers with send a request to server.
 //https://works.ioa.tw/weather/api/all.json
 */
- (void)pushLoadButtonTapped {
    RequestDataViewController *vc = [[RequestDataViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)naviStackButtonTapped {
    [self setNavigationControllersWithNames:@[@"ErrorMessage", @"Web", @"Base", @"URL"]];
}

@end
