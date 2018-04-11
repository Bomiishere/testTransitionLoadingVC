//
//  ViewController.m
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/22.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Transition.h"
#import "ViewController2.h"
#import "LoadingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)buttonTapped:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController2 *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController2"];
    [self transitionTo:vc];
}

- (void)loadAnotherArchitecture {
    [self transitionTo:[[LoadingViewController alloc] init] completion:^(BOOL finished) {
        NSLog(@"load architechure");
        [self loadArchitecture];
    }];
}

- (void)loadArchitecture {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
