//
//  ViewController+UIView_Transition.h
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/22.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "ViewController.h"

typedef enum APIResult {
    APIResultSucceed,
    APIResultFailure
} APIResult;

@interface UIViewController (UIViewController_Transition)

- (void)transitionTo:(UIViewController *)child;
- (void)transitionTo: (UIViewController *)child completion:(void (^)(BOOL finished))completion;
//- (void)loadingVCWithURL: (NSString *)url;
- (void)loadingVCWithURL: (NSString *)url completion:(void (^)(APIResult result))completion;
- (void)getDataWithURL: (NSString *)url completion: (void (^)(APIResult result, NSData *data))completion;
- (void)setNavigationControllersWithNames: (NSArray *)array;
@end
