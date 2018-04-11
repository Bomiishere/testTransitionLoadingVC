//
//  ErrorMessageViewController.h
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/24.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErrorMessageViewControllerDelegate<NSObject>
@required
- (void)tryConnectAgianInMessageViewController: (UIViewController *)viewController;
@end

@interface ErrorMessageViewController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil message: (NSString *)message;

@property (nonatomic, weak) id <ErrorMessageViewControllerDelegate> delegate;

@end
