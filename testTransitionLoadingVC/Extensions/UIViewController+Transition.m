//
//  ViewController+UIView_Transition.m
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/22.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "UIViewController+Transition.h"
#import "ViewController2.h"
#import "URLViewController.h"
#import "LoadingViewController.h"
#import "WebViewController.h"
#import "ErrorMessageViewController.h"

#define ANIMATION_DURATION 0.3

//typedef void (^completion) (BOOL success);

@implementation UIViewController (UIViewController_Transition)

/*
 Kinds of Way to Present ViewController
 */

#pragma mark - Public

/**
 set navigation controllers with names,
 ex: @["NewMain", "URL", "NTTransferConfirm"]
 */
- (void)setNavigationControllersWithNames: (NSArray *)array {
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    [vcArray addObject:self.navigationController.viewControllers[0]];
    for (NSString *vcName in array) {
        UIViewController *vc = [self initialViewControllerWithName:vcName];
        if (vc) {
            [vcArray addObject:vc];
        }
    }
    [[self navigationController] setViewControllers:vcArray animated:YES];
}

#pragma mark - Private

/**
 Put initial view controllers method together, in order to categorize.
 ex:
 input string = @"NewMain"
 returns NewMainViewController
 */
- (id)initialViewControllerWithName: (NSString *)name {
    NSString *vcName = [name stringByAppendingString:@"ViewController"];
    
    if ([vcName isEqualToString:@"ViewController2"] ||
        [vcName isEqualToString:@"URLViewController"] ||
        [vcName isEqualToString:@"ViewController"] ||
        [vcName isEqualToString:@"LoadingViewController"]
        ) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:vcName];
        return vc;
    } else if ([vcName isEqualToString:@"ErrorMessageViewController"]) {
        ErrorMessageViewController *vc = [[ErrorMessageViewController alloc] initWithNibName:vcName bundle:nil];
        return vc;
    } else if ([vcName isEqualToString:@"WebViewController"]) {
        WebViewController *vc = [[WebViewController alloc] initWithNibName:vcName bundle:nil];
        return vc;
    }
    return nil;
}

/*
 From Dave Delong
 */

-(void)transitionTo:(UIViewController *)child {
    [self transitionTo:child completion:nil];
}
-(void)transitionTo: (UIViewController *)child completion:(void (^)(BOOL finished))completion {
    UIViewController *current = (UIViewController *)self.childViewControllers.lastObject;
    [self addChildViewController:child];
    
    UIView *newView = child.view;
    newView.translatesAutoresizingMaskIntoConstraints = YES;
    newView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    newView.frame = CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame), 0, 0);
    newView.frame = self.view.bounds;
    
    if (current == nil) {
        [self.view addSubview:newView];
        
        [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        } completion:^(BOOL finished) {
            [child didMoveToParentViewController:self];
            if (completion) {
                completion(finished);
            };
        }];
    } else {
        [self willMoveToParentViewController:nil];
        
        [self transitionFromViewController:current toViewController:child duration:ANIMATION_DURATION options:UIViewAnimationOptionTransitionCrossDissolve animations:^{} completion:^(BOOL finished) {
            [child didMoveToParentViewController:self];
            if (completion) {
                completion(finished);
            };
        }];
    }
    [self addChildViewController:child];
}

- (void)loadingVCWithURL: (NSString *)url completion:(void (^)(APIResult result))completion {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 2.1;
    config.timeoutIntervalForResource = 2.2;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:NSOperationQueue.mainQueue];
    NSURLSessionTask *task = [session dataTaskWithURL:[[NSURL alloc] initWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(APIResultFailure);
            return;
        }
        completion(APIResultSucceed);
    }];
    [task resume];
}

- (void)getDataWithURL: (NSString *)url completion: (void (^)(APIResult result, NSData *data))completion {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 2.1;
    config.timeoutIntervalForResource = 2.2;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:NSOperationQueue.mainQueue];
    NSURLSessionTask *task = [session dataTaskWithURL:[[NSURL alloc] initWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(APIResultFailure, nil);
            return;
        }
        
        //TODO: handle data
//        NSLog(@"&%@", data);
        
        completion(APIResultSucceed, data);
    }];
    [task resume];
}

@end
