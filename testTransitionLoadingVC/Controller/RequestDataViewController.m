//
//  RequestDataViewController.m
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/29.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "RequestDataViewController.h"
#import "LoadingViewController.h"
#import "UIViewController+Transition.h"
#import "ErrorMessageViewController.h"
#import "DisplayDataViewController.h"

@interface RequestDataViewController ()<displayDataViewControllerDelegate ,ErrorMessageViewControllerDelegate>

@end

@implementation RequestDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadViewController];
}

- (void)updateDataViewController:(UIViewController *)viewController {
    [self reloadViewController];
}

- (void)tryConnectAgianInMessageViewController:(UIViewController *)viewController {
    [self reloadViewController];
}

- (void)reloadViewContorllerWithLoadingIndicator {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoadingViewController *loadingvc = [sb instantiateViewControllerWithIdentifier:@"LoadingViewController"];
    
    [self transitionTo:loadingvc completion:^(BOOL finished) {
        [self reloadViewController];
    }];
}

- (void)reloadViewController {
    [self getDataWithURL:@"https://works.ioa.tw/weather/api/all.json" completion:^(APIResult result, NSData *data) {
        if (result == APIResultSucceed) {
            
            NSMutableArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableString *idStr = [NSMutableString string];
            NSMutableString *cityStr = [NSMutableString string];
            NSLog(@"%@", dataArray);
            for (NSDictionary *dic in dataArray) {
                NSString *dicid = [dic objectForKey:@"id"];
                [idStr appendString:dicid];
                NSString *diccity = [dic objectForKey:@"name"];
                [cityStr appendString:diccity];
                [cityStr appendString:@"\n"];
            }
            
            DisplayDataViewController *displayVC = [[DisplayDataViewController alloc] initWithNibName:@"DisplayDataViewController" bundle:nil message: cityStr];
            displayVC.delegate = self;
            [self transitionTo:displayVC];
            
        } else if (result == APIResultFailure) {
            
            ErrorMessageViewController *errVC = [[ErrorMessageViewController alloc] initWithNibName:@"ErrorMessageViewController" bundle:nil message:@"Failure loading"];
            errVC.delegate = self;
            [self transitionTo:errVC];
            
        }
    }];
}

//- (void)reloadViewControllerF {
//    [self getDataWithURL:@"https://works.iodsfasa.tw/weather/api/all.json" completion:^(APIResult result, NSData *data) {
//        if (result == APIResultSucceed) {
//
//            NSMutableArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSMutableString *idStr = [NSMutableString string];
//            NSMutableString *cityStr = [NSMutableString string];
//
//            for (NSDictionary *dic in dataArray) {
//                NSString *dicid = [dic objectForKey:@"id"];
//                [idStr appendString:dicid];
//                NSString *diccity = [dic objectForKey:@"name"];
//                [cityStr appendString:diccity];
//            }
//            DisplayDataViewController *displayVC = [[DisplayDataViewController alloc] initWithNibName:@"DisplayDataViewController" bundle:nil message: cityStr];
//            displayVC.delegate = self;
//            [self transitionTo:displayVC];
//
//        } else if (result == APIResultFailure) {
//
//            ErrorMessageViewController *errVC = [[ErrorMessageViewController alloc] initWithNibName:@"ErrorMessageViewController" bundle:nil message:@"Second failure loading"];
//            errVC.delegate = self;
//            [self transitionTo:errVC];
//
//        }
//    }];
//}
//
//- (void)reloadFailViewContorller {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    LoadingViewController *loadingvc = [sb instantiateViewControllerWithIdentifier:@"LoadingViewController"];
//
//    [self transitionTo:loadingvc completion:^(BOOL finished) {
//        [self getDataWithURL:@"https://wodsfsrks.ioa.tw/weather/api/all.json" completion:^(APIResult result, NSData *data) {
//            if (result == APIResultSucceed) {
//
//                NSMutableArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                //                NSLog(@"%@", dataArray);
//
//                NSMutableString *idStr = [NSMutableString string];
//                NSMutableString *cityStr = [NSMutableString string];
//
//                for (NSDictionary *dic in dataArray) {
//                    NSString *dicid = [dic objectForKey:@"id"];
//                    [idStr appendString:dicid];
//                    NSString *diccity = [dic objectForKey:@"name"];
//                    [cityStr appendString:diccity];
//                }
//                DisplayDataViewController *displayVC = [[DisplayDataViewController alloc] initWithNibName:@"DisplayDataViewController" bundle:nil message: cityStr];
//                displayVC.delegate = self;
//                [self transitionTo:displayVC];
//
//            } else if (result == APIResultFailure) {
//
//                ErrorMessageViewController *errVC = [[ErrorMessageViewController alloc] initWithNibName:@"ErrorMessageViewController" bundle:nil message:@"Failure loading"];
//                errVC.delegate = self;
//                [self transitionTo:errVC];
//            }
//        }];
//    }];
//}

@end

