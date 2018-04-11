//
//  GenerateArchitectureViewController.m
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/22.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "GenerateArchitectureViewController.h"
#import "ViewController.h"
#import "UIViewController+Transition.h"
#import "LoadingViewController.h"
#import "ErrorMessageViewController.h"
#import "URLViewController.h"

@interface GenerateArchitectureViewController ()<ErrorMessageViewControllerDelegate>

@end

@implementation GenerateArchitectureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewController *startvc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
//    [self transitionTo:startvc];
    
    ErrorMessageViewController *errVC = [[ErrorMessageViewController alloc] initWithNibName:@"ErrorMessageViewController" bundle:nil message:@"Failure loading"];
    errVC.delegate = self;
    [self transitionTo:errVC];
}

- (void)loadArchitechture: (UIViewController *)vc {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoadingViewController *loadingvc = [sb instantiateViewControllerWithIdentifier:@"LoadingViewController"];
    
    [self transitionTo:loadingvc completion:^(BOOL finished) {
        
        [self loadingVCWithURL:@"http://youtube.com" completion:^(APIResult result) {
            
            if (result == APIResultSucceed) {
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                URLViewController *vc = [sb instantiateViewControllerWithIdentifier:@"URLViewController"];
                [self transitionTo:vc];
                
            } else if (result == APIResultFailure) {
                
                ErrorMessageViewController *errVC = [[ErrorMessageViewController alloc] initWithNibName:@"ErrorMessageViewController" bundle:nil message:@"Second failure loading"];
                errVC.delegate = self;
                [self transitionTo:errVC];
                
            }
        }];
    }];
}

- (void)tryConnectAgianInMessageViewController:(id)viewController {
    [self loadArchitechture:viewController];
}


@end
