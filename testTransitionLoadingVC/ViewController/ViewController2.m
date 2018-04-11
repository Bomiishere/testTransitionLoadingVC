//
//  ViewController2.m
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/22.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController.h"
#import "UIViewController+Transition.h"
#import "URLViewController.h"
#import "LoadingViewController.h"
#import "ErrorMessageViewController.h"

@interface ViewController2 ()<ErrorMessageViewControllerDelegate>

@end

@implementation ViewController2

- (IBAction)generateRandomVCTapped:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoadingViewController *loadingvc = [sb instantiateViewControllerWithIdentifier:@"LoadingViewController"];
    
    [self transitionTo:loadingvc completion:^(BOOL finished) {
        
        [self loadingVCWithURL:@"http://youtube.com" completion:^(APIResult result) {

            if (result == APIResultSucceed) {

                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                URLViewController *vc = [sb instantiateViewControllerWithIdentifier:@"URLViewController"];
                [self transitionTo:vc];
                
            } else if (result == APIResultFailure) {
                
                ErrorMessageViewController *errVC = [[ErrorMessageViewController alloc] initWithNibName:@"ErrorMessageViewController" bundle:nil message:@"Failure loading"];
                errVC.delegate = self;
                [self transitionTo:errVC];
             
            }
        }];
    }];
}

- (IBAction)backVC1Tapped:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController2 *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
    [self transitionTo:vc];
}

- (void)tryConnectInMessageViewController:(id)viewController {
    [self generateRandomVCTapped:nil];
}

@end
